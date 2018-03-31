#!/bin/bash

apt-get install git libjpeg-dev imagemagick cmake checkinstall libv4l-dev
make USE_LIBV4L2=true clean all
make install
