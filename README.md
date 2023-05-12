# openwrt-lede-build
Build environment for openwrt/lede based on Ubuntu 20.04 LTS Docker Image 

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=License)](https://github.com/bkt92/openwrt-lede-build/blob/main/README.md)

## Usage

### Pull image

- Pull image from docker hub.
  
  ```shell
  docker pull bkt92/openwrt-lede-build-env
  ```

(Optional)
- Build image.
  
  ```shell
  docker build -t <image_name> github.com/bkt92/openwrt-lede-build/lede-build
  ```
### Copy Config File
Create config folder and copy config file for specific build target.
Available config file:
- Xiaomi CR660X: Including adguardhome, OpenVpn, Wiguard etc.
- Newifi 3D2: Including adguardhome, OpenVpn, Wiguard etc.
- Xiaomi Router 3Gv1: 

To custom the pre-installed pakage run 'make menuconfig in the container'

Other custom can be made by change the custom.sh script file and add files to the folder /openwrt/files of the container

### Build firmware with docker-compose
- Install Docker desktop on windows or install docker on linux
- Download docker-compose.yml and config file for device (for example cr660x.config)
- Eut config file to the config folder.
- Edit environment to match the name of config file.
- Run docker-compose up and wait.
- The firmware will be in the release folder. 

### Run container

```shell
docker run \
    -it \
    --name lede-build \
    -h LEDE \
    -v $(pwd)/release:/openwrt/release \
    -v $(pwd)/config:/openwrt/config \
    --env CONFIGFILE="cr660x.config" \
    bkt92/openwrt-lede-build-env
```

Other version of OpenWrt can be build by change the default git repo by passing the new environment parameter:
```shell
--env GITREPO="https://github.com/coolsnowwolf/lede"
```
Repo can be added:

- Immortalwrt master branch: "https://github.com/immortalwrt/immortalwrt.git"
- Immortalwrt 21.02: "-b openwrt-21.02 --single-branch --filter=blob:none https://github.com/immortalwrt/immortalwrt"
- OpenWrt master: "https://github.com/openwrt/openwrt.git"
- OpenWrt 22.03:  "-b openwrt-22.03 --single-branch --filter=blob:none https://github.com/openwrt/openwrt.git"
- OpenCatLEDE: "https://github.com/miaoermua/OpenCatLEDE.git"


### Enter container

- Enter from the host.
  
  ```shell
  docker exec -it openwrt-build-env bash
  ```

### Custom build (after first build by default)

```shell
make menuconfig
make download -j$(nproc)
make V=s -j$(nproc)
```
