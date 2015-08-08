#!/bin/bash

while read -r l; do
	curl --interface $l ifconfig.co
done < <(ip addr show eth0 | grep -F 'eth0:' | sort | awk '/inet / {print $2}' | cut -d '/' -f 1)
