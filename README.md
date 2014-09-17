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

ADDRESS_OF_ARDUINO in the example is ttyACM0

## Run the "server"

ssh to the RPi and run:

 ```bash
$ artoo arduino connect ADDRESS_OF_ARDUINO 8023 > artoo.log 2>&1 &
$ ruby lib/robots.rb > robots.log 2>&1 &
$ ruby lib/server.rb > server.log 2>&1 &
# example address is `/dev/cu.usbmodem1411`, but you might need to drop `/dev/` part
 ```

## Setup jenkins

## TODO

- redirect outputs to logs in the commands below or foreman better
- fix the network flickering problem
- add an index to sinatra to list the builds

## Team

- Ricard Sole
- Krzysztof Herod
- Joaquin Rivera Padron @joahking

