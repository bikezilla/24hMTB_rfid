24hMTB_rfid
===========

Ruby script to read RFID tags and write time stamps to a file

# Cheatsheet

##### Set date

`date --set='2016-09-20 12:00'`

##### Add / remove service on boot

`service --status-all`
`update-rc.d -f rfid remove`
`update-rc.d rfid disable`


##### Reload udev rules

`udevadm control --reload-rules`

##### Set custom terminal geometry

`resize` - sets to current terminal window
`stty rows 50 cols 120`

# Setting up UDEV rules
`udevadm info -a -p $(udevadm info -q path -n /dev/sdd1)`

Look for idVendor and idProduct.

# MAC serial cable drivers

http://osxdaily.com/2015/10/05/disable-rootless-system-integrity-protection-mac-os-x/
https://www.olimex.com/forum/index.php?topic=3640.0
http://www.prolific.com.tw/US/ShowProduct.aspx?p_id=229&pcid=41
http://www.xbsd.nl/2011/07/pl2303-serial-usb-on-osx-lion.html
http://demin.ws/blog/english/2012/07/10/usb-serial-console-for-rpi-on-macosx-olimex-usb-serial-cable/

# Links

https://mmonit.com/monit/documentation/monit.html
https://digitizor.com/how-to-enable-monit-web-interface-from-all-ips-and-change-port/

http://hackaday.com/2009/09/18/how-to-write-udev-rules/
