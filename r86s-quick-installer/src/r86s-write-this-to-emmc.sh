echo Write This System To R86S EMMC

# get devices of boot
boot_device=`mount --list | grep /boot | awk 'NR==1{print $1}' | tr -d '0-9'`
# should not write emmc to emmc
cmp_res=`echo $boot_device | grep mmcblk`
if [ "$cmp_res" != "" ]
then
   echo "------------------------------"
   echo "Cannot write EMMC to EMMC!!!!!"
   echo "------------------------------"
   echo "Cancel..."
   sleep 1
   exit
fi

echo WARNING!!!!!!
echo Will Clean All Data On EMMC!!!
echo 'Enter "confirm" to contine!:'
now_input="1"
read now_input
if [ "$now_input" != "confirm" ];
then
   echo "Not confirm...Cancel..."
   exit
fi
echo Will Clean All Data On EMMC!!!
echo ''
echo ''
echo '-----------------------------------'
echo 'Enter "confirm" again to contine!!:'
read now_input
if [ "$now_input" != "confirm" ];
then
   echo "Not confirm...Cancel..."
   exit
fi

echo "Umount exists emmc partition"
# umount exists mmc mount
for a_mount in `mount --list | grep /dev/mmc | awk '{print $1}'`
do
   umount $a_mount
done
# flush mmcblk0
echo 'Do Clean EMMC....'
(
    echo p
    echo g
    echo w
) | fdisk /dev/mmcblk0
# write our data to emmc
echo 'Writing Data...'

echo "Write $boot_device to /dev/mmcblk0"
dd if=$boot_device of=/dev/mmcblk0 bs=1M count=200 oflag=direct
(
    echo w
) | fdisk /dev/mmcblk0
# add for storage p
(
    echo n
    echo ''
    echo ''
    echo ''
    echo w
) | fdisk /dev/mmcblk0
mkfs.ext4 /dev/mmcblk0p3

#new uuid
new_uuid=`uuidgen`

mkdir -p /tmp/r86s-temp-boot
mount /dev/mmcblk0p1 /tmp/r86s-temp-boot

# change disk uuid for different from usb disk
sed -i "s/root=PARTUUID=.\{36\}/root=PARTUUID=$new_uuid/g" /tmp/r86s-temp-boot/boot/grub/grub.cfg
umount /tmp/r86s-temp-boot

(
   echo "x"
   echo "c"
   echo "2"
   echo $new_uuid
   echo "w"
   echo "y"
) | gdisk

echo 'Done!'
sleep 1

echo ''
echo ''
echo '-----------------------------------'
echo 'OK!!!'
