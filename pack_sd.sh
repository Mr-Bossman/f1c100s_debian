#! /bin/bash

cd output
dd if=/dev/zero of=sdcard.img bs=1M count=300
cat <<EOT | sudo  fdisk -u sdcard.img
n



+20M
t
b
a
n



+200M
w
EOT
_loop=$(sudo losetup -f)
sudo losetup -P $_loop sdcard.img
sudo mkfs.vfat ${_loop}p2 
sudo mkfs.ext4 ${_loop}p1 
sudo dd if=../u-boot/u-boot-sunxi-with-spl.bin of=$_loop bs=1024 seek=8
sudo sync
sudo mount ${_loop}p1 p1
sudo cp ../linux/arch/arm/boot/zImage p1/zImage 
sudo cp ../linux/arch/arm/boot/dts/f1c100s_linux.dtb p1/f1c100s_uboot.dtb
sudo cp ../u-boot/boot.scr p1/boot.scr
sudo umount p1
sudo losetup -d $_loop

