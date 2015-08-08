#!/bin/bash

for i in $(seq 1 254); do
	ifconfig eth0:$(($i - 254)) 192.168.0.$i up
        iptables -t nat -A POSTROUTING -m owner --uid-owner 5$(printf "%03d" $(($i - 254))) -j SNAT --to-source 192.168.0.$i
done
