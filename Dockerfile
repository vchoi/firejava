# ref: http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/
FROM ubuntu:14.04

# Install Java
# ref: https://hub.docker.com/r/cmaohuang/firefox-java/
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/OracleJava.list && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java8-installer \
    oracle-java8-set-default dbus dbus-x11 && \
    dbus-uuidgen > /var/lib/dbus/machine-id

# Install FF prereqs and purge system firefox
RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -y firefox libgtk2.0-0\:i386 && \
    apt-get purge -y firefox

# Install and configure FF ESR
RUN wget -O - https://ftp.mozilla.org/pub/firefox/releases/52.9.0esr/linux-x86_64/en-US/firefox-52.9.0esr.tar.bz2 | tar -xjC /opt
COPY ./autoconfig.js /opt/firefox/browser/defaults/preferences/
COPY ./mozilla.cfg /opt/firefox/

RUN export uid=1000 gid=1000 &&\
    mkdir -p /home/user &&\
    echo "user:x:${uid}:${gid}:User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:${uid}:" >> /etc/group && \
    echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user && \
    chown ${uid}:${gid} -R /home/user

USER user
ENV HOME /home/user

VOLUME /home/user

ENTRYPOINT ["/opt/firefox/firefox", "--no-remote", "--setDefaultBrowser"]
# used for debugging. let me know if you know a better way to inspect an image
#CMD /bin/bash
