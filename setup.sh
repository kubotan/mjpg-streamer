#!/bin/bash

cp ./mjpg_streamer.service /etc/systemd/system/mjpg_streamer.service
systemctl daemon-reload
systemctl enable mjpg_streamer
systemctl start mjpg_streamer
