# #　echo "开始优化固件配置..."
# 
# # ===== 移除冗余的VPN客户端（保留一个主要的即可） =====
# # 移除多余的Shadowsocks实现（保留libev版本）
# sed -i '/CONFIG_PACKAGE_shadowsocks-rust/d' .config
# sed -i '/luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client/d' .config
# 
# # 移除Trojan Plus（可用SingBox替代）
# sed -i '/CONFIG_PACKAGE_trojan-plus/d' .config
# sed -i '/luci-app-passwall_INCLUDE_Trojan_Plus/d' .config
# 
# # 移除NaiveProxy（可选）
# sed -i '/CONFIG_PACKAGE_naiveproxy/d' .config
# sed -i '/luci-app-passwall_INCLUDE_NaiveProxy/d' .config
# 
# # ===== 移除不必要的文件系统支持 =====
# # 移除NTFS3支持（如不需要Windows文件系统）
# sed -i '/CONFIG_PACKAGE_kmod-fs-ntfs3/d' .config
# 
# # 移除exFAT支持（如不需要）
# sed -i '/CONFIG_PACKAGE_kmod-fs-exfat/d' .config
# 
# # ===== 移除Samba相关服务 =====
# # 如果不需要Windows网络共享
# sed -i '/CONFIG_PACKAGE_ksmbd-server/d' .config
# sed -i '/CONFIG_PACKAGE_luci-app-ksmbd/d' .config
# sed -i '/CONFIG_PACKAGE_luci-i18n-ksmbd-zh-cn/d' .config
# sed -i '/CONFIG_PACKAGE_wsdd2/d' .config
# sed -i '/CONFIG_PACKAGE_autosamba/d' .config
# 
# # ===== 移除Avahi服务发现 =====
# sed -i '/CONFIG_PACKAGE_avahi-dbus-daemon/d' .config
# sed -i '/CONFIG_PACKAGE_libavahi/d' .config
# sed -i '/CONFIG_PACKAGE_libdaemon/d' .config
# sed -i '/CONFIG_PACKAGE_dbus/d' .config
# 
# # ===== 移除重复的应用商店 =====
# sed -i '/CONFIG_PACKAGE_luci-app-store/d' .config
# 
# # ===== 移除不必要的网络工具 =====
# # 移除UPnP代理（如果不需要IPTV）
# sed -i '/CONFIG_PACKAGE_udpxy/d' .config
# sed -i '/CONFIG_PACKAGE_luci-app-udpxy/d' .config
# sed -i '/CONFIG_PACKAGE_luci-i18n-udpxy-zh-cn/d' .config
# 
# # 移除IPv6隧道支持（如果不使用IPv6）
# sed -i '/CONFIG_PACKAGE_6in4/d' .config
# sed -i '/CONFIG_PACKAGE_ipv6helper/d' .config
# sed -i '/CONFIG_PACKAGE_kmod-sit/d' .config
# 
# # ===== 移除压缩工具（保留基本的即可） =====
# sed -i '/CONFIG_PACKAGE_TAR_BZIP2/d' .config
# sed -i '/CONFIG_PACKAGE_TAR_XZ/d' .config
# sed -i '/CONFIG_PACKAGE_TAR_ZSTD/d' .config
# sed -i '/CONFIG_PACKAGE_bzip2/d' .config
# sed -i '/CONFIG_PACKAGE_xz/d' .config
# sed -i '/CONFIG_PACKAGE_xz-utils/d' .config
# 
# # ===== 移除Ruby环境（如果没有相关应用需要） =====
# sed -i '/CONFIG_PACKAGE_ruby/d' .config
# sed -i '/CONFIG_PACKAGE_libruby/d' .config
# 
# # ===== 移除不必要的系统工具 =====
# # 移除nano编辑器（vi已足够）
# sed -i '/CONFIG_PACKAGE_nano/d' .config
# 
# # 移除wget-ssl和openssl-util（如果不需要SSL下载）
# sed -i '/CONFIG_PACKAGE_wget-ssl/d' .config
# sed -i '/CONFIG_PACKAGE_openssl-util/d' .config
# 
# # 移除Wake-on-LAN
# sed -i '/CONFIG_PACKAGE_wol/d' .config
# 
# # ===== 移除重复的DNS服务 =====
# # 移除pdnsd（ChinaDNS-NG已提供DNS功能）
# sed -i '/CONFIG_PACKAGE_pdnsd-alt/d' .config
# 
# # ===== 移除不必要的内核模块 =====
# # 移除ZRAM交换（128M设备可能不需要）
# sed -i '/CONFIG_PACKAGE_zram-swap/d' .config
# sed -i '/CONFIG_PACKAGE_kmod-zram/d' .config
# 
# # ===== 调整分区大小设置 =====
# # 减小根文件系统分区大小
# sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=120/' .config
# 
# # ===== 移除主题相关（如果使用默认主题） =====
# # sed -i '/CONFIG_PACKAGE_luci-theme-argon/d' .config
# # sed -i '/CONFIG_PACKAGE_luci-app-argon-config/d' .config
# # sed -i '/CONFIG_PACKAGE_luci-i18n-argon-config-zh-cn/d' .config
# # 
# # echo "配置优化完成!"
# # echo "预计可节省空间：15-25MB"
# # echo ""
# # echo "注意："
# # echo "1. 已移除部分VPN客户端，保留SingBox和部分Shadowsocks支持"
# # echo "2. 已移除Samba文件共享功能"
# # echo "3. 已移除IPTV代理功能"
# # echo "4. 如需这些功能，请根据实际需求调整脚本"







