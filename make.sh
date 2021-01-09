#! /bin/bash

cd f1c100s-u-boot

cp ../configs/uboot_defconfig configs/uboot_defconfig
cp ../dts/f1c100s_uboot.dts arch/arm/dts/f1c100s_uboot.dts
cp ../dts/suniv-f1c100s.dtsi arch/arm/dts/suniv-f1c100s.dtsi
echo "#ifndef __CONFIG_H
#define __CONFIG_H

#define CONFIG_SUNXI_USB_PHYS 1

#include <configs/sunxi-common.h>

#endif /* __CONFIG_H */" > include/configs/suniv.h

make clean
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make uboot_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j64
mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "boot script" -d ../configs/boot.cmd boot.scr

cd ..

cd linux

cp ../configs/linux_defconfig arch/arm/configs/linux_defconfig
cp ../dts/f1c100s_linux.dts arch/arm/boot/dts/f1c100s_linux.dts
cp ../dts/suniv-f1c100s_linux.dtsi arch/arm/boot/dts/suniv-f1c100s.dtsi
echo dtb-y += f1c100s_linux.dtb >> arch/arm/boot/dts/Makefile
cp ../dtc-lexer.l scripts/dtc/dtc-lexer.l
make clean

ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make linux_defconfig
ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make -j64 deb-pkg LOCALVERSION=-custom
cd ..



