#! /bin/bash

cd output
rm sdcard.img
dd if=/dev/zero of=sdcard.img bs=1M count=600
cat <<EOT | sudo  fdisk -u sdcard.img
n



+20M
t
b
a
n



+3000M
w
EOT
_loop=$(sudo losetup -f)
sudo losetup -P $_loop sdcard.img
sudo mkfs.vfat ${_loop}p1
sudo mkfs.ext4 ${_loop}p2 
sudo dd if=../u-boot/u-boot-sunxi-with-spl.bin of=$_loop bs=1024 seek=8
sudo sync

sudo mount ${_loop}p2 p2
sudo cp -a rootfs/* p2



sudo mount ${_loop}p1 p2/boot
#sudo cp ../linux/arch/arm/boot/zImage p1/zImage 
#sudo cp ../linux/arch/arm/boot/dts/f1c100s_linux.dtb p1/f1c100s_linux.dtb
#sudo cp ../u-boot/boot.scr p1/boot.scr

sudo umount p2/boot
sudo umount p2
sudo losetup -d $_loop

