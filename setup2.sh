#!/bin/bash

cp ./mjpg_streamer1.service /etc/systemd/system/mjpg_streamer1.service
systemctl daemon-reload
systemctl enable mjpg_streamer1
systemctl start mjpg_streamer1

cp ./mjpg_streamer2.service /etc/systemd/system/mjpg_streamer2.service
systemctl daemon-reload
systemctl enable mjpg_streamer2
systemctl start mjpg_streamer2
