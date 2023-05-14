SET current_path=%cd%
ECHO %current_path%

docker run -it -v "%current_path%\release":/openwrt/release -v "%current_path%\config":/openwrt/config --env CONFIGFILE="xxxxxxxx" bkt92/openwrt-lede-build-env