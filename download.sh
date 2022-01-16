#! /bin/bash
sudo apt-get update
sudo apt-get install gawk wget git diffstat unzip texinfo \
     build-essential chrpath socat libsdl1.2-dev xterm picocom ncurses-dev lzop \
     gcc-arm-linux-gnueabi u-boot-tools debootstrap qemu-user-static 

rm -rf linux
rm -rf u-boot
git clone -b f1c100s https://github.com/Mr-Bossman/u-boot.git
git clone -b F1C100s git://github.com/Mr-Bossman/linux.git
