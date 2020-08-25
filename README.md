a thing i made to build the image without build root so u can add other root file systems like debain


./download.sh

./make.sh


sudo debootstrap --foreign --arch armel buster output/rootfs http://deb.debian.org/debian/


./pack.sh

sudo dd if=output/sdcard.img of=/dev/sdX

