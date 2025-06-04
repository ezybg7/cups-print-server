#!/bin/bash

# Scan for network printers in the IP range and add them
for IP in $(nmap -p 9100 --open <NETWORK_RANGE> | grep 'Nmap scan report' | awk '{print $5}'); do
  lpinfo -v | grep -q "$IP" || \
  lpadmin -p "auto_$IP" -v "socket://$IP" -E -m everywhere
done