#!/bin/bash
# OpenWrt 固件体积优化脚本 - 针对128MiB ROM设备

# echo "开始优化固件配置..."
# 
# # ===== 禁用冗余的VPN客户端（保留一个主要的即可） =====
# # 禁用Trojan Plus（可用SingBox替代）
# sed -i 's/CONFIG_PACKAGE_trojan-plus=y/# CONFIG_PACKAGE_trojan-plus is not set/g' .config
# 
# # 禁用NaiveProxy（可选）
# sed -i 's/CONFIG_PACKAGE_naiveproxy=y/# CONFIG_PACKAGE_naiveproxy is not set/g' .config
# 
# # ===== 禁用不必要的文件系统支持 =====
# # 禁用NTFS3支持（如不需要Windows文件系统）
# sed -i 's/CONFIG_PACKAGE_kmod-fs-ntfs3=y/# CONFIG_PACKAGE_kmod-fs-ntfs3 is not set/g' .config
# 
# # 禁用exFAT支持（如不需要）
# sed -i 's/CONFIG_PACKAGE_kmod-fs-exfat=y/# CONFIG_PACKAGE_kmod-fs-exfat is not set/g' .config
# 
# # ===== 禁用Samba相关服务 =====
# # 如果不需要Windows网络共享
# sed -i 's/CONFIG_PACKAGE_ksmbd-server=y/# CONFIG_PACKAGE_ksmbd-server is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_luci-app-ksmbd=y/# CONFIG_PACKAGE_luci-app-ksmbd is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_luci-i18n-ksmbd-zh-cn=y/# CONFIG_PACKAGE_luci-i18n-ksmbd-zh-cn is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_wsdd2=y/# CONFIG_PACKAGE_wsdd2 is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_autosamba=y/# CONFIG_PACKAGE_autosamba is not set/g' .config
# 
# # ===== 禁用重复的应用商店 =====
# sed -i 's/CONFIG_PACKAGE_luci-app-store=y/# CONFIG_PACKAGE_luci-app-store is not set/g' .config
# 
# # ===== 禁用不必要的网络工具 =====
# # 禁用UPnP代理（如果不需要IPTV）
# sed -i 's/CONFIG_PACKAGE_udpxy=y/# CONFIG_PACKAGE_udpxy is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_luci-app-udpxy=y/# CONFIG_PACKAGE_luci-app-udpxy is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_luci-i18n-udpxy-zh-cn=y/# CONFIG_PACKAGE_luci-i18n-udpxy-zh-cn is not set/g' .config
# 
# # 禁用IPv6隧道支持（如果不使用IPv6）
# sed -i 's/CONFIG_PACKAGE_6in4=y/# CONFIG_PACKAGE_6in4 is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ipv6helper=y/# CONFIG_PACKAGE_ipv6helper is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_kmod-sit=y/# CONFIG_PACKAGE_kmod-sit is not set/g' .config
# 
# # ===== 禁用压缩工具（保留基本的即可） =====
# sed -i 's/CONFIG_PACKAGE_TAR_BZIP2=y/# CONFIG_PACKAGE_TAR_BZIP2 is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_TAR_XZ=y/# CONFIG_PACKAGE_TAR_XZ is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_TAR_ZSTD=y/# CONFIG_PACKAGE_TAR_ZSTD is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_bzip2=y/# CONFIG_PACKAGE_bzip2 is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_xz=y/# CONFIG_PACKAGE_xz is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_xz-utils=y/# CONFIG_PACKAGE_xz-utils is not set/g' .config
# 
# # ===== 禁用Ruby环境（如果没有相关应用需要） =====
# sed -i 's/CONFIG_PACKAGE_ruby=y/# CONFIG_PACKAGE_ruby is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-bigdecimal=y/# CONFIG_PACKAGE_ruby-bigdecimal is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-date=y/# CONFIG_PACKAGE_ruby-date is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-digest=y/# CONFIG_PACKAGE_ruby-digest is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-enc=y/# CONFIG_PACKAGE_ruby-enc is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-pstore=y/# CONFIG_PACKAGE_ruby-pstore is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-psych=y/# CONFIG_PACKAGE_ruby-psych is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-stringio=y/# CONFIG_PACKAGE_ruby-stringio is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_ruby-yaml=y/# CONFIG_PACKAGE_ruby-yaml is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_libruby=y/# CONFIG_PACKAGE_libruby is not set/g' .config
# 
# # ===== 禁用不必要的系统工具 =====
# # 禁用nano编辑器（vi已足够）
# sed -i 's/CONFIG_PACKAGE_nano=y/# CONFIG_PACKAGE_nano is not set/g' .config
# 
# # 禁用wget-ssl和openssl-util（如果不需要SSL下载）
# sed -i 's/CONFIG_PACKAGE_wget-ssl=y/# CONFIG_PACKAGE_wget-ssl is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_openssl-util=y/# CONFIG_PACKAGE_openssl-util is not set/g' .config
# 
# # 禁用Wake-on-LAN
# sed -i 's/CONFIG_PACKAGE_wol=y/# CONFIG_PACKAGE_wol is not set/g' .config
# 
# # ===== 禁用重复的DNS服务 =====
# # 禁用pdnsd（ChinaDNS-NG已提供DNS功能）
# sed -i 's/CONFIG_PACKAGE_pdnsd-alt=y/# CONFIG_PACKAGE_pdnsd-alt is not set/g' .config
# 
# # ===== 禁用不必要的内核模块 =====
# # 禁用ZRAM交换（128M设备可能不需要）
# sed -i 's/CONFIG_PACKAGE_zram-swap=y/# CONFIG_PACKAGE_zram-swap is not set/g' .config
# sed -i 's/CONFIG_PACKAGE_kmod-zram=y/# CONFIG_PACKAGE_kmod-zram is not set/g' .config
# 
# # ===== 调整分区大小设置 =====
# # 减小根文件系统分区大小
# sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=120/' .config
# 
# # ===== 禁用主题相关（如果使用默认主题） =====
# # sed -i 's/CONFIG_PACKAGE_luci-theme-argon=y/# CONFIG_PACKAGE_luci-theme-argon is not set/g' .config
# # sed -i 's/CONFIG_PACKAGE_luci-app-argon-config=y/# CONFIG_PACKAGE_luci-app-argon-config is not set/g' .config
# # sed -i 's/CONFIG_PACKAGE_luci-i18n-argon-config-zh-cn=y/# CONFIG_PACKAGE_luci-i18n-argon-config-zh-cn is not set/g' .config
# 
# echo "配置优化完成!"
# echo "预计可节省空间：15-25MB"
# echo ""
# echo "注意："
# echo "1. 已移除部分VPN客户端，保留SingBox和部分Shadowsocks支持"
# echo "2. 已移除Samba文件共享功能"
# echo "3. 已移除IPTV代理功能"
# echo "4. 如需这些功能，请根据实际需求调整脚本"