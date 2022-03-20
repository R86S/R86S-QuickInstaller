service network stop
ifconfig eth0 192.168.60.2 netmast 255.255.255.0
ifconfig eth1 192.168.61.2 netmast 255.255.255.0
ifconfig eth2 192.168.62.2 netmast 255.255.255.0
iptables -F

echo 'while :
do
	trap "echo Exited!; exit;" SIGINT SIGTERM
	iperf3 -c 192.168.61.1
	iperf3 -c 192.168.61.1 -R
done' > /tmp/1_speed.sh

echo 'while :
do
        trap "echo Exited!; exit;" SIGINT SIGTERM
        iperf3 -c 192.168.62.1 --port 9999
	iperf3 -c 192.168.62.1 --port 9999 -R
done' > /tmp/2_speed.sh
tmux new-session -s "test-client" -d 'bash /tmp/1_speed.sh'
tmux split-window -h
tmux send-keys 'bash /tmp/2_speed.sh'
tmux send-keys enter
#tmux -2 attach-session -d
tmux split-window -v
tmux send-keys 'watch -n 1 sensors'
tmux send-keys enter
tmux selectp -t test-client.0
tmux split-window -v
echo 'cat /proc/cpuinfo | grep MHz' > /tmp/check_Mhz.sh
tmux send-keys 'watch -n 1 sh /tmp/check_Mhz.sh'
tmux send-keys enter
echo 'while :
do
        trap "echo Exited!; exit;" SIGINT SIGTERM
        iperf3 -c 192.168.60.1 --port 19999
	iperf3 -c 192.168.60.1 --port 19999 -R
done' > /tmp/3_speed.sh
tmux selectp -t test-client.0
tmux split-window -h
tmux send-keys 'sh /tmp/3_speed.sh'
tmux send-keys enter
screen tmux -2 attach-session -d