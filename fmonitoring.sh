#!/bin/bash

ARCH=$(uname -a)
PHYCPU=$()
VRTCPU=$()
MU=$()
DU=$()
CPUL=$()
LB=$()
LVMU=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
CONTCP=$()
UL=$()
NW=$()
S=$()
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

