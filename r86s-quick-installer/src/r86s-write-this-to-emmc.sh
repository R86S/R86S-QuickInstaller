echo Write This System To R86S EMMC

# get devices of boot
boot_device=`mount -l | grep /boot | awk 'NR==1{print $1}' | tr -d '0-9'`
boot_data_size=`lsblk  | grep /rom | awk 'NR==1{print $4}' | tr -d 'A-Z'`
let "dd_size=$boot_data_size+50"
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

mkdir /mnt/data

if [ -f /usr/bin/docker ]; then
   echo "Docker found! add auto docker config"
   echo "/dev/mmcblkp3 /mnt/data ext4 defaults 0 0" > /etc/fstab
   echo "/mnt/data/docker /opt/docker none bind 0 0" > /etc/fstab
fi

echo 'Writing Data...'

echo "Write $boot_device to /dev/mmcblk0"
echo "DD SIZE: $dd_size"
dd if=$boot_device of=/dev/mmcblk0 bs=1M count=$dd_size oflag=direct
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
) | gdisk /dev/mmcblk0

echo 'Done!'
sleep 1

if [ -f /usr/bin/docker ]; then
   mount -t ext4 /dev/mmcblk0p3 /mnt/data
   mkdir -p /mnt/data/docker
   umount /mnt/data
fi
echo ''
echo ''
echo '-----------------------------------'
echo 'OK!!!'
