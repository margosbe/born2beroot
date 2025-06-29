#!/bin/bash

architecture=$(uname -a)
cpu_physical=$(lscpu | grep "Socket(s):" | awk '{print $2}')
vcpu=$(nproc)
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_perc=$(awk "BEGIN {printf \"%.2f\", $mem_used/$mem_total*100}")
disk_used=$(df -Bm / | awk 'NR==2 {print $3}' | sed 's/M//')
disk_total=$(df -Bm / | awk 'NR==2 {print $2}' | sed 's/M//')
disk_perc=$(df -h / | awk 'NR==2 {print $5}')
cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
last_boot=$(who -b | awk '{print $3" "$4}')
lvm_use=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
tcp_conn=$(ss -ta | grep ESTAB | wc -l)
user_log=$(who | wc -l)
ip=$(hostname -I | awk '{print $1}')
mac=$(ip link show | awk '/ether/ {print $2}' | head -n 1)
sudo_cmd=$(journalctl _COMM=sudo | grep -c COMMAND)

current_time="Sun Apr 25 15:45:00 2021"

# Output
echo "Broadcast message from root@wil (tty1) ($current_time):"
echo "#Architecture: $architecture"
echo "#CPU physical : $cpu_physical"
echo "#vCPU : $vcpu"
echo "#Memory Usage: $mem_used/$mem_total"MB" ($mem_perc%)"
echo "#Disk Usage: $disk_used/${disk_total}Mb ($disk_perc)"
echo "#CPU load: $cpu_load%"
echo "#Last boot: $last_boot"
echo "#LVM use: $lvm_use"
echo "#Connections TCP : $tcp_conn ESTABLISHED"
echo "#User log: $user_log"
echo "#Network: IP $ip ($mac)"
echo "#Sudo : $sudo_cmd cmd"

