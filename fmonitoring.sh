#!/bin/bash

ARCH=$(uname -a)
PHYCPU=$(lscpu | grep "Socket(s):" | awk '{print $2}')
VRTCPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
MTOTAL=$(free -m | awk '/Mem:/ {print $2}')
MUSED=$(free -m | awk '/Mem:/ {print $3}')
MPERCENTAGE=$(awk "BEGIN {printf \"%.2f\", $MUSED/$MTOTAL*100}")
DUSED=$(df -h --total | tail -1 | awk '{print $3}')
DTOTAL=$(df -h --total | tail -1 | awk '{print $2}')
DPERCENTAGE=$(df -h --total | tail -1 | awk '{print $5}')
CPUL=$(mpstat | tail -1 | awk '{print $5}')
LB=$(who -b | awk '{print $3" "$4}')
LVMU=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
CONTCP=$(ss -ta | grep -c "ESTAB")
UL=$(who | wc -l)
IP=$(hostname -I)
MAC=$(ip address | awk '/ether/ {print $2}')
NW=$(echo "IP $IP($MAC)")
S=$(journalctl _COMM=sudo | grep -c COMMAND)

wall "
#Architecture: $ARCH
#CPU physical : $PHYCPU
#vCPU : $VRTCPU
#Memory Usage: $MUSED/$MTOTAL"MB" ($MPERCENTAGE%)
#Disk Usage: $DUSED/$DTOTAL ($DPERCENTAGE)
#CPU load: $CPUL
#Last boot: $LB
#LVM use: $LVMU
#Connections TCP : $CONTCP ESTABLISHED
#User log: $UL
#Network: $NW
#Sudo : $S cmd
"

