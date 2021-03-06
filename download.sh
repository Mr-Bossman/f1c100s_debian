#! /bin/bash
sudo apt-get update
sudo apt-get install gawk wget git diffstat unzip texinfo \
     build-essential chrpath socat libsdl1.2-dev xterm picocom ncurses-dev lzop \
     gcc-arm-linux-gnueabi u-boot-tools debootstrap qemu-user-static 

rm -rf linux
rm -rf u-boot
git clone -b nano-lcd800480 https://github.com/Mr-Bossman/f1c100s-u-boot.git
git clone -b test git://github.com/Mr-Bossman/linux.git
