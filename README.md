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
$ ruby blink.rb > blink.log 2>&1 &
$ ruby server.rb > server.log 2>&1 &
```

## Setup jenkins

Jenkins should call the sinatra endpoint after every build reporting the build outcome.

Our simplistic approach so far is to add 2 `Post-build tasks` that find the status from the build log,
one finds `FAILURE` in the log the other finds `SUCCESS`,
then call `curl http://RASPBERRRY-IP:4567/builds/jobs?status=success` for the success case, and `curl http://RASPBERRRY-IP:4567/builds/jobs?status=failure` for the fail case.

## TODO

- redirect outputs to logs in the commands above or better use foreman
- fix the network flickering problem
- add an index to sinatra to list the builds

## Team

- Ricard Sole
- Krzysztof Herod
- Joaquin Rivera Padron @joahking

