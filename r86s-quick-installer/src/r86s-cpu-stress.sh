#!/bin/sh
# 创建测试用得窗口
echo 'cat /proc/cpuinfo | grep MHz' > /tmp/check_Mhz.sh
tmux new-session -s "test-cpu" -d 'stress -c 4'
tmux split-window -h
tmux send-keys 'watch -n 1 sh /tmp/check_Mhz.sh'
tmux send-keys enter
tmux split-window -v
tmux send-keys 'watch -n 1 sensors'
tmux send-keys enter
screen tmux -2 attach-session -d
