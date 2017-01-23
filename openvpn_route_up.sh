#!/bin/sh
#
#
# script-security 2
# route-noexec
# route-up /etc/openvpn/route_up.sh

/bin/echo 1 > /proc/sys/net/ipv4/ip_forward
/sbin/iptables -t nat -A POSTROUTING -o "$dev" -j MASQUERADE

echo "111 custom_table" >> /etc/iproute2/rt_tables
echo "$dev : $ifconfig_local -> $ifconfig_remote gw: $route_vpn_gateway"

ip route add default via $route_vpn_gateway dev $dev table custom_table
ip rule add from $ifconfig_local/32 table custom_table
ip rule add to $route_vpn_gateway/32 table custom_table
ip route flush cache

exit 0
