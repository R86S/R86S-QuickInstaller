#!/bin/sh
echo "TEST SERVER MODE!!"
echo "Reboot for come back normal setting"
sleep 1
service network stop
iptables -F
ifconfig eth0 192.168.60.1 netmast 255.255.255.0
ifconfig eth1 192.168.61.1 netmast 255.255.255.0
ifconfig eth2 192.168.62.1 netmast 255.255.255.0

ifconfig eth3 192.168.66.1 netmast 255.255.255.0
ifconfig eth4 192.168.67.1 netmast 255.255.255.0
# 创建测试用得窗口
#!/bin/sh 
tmux new-session -s "test-server" -d 'iperf3 -s'
tmux split-window -h
tmux send-keys 'iperf3 -s -p 9999'
tmux send-keys enter
tmux split-window -v
tmux send-keys 'watch -n 1 sensors'
tmux send-keys enter
tmux selectp -t test-server.0
tmux split-window -v
echo 'cat /proc/cpuinfo | grep MHz' > /tmp/check_Mhz.sh
tmux send-keys 'watch -n 1 sh /tmp/check_Mhz.sh'
tmux send-keys enter
tmux selectp -t test-server.0
tmux split-window -h
tmux send-keys 'iperf3 -s -p 19999'
tmux send-keys enter
screen tmux -2 attach-session -d
