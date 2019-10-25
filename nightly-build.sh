#!/bin/bash

#
# libcamera.org nightly build script

#
set -e

branch=master
srcdir=$(mktemp -d)
log=$srcdir/build.log

cleanup() {
	rm -rf $srcdir
}

checkout() {
	mkdir -p $srcdir
	cd $srcdir
	git clone -b $branch git-libcamera-org@git.libcamera.org:libcamera/libcamera.org.git
}

compile() {
	cd libcamera.org
	./build.sh -w /var/www/libcamera.org/
}

report_error() {
	echo "libcamera nightly build failed" >&2
	cat $log >&2
}

trap "report_error; cleanup" EXIT
checkout >>$log 2>&1
compile >>$log 2>&1
trap - EXIT

cleanup
