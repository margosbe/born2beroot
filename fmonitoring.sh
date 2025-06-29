#!/bin/bash

ARCH=$(uname -a)
PHYCPU=$(lscpu | grep "Socket(s):" | awk '{print $2}')
VRTCPU=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
MU=$()
DU=$()
CPUL=$()
LB=$()
LVMU=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
CONTCP=$(ss -ta | grep -c "ESTAB")
UL=$(who | wc -l)
IP=$(hostname -I)
MAC=$(ip address | awk '/ether/ {print $2}')
NW=$(echo "IP $IP($MAC)")
S=$(journalctl _COMM=sudo | grep -c COMMAND)
CURR_TIME=$(date '+%a %b %d %T %Y')

wall "
Broadcast message from root@wil (tty1) ($CURR_TIME):
#Architecture: $ARCH
#CPU physical : $PHYCPU
#vCPU : $VRTCPU
#Memory Usage: $MU
#Disk Usage: $DU
#CPU load: $CPUL
#Last boot: $LB
#LVM use: $LVMU
#Connections TCP : $CONTCP
#User log: $UL
#Network: $NW
#Sudo : $S
"

