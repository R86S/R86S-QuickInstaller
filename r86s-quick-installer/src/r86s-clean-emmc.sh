echo WARNING!!!!!!
echo Will Clean All Data From EMMC!!!
echo 'Enter "confirm" to contine!:'
now_input="1"
read now_input
if [ "$now_input" != "confirm" ];
then
   echo "Not confirm...Cancel..."
   exit
fi
echo Will Clean All Data From EMMC!!!
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
echo 'Do Clean EMMC....'
# flush mmcblk0
(
    echo p
    echo g
    echo w
) | fdisk /dev/mmcblk0

echo ''
echo ''
echo '-----------------------------------'
echo 'OK!!!'