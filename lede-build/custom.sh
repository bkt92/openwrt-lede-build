#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: custom.sh
# Description: OpenWrt DIY script (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate
# Default time zone
sed -i 's/UTC/<+07>-7/g' package/base-files/files/bin/config_generate
# Change luci language to English
#sed -i 's/luci.main.lang=zh_cn/luci.main.lang=en/g' package/lean/default-settings/files/zzz-default-settings
# Modify time zone to GMT+7
#sed -i 's/system.@system\[0].timezone=CST-8/system.@system\[0].timezone=<+07>-7/g' package/lean/default-settings/files/zzz-default-settings
# Change zone name to HCM Viet Nam
#sed -i 's/system.@system\[0].zonename=Asia\/Shanghai/system.@system\[0].zonename=Asia\/Ho Chi Minh/g' package/lean/default-settings/files/zzz-default-settings
# Change firmware version
#sed -i "s/OpenWrt /OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# Modify themse
# rm -rf package/lean/luci-theme-argon

# Using xiaowansm5 theme
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

# Change default theme
# sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' ./feeds/luci/collections/luci/Makefile