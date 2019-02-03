# Modem Utilities

An assorted collection of retrocomputing utilities.

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

Eventually, this will be a drop-in replacement for an analog modem. Will emulate an analog modem connecting to a dialup ISP. Will operate over null modem cable, eliminating the need for a physical modem.

**STATUS:** Work in progress. Gets you to the 3rd party auth screen of IE5 (Shiva dialer, really) and then crashes.

