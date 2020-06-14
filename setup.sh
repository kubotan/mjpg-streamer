#!/bin/bash

apt-get install libjpeg-dev imagemagick cmake checkinstall libv4l-dev
make USE_LIBV4L2=true clean all
make install
crontab -l > crontabs.txt
#echo "@reboot iwconfig wlan0 txpower off" >> crontabs.txt
echo "@reboot /usr/local/bin/mjpg_streamer -b -i 'input_uvc.so -f 30 -r 1280x720 -d /dev/video0 -n -q 100' -o 'output_http.so -p 8080'" >> crontabs.txt
#echo "@reboot /usr/local/bin/mjpg_streamer -b -i 'input_uvc.so -f 30 -r 1280x720 -d /dev/video1 -n -q 100' -o 'output_http.so -p 8081'" >> crontabs.txt
#echo "@reboot /usr/local/bin/mjpg_streamer -b -i 'input_uvc.so -f 30 -r 1920x1080 -d /dev/video0 -y -n -q 100' -o 'output_http.so -p 8080'" >> crontabs.txt
crontab crontabs.txt
rm -f crontabs.txt
