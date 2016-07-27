#!/bin/bash
# Started: 27/7 2016
# Bugs: Only Ubuntu 16.04 supported atm

VER=$(lsb_release -s -r)
ID=$(lsb_release -s -i)
CODENAME=$(lsb_release -s -c)

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ${CODENAME} == "xenial" ];then
    echo "Ubuntu 16.04 Detected"
    apt-get update
    apt-get install --install-recommends linux-virtual-lts-xenial linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial
fi

echo "Remeber to reboot"