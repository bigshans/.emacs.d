docker run --name emacs -v /tmp/.X11-unix:/tmp/.X11-unix:ro\
 -e DISPLAY="unix$DISPLAY"\
 -e UNAME="emacser"\
 -e GNAME="emacsers"\
 -e UID="1000"\
 -e GID="1000"\
 -v /home/bigshans/:/home/emacs/\
 -v /tmp/emacs-2/:/tmp \
 jare/emacs emacs --fg-daemon
