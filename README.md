# xing-meets-robots

We've wired our Jenkins builds to call endpoints on a sinatra app to report the builds outcomes.
The sinatra server is running on a Raspberry Pi, the RPi then commands an Arduino over USB to blink,
fire office alarms and play Star Trek epic sounds (well, not that all) when a build is red!

This was our Innovation Week 09.2014 at XING's contest.

## Installation

ssh to the RPi and run:

```bash
$ artoo arduino install
$ artoo install socat
```

Get the address of the arduino:

```bash
$ dmesg # on a raspbian install

[   12.566256] usb 1-1.2: new full-speed USB device number 4 using dwc_otg
[   12.701183] usb 1-1.2: New USB device found, idVendor=2341, idProduct=0043
[   12.709892] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=220
[   12.720395] usb 1-1.2: Manufacturer: Arduino (www.arduino.cc)
[   12.727731] usb 1-1.2: SerialNumber: 5533033393035161B1D1
[   13.643661] cdc_acm 1-1.2:1.0: ttyACM0: USB ACM device
```

alternatively you can do

```bash
$ gort scan serial

[    0.000000] Kernel command line: dma.dmachans=0x7f35 bcm2708_fb.fbwidth=656 bcm2708_fb.fbheight=416 bcm2708.boardrev=0xe bcm2708.serial=0x55f06651 smsc95xx.macaddr=B8:27:EB:F0:66:51 sdhci-bcm2708.emmc_clock_freq=250000000 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000  dwc_otg.lpm_enable=0 console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait
[    0.000000] console [tty1] enabled
[    0.532925] dev:f1: ttyAMA0 at MMIO 0x20201000 (irq = 83, base_baud = 0) is a PL011 rev3
[    0.891390] console [ttyAMA0] enabled
[    6.570000] cdc_acm 1-1.3:1.0: ttyACM0: USB ACM device
```

Address of arduino in the example is ttyACM0

## Run the "server"

ssh to the RPi and run:

 ```bash
$ artoo arduino connect ttyACM0 8023 > artoo.log 2>&1 &
$ ruby lib/robots.rb > robots.log 2>&1 &
$ ruby lib/server.rb > server.log 2>&1 &
 ```

## Setup jenkins

Jenkins should call the sinatra endpoint after every build reporting the build outcome.

Our simplistic approach so far is to add 2 `Post-build tasks` that find the status from the build log,
one finds `FAILURE` in the log the other finds `SUCCESS`,
then call `curl http://RASPBERRRY-IP:4567/builds/jobs?status=success` for the success case, and `curl http://RASPBERRRY-IP:4567/builds/jobs?status=failure` for the fail case.

## TODO

- fix the network flickering problem
- ...eternity...
- redirect outputs to logs in the commands above or better use foreman
- add an index to sinatra to list the builds

## Team

- Ricard Sole
- Krzysztof Herod
- Joaquin Rivera Padron @joahking

