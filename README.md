# Firejava
Firefox and Java on a Ubuntu container, for when you need to go back in time to use a Java Applet.

Use it like this:
```shell
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix firejava
```
## Known problems
* Only works for uid 1000 (tipically, the first registered user on a Ubuntu installation)
* Tested only on Ubuntu 17.10

