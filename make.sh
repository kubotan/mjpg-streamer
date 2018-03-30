#!/bin/bash

apt-get install git libjpeg-dev imagemagick cmake checkinstall libv4l-dev
make USE_LIBV4L2=true clean all
make install
cp ./mjpg_streamer.service /etc/systemd/system/mjpg_streamer.service
systemctl daemon-reload
systemctl enable mjpg_streamer
systemctl start mjpg_streamer
