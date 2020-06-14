###############################################################
#
#   mjpg-streamer
#
#   This Makefile is just a wrapper around cmake, if you want
#   to do more complex things than what is provided here you 
#   should use cmake directly.
#
###############################################################

.DEFAULT_GOAL: all
.PHONY: all clean distclean install
	
CMAKE_BUILD_TYPE ?= Release
	
all:
	[ -d _build ] || mkdir _build
	[ -d _build ] || mkdir -p /var/log/mjpg-streamer
	[ -f _build/Makefile ] || (cd _build && cmake  -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) ..)
	make -C _build
	
	@cp _build/mjpg_streamer .
	@find _build -name "*.so" -type f -exec cp {} . \;
	
install:
	make -C _build install
	
clean:
	rm -f mjpg_streamer
	rm -f *.so
	rm -rf _build
