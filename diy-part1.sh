#!/bin/bash
#
# Copyright (c) 2019- P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/msd_lite
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-serverchan
# DIY Network Tools
rm -rf feeds/luci/applications/luci-app-ssr-plus




# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git NueXini_Packages https://github.com/NueXini/NueXini_Packages.git' feeds.conf.default


# 添加额外插件
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff

# Add a passwall feed source
echo 'src-git passwall_luci https://github.com/xiaorouji/openwrt-passwall.git' >>feeds.conf.default
echo 'src-git passwall_package https://github.com/xiaorouji/openwrt-passwall-packages' >>feeds.conf.default

# iStore
# git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
# git_sparse_clone main https://github.com/linkease/istore luci



# 在线用户 luci-app-onliner @nlbwmon
git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by go-laoji/g" package/lean/default-settings/files/zzz-default-settings

# 移除默认安装的vsftpd、vlmcsd
sed -i "s/luci-app-vsftpd//g" include/target.mk
sed -i "s/luci-app-vlmcsd//g" include/target.mk
# ./scripts/feeds update helloworld
# ./scripts/feeds install -a -f -p helloworld

./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -a
# 
# ./scripts/feeds update -a

# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Modify default IP
# sed -i 's/192.168.1.1/192.168.11.1/g' package/base-files/luci2/bin/config_generate

#./scripts/feeds install -a

# Create Menu配置菜单 验证环境正常
# make menuconfig

# ### 下载DL库，编译

# make download -j8
# make V=s -j1

# 制作 Menu

# ### 7再次编译

# make download -j8
# make V=s -j1

# ### 注:如需重新配置

# bash

# rm -rf .config
# make menuconfig
# make V=s -j$(nproc)
