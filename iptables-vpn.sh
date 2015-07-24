#Clean all
iptables -F

#Allow loopback device (internal communication)
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#Allow all local traffic.
iptables -A INPUT -s 192.168.1.0/24 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.0/24 -j ACCEPT

#Allow VPN establishment
iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -p udp --sport 1194 -j ACCEPT

#Accept all TUN connections (tun = VPN tunnel)
iptables -A OUTPUT -o tun+ -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT

#Set default policies to drop all communication unless specifically allowed
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
