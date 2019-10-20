#!/bin/bash

#
# Required packages:
#
# apt install doxygen g++ git-core ninja-build pkg-config python3-sphinx
# apt install -t stretch-backports meson
#

libcamera_git_url="git-libcamera-org@git.libcamera.org:libcamera/libcamera.git"

html_dir=${PWD}/html
libcamera_dir=${PWD}/libcamera
site_dir=${PWD}/site

cleanup() {
	if [[ "${keep}" == true && $1 != force ]] ; then
		return 0
	fi

	rm -rf "${html_dir}"
	rm -rf "${libcamera_dir}"
}

checkout_libcamera() {
	rm -rf "${libcamera_dir}"
	git clone -b "${libcamera_branch}" "${libcamera_url}" "${libcamera_dir}"
}

compile_doxygen() {
	rm -rf "${libcamera_dir}/build"
	mkdir "${libcamera_dir}/build"
	(
		cd "${libcamera_dir}/build"
		meson ..
		ninja Documentation/api-html
	)
}

compile_site() {
	sphinx-build -b html site/ "${html_dir}"
	rm -rf "${html_dir}/api-html"
	mv "${libcamera_dir}/build/Documentation/api-html" "${html_dir}/"
}

deploy() {
	rsync -avd \
		--exclude .doctrees \
		--exclude .buildinfo \
		--exclude objects.inv \
		"${html_dir}/" "${deploy_dir}"
}

parse_options() {
	deploy_dir=
	keep=false
	libcamera_branch="master"
	libcamera_url="${libcamera_git_url}"

	while [[ $# -ne 0 ]] ; do
		case $1 in
		-b|--branch)
			libcamera_branch="$2"
			shift 2
			;;
		-h|--help)
			return 1
			;;
		-k|--keep)
			keep=true
			shift
			;;
		-l|--libcamera)
			libcamera_url="$2"
			shift 2
			;;
		-w|--www)
			deploy_dir="$2"
			shift 2
			;;
		*)
			echo "Unsupported option $1" >&2
			return 1
			;;
		esac
	done

	# If not deployment directory is specified, keep the build artifacts
	# by default.
	if [[ -z "${deploy_dir}" ]] ; then
		keep=true
	fi
}

report_error() {
	echo "libcamera.org build failed" >&2
}

usage() {
	echo "Usage: $1 [options]" >&2
	echo "Supported options:" >&2
	echo "-b, --branch branch     libcamera branch name (default: master)" >&2
	echo "-h, --help              Display this help text" >&2
	echo "-w, --www dir           Deploy website to given directory" >&2
	echo "-k, --keep              Keep build artifacts" >&2
	echo "-l, --libcamera url     libcamera sources URL (default: ${libcamera_git_url}" >&2
}

parse_options "$@"

if [[ $? != 0 ]] ; then
	usage $0
	exit 1
fi

echo "Building libcamera.org website"
echo "libcamera: ${libcamera_url} ${libcamera_branch}"

if [[ ! -z ${deploy_dir} ]] ; then
	echo "www directory: ${deploy_dir}"
fi

set -e

trap "report_error; cleanup" EXIT

cleanup force
checkout_libcamera
compile_doxygen
compile_site

if [[ ! -z "${deploy_dir}" ]] ; then
	deploy
fi

trap - EXIT

cleanup
