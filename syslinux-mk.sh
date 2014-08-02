#!/bin/bash
# Make a bootable USB from standard ISO
# -> syslinux loop fdisk lsblk
#
# GTFO license / zero-safety :)

if (( UID != 0 )); then
	echo "Run this script as r00t."
	exit 1
fi

lsblk -f
read -rp "Create a new bootable partition (1)."
select i in /dev/sd?; do
	fdisk ${i}
	break
done

$ISOP="/media/data/Downloads"
$MBRP="/usr/lib/syslinux/bios/mbr.bin"
$DEVP=/dev/sd${i}1
$MNTP=/mnt/sd${i}1

read -rp "Select the syslinux ISO."
select j in $ISOP/*.iso; do
	mkdir -p /mnt/iso && mount -o loop ${j} /mnt/iso
	break
done

mkfs.ext4 -O ^has_journal $DEVP
mkdir $MNTP && mount $DEVP $MNTP
cp -a /mnt/iso $MNTP

extlinux -i $MNTP
mv $MNTP/isolinux.cfg $MNTP/extlinux.conf
#cat /usr/lib/syslinux/bios/mbr.bin > /dev/sd${i}
dd bs=440 count=1 conv=notrunc if=$MBRP of=/dev/sd${i}

umount $MNTP
umount /mnt/iso
rm -r $MNTP /mnt/iso
