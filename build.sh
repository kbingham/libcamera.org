#!/bin/bash

libcamera_git_url="git://git.linuxtv.org/libcamera.git"
libcamera_git_url="file://${PWD}/../libcamera"
libcamera_git_branch="doc"

html_dir=${PWD}/html
libcamera_dir=${PWD}/libcamera
site_dir=${PWD}/site

#
# Checkout libcamera
#

if [[ ! -d ${libcamera_dir} ]] ; then
	git clone "${libcamera_git_url}" "${libcamera_dir}"
fi

(
	cd "${libcamera_dir}"
	git fetch origin
	git reset --hard "${libcamera_git_branch}"
)

#
# Generate the HTML output
#

rm -rf "${html_dir}"
sphinx-build -b html "${site_dir}" "${html_dir}"

#
# Build the Doxygen output and move it to its destination
#

rm -rf "${libcamera_dir}/build"
mkdir "${libcamera_dir}/build"
(
	cd "${libcamera_dir}/build"
	meson ..
	ninja Documentation/api-html
)

rm -rf "${html_dir}/api-html"
mv "${libcamera_dir}/build/Documentation/api-html" "${html_dir}/"
