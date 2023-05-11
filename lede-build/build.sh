#!/bin/bash
#
# Copyright (c) none
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# File name: build.sh
# Description: OpenWrt Build Script
#

# Set env
# Config File
if [ -z ${CONFIG+x} ];
    then echo "Config file is not set, set to default = CR660x"
    CONFIG="cr660x.config"
else
    echo "Config file is set to '$CONFIG'";
fi
# Git Repo
if [ -z ${GITREPO+x} ];
    then echo "Custom repo is not set, using Lean's Lede:"
    GITREPO="https://github.com/coolsnowwolf/lede"
else
    echo "Using '$GITREPO'";
fi

# Clone git repo
git clone $GITREPO lede
cd lede

# Update packages
./scripts/feeds update -a

# Install packages
./scripts/feeds install -a

# Copy config file
cp /openwrt/config/$CONFIG .config

# Custom settings
[ -e ../files ] && mv ../files .
[ -e ../custom.sh ] && mv ../custom.sh . && ./custom.sh

# Download required files to build
make download -j$(nproc)

# Buid firmware with .config
make -j1 V=s

# Move target outside
mv bin ../release