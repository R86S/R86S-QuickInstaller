set -u
wget https://r86s.net/sysdl/sys_install.en -O /tmp/sys_install.en
if [ "$?" != "0" ];
then
echo "ERROR:"
echo "Update install script online failed!"
echo "Cancel..."
exit
fi
cat /tmp/sys_install.en | /usr/sbin/r86s-decrypt-info.sh > /tmp/sys_install.sh

if [ "$?" != "0" ];
then
echo "ERROR:"
echo "Update install script online failed!"
echo "Cancel..."
exit
fi
echo "-------------------------"
echo "Start Online Script..."
echo "-------------------------"
sh /tmp/sys_install.sh