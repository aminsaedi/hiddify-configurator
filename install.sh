#!/bin/sh


export UCF_FORCE_CONFFOLD=1
export DEBIAN_FRONTEND=noninteractive

curl -L -o hiddify-config.zip https://github.com/hiddify/hiddify-config/releases/latest/download/hiddify-config.zip
unzip -o hiddify-config.zip
rm hiddify-config.zip

bash install.sh
