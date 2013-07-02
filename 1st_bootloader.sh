#!/bin/sh
fastboot erase boot
#fastboot flash boot data/ubuntu-13.04-preinstalled-desktop-armhf+nexus7.bootimg
fastboot flash boot data/ubuntu.bootimg

fastboot erase recovery
fastboot flash recovery data/saucy-preinstalled-recovery-armel+grouper.img

fastboot erase userdata
#fastboot format userdata
#gzip -d data/ubuntu-13.04-preinstalled-desktop-armhf+nexus7.img.gz
#fastboot flash userdata data/ubuntu-13.04-preinstalled-desktop-armhf+nexus7.img

fastboot erase system
fastboot format system

fastboot erase cache
fastboot format cache

fastboot reboot-bootloader
#fastboot reboot

echo ""
echo "please boot your nexus7 to 'Recovery Mode' then 'sh 2nd_recoverymode.sh'."
echo ""
