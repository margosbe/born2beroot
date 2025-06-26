#!/bin/bash

get_system_info() {
    ARCH=$(uname -m)
    KERNEL=$(uname -r)
    PHYS_CPUS=$(lscpu | grep 'Socket(s)' | awk '{print $2}')
    VIRT_CPUS=$(nproc)
    MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
    MEM_USED=$(free -m | awk 'NR==2{print $3}')
    MEM_PERC=$(awk "BEGIN {printf \"%.2f\", ${MEM_USED}/${MEM_TOTAL}*100}")
    STORAGE_TOTAL=$(df -h / | awk 'NR==2{print $2}')
    STORAGE_USED=$(df -h / | awk 'NR==2{print $3}')
    STORAGE_PERC=$(df -h / | awk 'NR==2{print $5}' | tr -d '%')
    CPU_PERC=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
    LAST_BOOT=$(who -b | awk '{print $3 " " $4}')
    LVM_STATUS=$(lsblk -o TYPE | grep -q lvm && echo "active" || echo "inactive")
    TCP_CONNS=$(ss -tun | grep -c ESTAB)
    USER_COUNT=$(who | wc -l)
    IP_ADDR=$(hostname -I | awk '{print $1}')
    MAC_ADDR=$(ip link show | grep -m1 -E 'ether' | awk '{print $2}')
    SUDO_COUNT=$(journalctl _COMM=sudo 2>/dev/null | grep -c "COMMAND" || \
                 grep -a "sudo.*COMMAND" /var/log/auth.log* 2>/dev/null | wc -l)
    cat <<EOF

===============================================
- Architecture    : $ARCH ($KERNEL)
- Physical CPUs   : $PHYS_CPUS
- Virtual CPUs    : $VIRT_CPUS
- Memory Usage    : ${MEM_USED}MB/${MEM_TOTAL}MB ($MEM_PERC%)
- Storage Usage   : ${STORAGE_USED}B/${STORAGE_TOTAL}B ($STORAGE_PERC%)
- CPU Load        : $CPU_PERC%
- Last Reboot     : $LAST_BOOT
- LVM Status      : $LVM_STATUS
- Active Sessions : $TCP_CONNS
- Users logged in : $USER_COUNT
- Network Info    : IP $IP_ADDR | MAC $MAC_ADDR
- Sudo Commands   : $SUDO_COUNT executed
===============================================
EOF
}

while true; do
    get_system_info | wall
    sleep 600
done
