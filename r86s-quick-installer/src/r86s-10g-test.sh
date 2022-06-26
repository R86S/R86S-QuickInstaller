service network stop
iptables -F
ifconfig eth3 192.168.66.2 netmast 255.255.255.0
ifconfig eth4 192.168.67.2 netmast 255.255.255.0
echo 'while :
do
	trap "echo Exited!; exit;" SIGINT SIGTERM
	iperf3 -c 192.168.66.1
	iperf3 -c 192.168.66.1 -R
done' > /tmp/1_speed.sh

echo 'while :
do
        trap "echo Exited!; exit;" SIGINT SIGTERM
        iperf3 -c 192.168.67.1 --port 9999
	iperf3 -c 192.168.67.1 --port 9999 -R
done' > /tmp/2_speed.sh
tmux new-session -s "test-client" -d 'sh /tmp/1_speed.sh'
tmux split-window -h
tmux send-keys 'sh /tmp/2_speed.sh'
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
screen tmux -2 attach-session -d