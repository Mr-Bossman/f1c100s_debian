#! /bin/bash

cd u-boot

make clean
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make licheepi_nano_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j64
mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "boot script" -d ../configs/boot.cmd boot.scr

cd ..

cd linux

cp ../configs/linux_defconfig arch/arm/configs/linux_defconfig
cp ../dts/f1c100s_linux.dts arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
make clean

ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make linux_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j64 deb-pkg LOCALVERSION=-custom
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j64 LOCALVERSION=-custom
cd ..



