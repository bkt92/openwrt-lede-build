#!/bin/bash
#
# Copyright (c) Bui Khac Tu
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# File name: build.sh
# Description: OpenWrt Build Script For Docekr Container
#

# Set env
# Config File
if [ -z ${CONFIGFILE+x} ];
    then echo "Config file is not set, set to default = CR660x"
    CONFIGFILE="cr660x.config"
else
    echo "Config file is set to '$CONFIGFILE'";
fi
# Git Repo
if [ -z ${GITREPO+x} ];
    then echo "Custom repo is not set, using Lean's Lede:"
    GITREPO="https://github.com/coolsnowwolf/lede"
else
    echo "Using '$GITREPO'";
fi
# Update build script (for debug)
[ -e /openwrt/config/build.sh ] && mv /openwrt/config/build.sh /openwrt/build.sh && exit 0

# Clone git repo
git clone $GITREPO lede
cd lede

# Add custom feeds
[ -e /openwrt/config/custom_feeds.sh ] && sh /openwrt/config/custom_feeds.sh

# Update feeds
./scripts/feeds update -a

# Install feeds
./scripts/feeds install -a

# Copy config file
if [ -e /openwrt/config/$CONFIGFILE ];
    then 
    cp /openwrt/config/$CONFIGFILE .config
    # Custom settings
    [ -e /openwrt/config/files ] && mv ../files .
    [ -e /openwrt/config/custom.sh ] && mv /openwrt/config/custom.sh /openwrt/custom.sh
	mv /openwrt/custom.sh . && sh custom.sh

    # Download required files to build
    make download -j$(nproc)

    # Buid firmware with .config
    make -j$(nproc) || make -j1 V=s

    # Move target outside
    find bin -name \*.bin -exec cp {} /openwrt/release \;
else
    echo "No config files found"
fi

