echo Write This System To R86S EMMC
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
# get devices of boot
boot_device=`mount --list | grep /boot | awk 'NR==1{print $1}' | tr -d '0-9'`
echo "Write $boot_device to /dev/mmcblk0"
dd if=$boot_device of=/dev/mmcblk0 bs=1M count=200 oflag=direct
(
    echo w
) | fdisk /dev/mmcblk0
echo 'Done!'

echo ''
echo ''
echo '-----------------------------------'
echo 'OK!!!'
