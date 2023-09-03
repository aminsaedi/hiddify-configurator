#!/bin/sh


GITHUB_REPOSITORY=hiddify-config
GITHUB_USER=hiddify
GITHUB_BRANCH_OR_TAG=main

export UCF_FORCE_CONFFOLD=1
export DEBIAN_FRONTEND=noninteractive

sleep 60
add-apt-repository -y ppa:vbernat/haproxy-2.8
apt -o DPkg::Lock::Timeout=60 install --no-install-recommends -y software-properties-common
apt -o DPkg::Lock::Timeout=60 update
apt -o DPkg::Lock::Timeout=60 upgrade -y
apt -o DPkg::Lock::Timeout=60 install -y curl unzip haproxy sqlite3
# pip3 install lastversion "requests<=2.29.0"
# pip install lastversion "requests<=2.29.0"
mkdir -p /opt/$GITHUB_REPOSITORY
cd /opt/$GITHUB_REPOSITORY
curl -L -o hiddify-config.zip https://github.com/hiddify/hiddify-config/releases/latest/download/hiddify-config.zip
unzip -o hiddify-config.zip
rm hiddify-config.zip

bash install.sh