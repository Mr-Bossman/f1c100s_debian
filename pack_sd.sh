#! /bin/bash

cd output
rm sdcard.img
dd if=/dev/zero of=sdcard.img bs=1M count=4000
cat <<EOT | sudo  fdisk -u sdcard.img
n



+20M
t
b
a
n



+3970M
w
EOT
_loop=$(sudo losetup -f)
sudo losetup -P $_loop sdcard.img
sudo mkfs.vfat ${_loop}p1
sudo mkfs.ext4 ${_loop}p2 
sudo dd if=../f1c100s-u-boot/u-boot-sunxi-with-spl.bin of=$_loop bs=1024 seek=8
sudo sync

sudo mount ${_loop}p2 p2
sudo mount ${_loop}p1 rootfs/boot
read -p "run comands in readme b4 coninue ..."

sudo cp ../linux/arch/arm/boot/zImage rootfs/boot/zImage 
sudo cp ../linux/arch/arm/boot/dts/f1c100s_linux.dtb rootfs/boot/f1c100s_linux.dtb
sudo cp ../f1c100s-u-boot/boot.scr rootfs/boot/boot.scr
sudo umount rootfs/boot
sudo cp -a rootfs/* p2



sudo umount p2
sudo losetup -d $_loop

