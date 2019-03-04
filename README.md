# Modem Utilities

An assorted collection of retrocomputing utilities.

**AUTHOR'S NOTE:** This repo is more of a notes area for me now. If you have retro-internet questions, please raise an issue.

[Blog article describing my use of these tools - Part I](http://rickcarlino.com/2019/01/01/vintage-computer-restoration-part-i-html.html)
[Blog article describing my use of these tools - Part II](http://rickcarlino.com/2019/03/01/386-restoration-progress-part-ii-html.html)

## xmodem.rb

This tool allows you to send a single file over RS-232 using the XMODEM protocol. This allows file transfer over `terminal.exe` (Windows 3.1) or `hyperterm` (Windows 95 and above).

It supports the following config options (set via ENV vars):

 * `FILE` a REALATIVE path to the file you wish to send.
 * `PORT` The serial port you want to send it over. Default is `/dev/ttyUSB0`.
 * `BAUD` Data rate. Default is 9600 because I am targeting ancient computers.

EXAMPLE:

```
env FILE=placeholder.png ruby xmodem.rb
```

NOTES:

 * If you do not see `SYSTEM OK` on the distant end at startup, you do not have connectivity. Ensure that the distant end has the correct serial port settings.
 * Other options (such as data bits and stop bits) _could_ be configurable, but you will need to request it. Pease raise an issue if you have any questions.

**STATUS:** It works and I use it regularly with a USB RS-232 adapter on Windows 3.1.

## dial_in.rb

**STATUS:** Not stable. Gets you to the 3rd party auth screen of IE5 (Shiva dialer, really) and then crashes. Consider using `getty` and `slirp` instead.

## Notes Area: Trumpet Winsock

[Blog article that does a better job of describing the commands below](http://rickcarlino.com/2019/03/01/386-restoration-progress-part-ii-html.html)

TAB 1:

```
# Start SLIP
sudo slattach -s 19200 -p slip -d /dev/ttyUSB0
```

TAB 2:

```
# Bring up network interface:
sudo ifconfig sl0 192.168.5.1 netmask 255.255.255.0 up

# Network should now be "RUNNING". Check again:
ifconfig sl0

# Set up SLIP on distant end (192.168.5.2) and try to ping.
# Should have 0% packet loss:
ping 192.168.5.2
```

RETRO-side config:

 * Set your IP to `192.168.5.2`
 * Make sure you're using `slip`- not `ppp`, `cslip` or anything like that.

```
# Enable kernel-level IP forwarding:
sudo bash -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

# Enable NAT
sudo iptables --table nat --append POSTROUTING --out-interface wlp1s0 -j MASQUERADE
sudo iptables --append FORWARD --in-interface sl0 -j ACCEPT
```
That's It.

# Notes Area: Use SLiRP

https://manpages.ubuntu.com/manpages/xenial/man1/slirp.1.html
