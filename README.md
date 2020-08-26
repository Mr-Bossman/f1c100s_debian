a thing i made to build the image without build root so u can add other root file systems like debain


./download.sh

./make.sh


sudo debootstrap --foreign --variant=minbase --components=main,non-free --include=systemd-sysv,cryptsetup,console-setup --arch armel buster output/rootfs http://deb.debian.org/debian/


./pack.sh

sudo dd if=output/sdcard.img of=/dev/sdX


to chroot into rootfs 

sudo apt-get install qemu-user-static 

sudo cp /usr/bin/qemu-arm-static output/rootfs/usr/bin/

sudo chroot output/rootfs/ /usr/bin/qemu-arm-static /bin/bash -i


