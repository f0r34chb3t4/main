#!/bin/bash


iptables -t nat -N TORSOCKS
iptables -t nat -A TORSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A TORSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A TORSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A TORSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A TORSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A TORSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A TORSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A TORSOCKS -d 240.0.0.0/4 -j RETURN
iptables -t nat -A TORSOCKS -p tcp -j REDIRECT --to-ports 9040
iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 22 --syn -j TORSOCKS
iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 443 --syn -j TORSOCKS
iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 5222 --syn -j TORSOCKS
