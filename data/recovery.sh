#!/bin/sh

devices=`adb devices | grep recovery`
if [ "$devices" = "" ]; then
  echo "[error] device not found."
  echo "quit."
  exit 0
else
  echo "[info] device found $devices"
fi

arg1=$1
if [ ! -e "$arg1" ]; then
  echo "[error] $arg1 not found. (require tar.bz2 file.)"
  echo "quit."
  exit 0
fi

echo "arg1: $arg1"

set -x
adb shell umount /data
adb shell mke2fs /dev/block/platform/sdhci-tegra.3/by-name/UDA
adb shell mount /data
adb push "$arg1" /data/
adb shell tar jxf "/data/$arg1" -C /data/
adb shell rm "/data/$arg1"
adb shell df -h /data
adb shell sync
adb shell reboot
set +x
echo ""
echo "[info] should execute 'sudo screen /dev/ttyACM0' (user,pass=nexus,nexus)"
echo "[info] set your wireless station ssid,psk to /etc/network/interfaces"
echo "[info] then 'sudo service networking restart'"
echo ""
echo "done."
