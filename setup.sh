#!/bin/bash

apt-get install git libjpeg-dev imagemagick cmake checkinstall libv4l-dev
make USE_LIBV4L2=true clean all
make install
crontab -l > crontabs.txt
echo "@reboot /usr/local/bin/mjpg_streamer -i 'input_uvc.so -f 30 -r 1280x720 -d /dev/video0 -n -q 100' -o 'output_http.so -p 8080' -o 'output_motion.so --foreground-diff-threshold 35 --background-learning-rate 0.01 --motion-noise-threshold 0.002" >> crontabs.txt
echo "@reboot /usr/local/bin/mjpg_streamer -i 'input_uvc.so -f 30 -r 1280x720 -d /dev/video1 -n -q 100' -o 'output_http.so -p 8081' -o 'output_motion.so --foreground-diff-threshold 35 --background-learning-rate 0.01 --motion-noise-threshold 0.002" >> crontabs.txt
crontab crontabs.txt
rm -f crontabs.txt
