#!/bin/sh

sudo yum groupinstall 'Development Tools'
sudo yum install procps-ng curl file git
sudo yum install libxcrypt-compat

chmod +x install.sh
sh ./install.sh
