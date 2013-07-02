## メモ

* user,password は nexus,nexus です。
* 無線LANの設定は /etc/network/interfaces にssid,passwordを入力すると良いです。

```bash:/etc/network/interfaces例
auto wlan0
iface wlan0 inet dhcp
    wpa-ssid "Xperia Z"
    wpa-psk "ab345678"
```

* bluetoothとsuspendはわからなかったので対応できてません。

----

## 作り方

```bash:debootstrapの手順
$ sudo apt-get install debootstrap
$ mkdir /newdir
$ sudo -s
> debootstrap raring /newdir http://jp.archive.ubuntu.com/ports/
> cp -p /etc/apt/sources.list etc/apt/
> cp -p /etc/fstab etc/apt/
> cp -p /etc/hosts etc/
> cp -p /etc/init/ttyGS0.conf /etc/init/
> cp -p /etc/network/interfaces etc/network

> chroot /newdir
> adduser nexus
> passwd nexus
> usermod -G sudo nexus
> apt-get update
> apt-get install ssh wpasupplicant wireless-tools
> locale-gen ja_JP.UTF-8
> dpkg-reconfigure tzdata →　Asia/Tokyoを選択。
> exit
```

----

母艦から $ adb shell

recovery mode から操作


```bash:

> cd /data/
> mkdir old
> mv [^n]* old
> mv newdir/* .
> rm -r dev lib boot
> mv old/{dev,lib,boot} .
> reboot

```


----

母艦から $ sudo screen /dev/ttyACM0

以上。

----

partitionsメモ
----

$ ls -l /dev/block/platform/sdhci-tegra.3/by-name/
lrwxrwxrwx root root 2012-06-28 11:51 APP -> /dev/block/mmcblk0p3
lrwxrwxrwx root root 2012-06-28 11:51 CAC -> /dev/block/mmcblk0p4
lrwxrwxrwx root root 2012-06-28 11:51 LNX -> /dev/block/mmcblk0p2 (/boot)
lrwxrwxrwx root root 2012-06-28 11:51 MDA -> /dev/block/mmcblk0p8
lrwxrwxrwx root root 2012-06-28 11:51 MSC -> /dev/block/mmcblk0p5
lrwxrwxrwx root root 2012-06-28 11:51 PER -> /dev/block/mmcblk0p7
lrwxrwxrwx root root 2012-06-28 11:51 SOS -> /dev/block/mmcblk0p1
lrwxrwxrwx root root 2012-06-28 11:51 UDA -> /dev/block/mmcblk0p9 (/data/)
lrwxrwxrwx root root 2012-06-28 11:51 USP -> /dev/block/mmcblk0p6 

* APP -> system
* CAC -> cache
* LNX -> boot.img
* MDA -> Unknown
* MSC -> Misc (bootloader commands and other misc stuff )
* PER -> usually a fat partition containing sensor calibration etc. - per device provisioned.
* SOS -> recovery.img
* UDA -> /data - "user data area"
* USP -> Staging
