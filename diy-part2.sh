#!/bin/bash
# OpenWrt 固件体积优化脚本 - 针对128MiB ROM设备
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh

# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# # Modify default IP
sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/luci2/bin/config_generate
# 
# #　echo "开始优化固件配置..."