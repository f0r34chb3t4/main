#!/bin/bash
sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
sudo cat /etc/sudoers | grep "$USER"
