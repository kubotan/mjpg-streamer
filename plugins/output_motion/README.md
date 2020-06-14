mjpg-streamer output plugin: output_motion
==========================================

This is a motion detection plugin that will call helper script on motion started/stopped event.

Requires development JPEG library.

Usage
=====

    mjpg_streamer [input plugin options] -o 'output_motion.so --foreground-diff-threshold 35 --background-learning-rate 0.01 --motion-noise-threshold 0.002 --status_file /var/log/mjpg-streamer/status'
