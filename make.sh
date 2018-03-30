#!/bin/bash

make USE_LIBV4L2=true clean all
make install
cp ./mjpg_streamer.service /etc/systemd/system/mjpg_streamer.service
systemctl daemon-reload
systemctl enable motioneye
systemctl start motioneye
