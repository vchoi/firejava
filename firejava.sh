#!/bin/sh
docker run --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v firejava_home:/home/user vchoi/firejava
