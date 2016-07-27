#!/bin/bash
if [  $# -ne 4 ];then
echo
echo "Usage:$0 MODE{0|1|2|3|4|5|6} IPADDR NETMASK GATEWAY."
echo 
exit 1
fi
echo "Wating..." 
cp /etc/sysconfig/network-scripts/ifcfg-eth0  /etc/sysconfig/network-scripts/bak-ifcfg-eth0
cp /etc/sysconfig/network-scripts/ifcfg-eth1  /etc/sysconfig/network-scripts/bak-ifcfg-eth1
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE=eth0
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
USERCTL=no
ONBOOT=yes
EOF
cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
DEVICE=eth1
BOOTPROTO=none
MASTER=bond0
SLAVE=yes
USERCTL=no
ONBOOT=yes
EOF
cat > /etc/sysconfig/network-scripts/ifcfg-bond0 << EOF
DEVICE=bond0
BONDING_OPTS="mode=$1  miimon=200"
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=static
USERCTL=no
IPADDR=$2
NETMASK=$3
GATEWAY=$4
EOF
echo "Bond Mode$1 configure OK."
exit 0
