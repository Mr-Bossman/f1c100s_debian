A thing i made to build the image without build root so you can add other root file systems like Debian

```
./download.sh

./make.sh

mkdir output
mkdir output/p1
mkdir output/p2


sudo debootstrap --foreign --variant=minbase --components=main,non-free --include=systemd-sysv,cryptsetup,console-setup --arch armel buster output/rootfs http://deb.debian.org/debian/

sudo cp *.deb output/rootfs/

./pack_sd.sh
#wait till the pause and then do the following
#to chroot into rootfs


sudo cp /usr/bin/qemu-arm-static output/rootfs/usr/bin/

sudo chroot output/rootfs/ /usr/bin/qemu-arm-static /bin/bash -i

/debootstrap/debootstrap --second-stage

apt install -y dialog makedev nano tasksel

echo "0.0 0 0.0
0
LOCAL" >  /etc/adjtime
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US.UTF-8

apt install -y locales

tasksel install standard

dpkg -i /*.deb
passwd
exit

#continue

sudo dd if=output/sdcard.img of=/dev/sdX bs=4M status=progress conv=fsync oflag=sync; sudo sync


```
