# Firejava
Firefox and Java on a Ubuntu container, for when you need to go back in time
to use a Java Applet but don't want to mess with your default Firefox profile.

## Usage
To launch a fresh new browser with no data persistence. Docker creates a
temporary volume and mounts it in user's home directory. The home directory is
automagically purged as soon as firefox quits.
```shell
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix vchoi/firejava
```

If you want, you may add a named volume to get data persistence. Firefox
profile, downloaded files and any applet data should be stored there.
```shell
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v firejava_home:/home/user vchoi/firejava
```

I recommend that you install the launcher script firejava.sh to some directory
in you $PATH. Mine is at /usr/local/bin/firejava. Then, press ALT+F2 and type
firejava to start the java-enabled browser whenever you need to.

If you're into Dock icons, copy the file firejava.desktop into
~/.local/share/applications/, press SUPER, type firejava and drag the icon
to the dock. I'm happier with the ALT+F2 shortcut, though.

## Known problems
* Only works for uid 1000 (tipically, the first registered user on a Ubuntu
  installation).
* Tested only on Ubuntu 17.10
