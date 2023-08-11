# R86S-QuickInstaller
R86S System Quick Installer
This repo contains script code for some factory functions
And record some suggest select and suggest remove package for R86S 

|Item|Info|
|  ----  | ----  |
|r86s-clean-emmc.sh|Clean all data on emmc|
|r86s-write-this-to-emmc.sh|Write this system to emmc|

# Need select packages
 <!-- - sgdisk: Fix GPT info
 - partx: Refresh part info -->
 - pciutils: Pci devices info
 - usbutils: USB devices info
 - fdisk
 - igc: Intel I225/I226 NIC Driver
 - mlx4: CX341/CX342 NIC Driver
 - gdisk: change uuid for partition
 - lsblk: list block size for get dd size
 - useradd: add user for smb
 - smartctl: check nvme status
 - coreutils-nohup
 - tmux: a nice terminal
 - iperf3:
 - screen:
 - tcpdump:
 - shadow-utils
 - procps
 - procps-ng-watch
 - uuidgen
 - stress
 - luci-app-dockerman
 - luci-app-qbittorrent
 - luci-app-openvpn
 - resize2fs
 - ncdu
 - kmod-mt7921e
 - kmod-mt7921s
 - kmod-mt7921u
 - kmod-iwlwifi
 - iwlwifi-firmware-ax200
 - iwlwifi-firmware-ax210
 - iwlwifi-firmware-ax201
 - wpa-supplicant: Fix Intel WIFI Client
 - hostapd: AP Support For MT7921
 - kmod-ath10k
 - odhcp6c: ipv6 dhcp client
 - odhcpd: ipv6 dhcp server/relay
 - ip6tables: ipv6 firewall
# Need remove packages
Remove some package to optimization compile time.
 - automount
 - autosamba
 - unblockmusic
 - luci-app-vlmcsd
 - luci-app-wireguard
 - luci-app-adbyby-plus
