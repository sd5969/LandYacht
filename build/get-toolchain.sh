#!/bin/bash
TOOLCHAIN_URL=https://launchpadlibrarian.net/151487636/gcc-arm-none-eabi-4_7-2013q3-20130916-linux.tar.bz2

topdir=`pwd`/..
tmpdir=${topdir}/tmp
tooldir=${tmpdir}/toolchain

if [ ! -d ${tooldir} ]; then
    mkdir -p ${tooldir}
fi

echo "Fetching toolchain from ${TOOLCHAIN_URL}"
wget ${TOOLCHAIN_URL} -O ${tmpdir}/toolchain.tar.bz2

echo "Uncompressing toolchain archive to ${tooldir}"
tar xavf ${tmpdir}/toolchain.tar.bz2 --strip-components=1 -C ${tooldir}
