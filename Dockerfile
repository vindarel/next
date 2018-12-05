FROM debian:buster
# I first tried with ubuntu (16.04) from the daewok/lisp-devel image.
# But it uses Mir and I need compatibility with the X server.

RUN apt update && apt install -qy \
    sbcl \
    git-core \
    libwebkit2gtk-4.0-dev

# ahem, don't clone, use the local sources.
RUN git clone https://github.com/atlas-engineer/next /home/lisp/next

WORKDIR /home/lisp/next

RUN make all

# the doc says make all is enough but I need this
RUN make gtk-webkit

# XXX: this shows a blank window and loops on "Polling platform port..."
CMD cp ports/gtk-webkit/next-gtk-webkit /usr/local/bin/ && ./next

# and how to *see* the X11 GUI ?
# https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
# TO CONFIRM:
# docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix --net host -e DISPLAY=unix$DISPLAY --device /dev/snd next-on-debian

# on the host:
# xhost + to allow X11 connections.
# also xhost local:root ?
# https://stackoverflow.com/questions/28392949/running-chromium-inside-docker-gtk-cannot-open-display-0
