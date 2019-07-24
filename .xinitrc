#!/bin/sh
# initialize X resource database (if file ~/.Xresources is present on the system)
xrdb -load ~/.Xresources

# start single desktop enviroments/window managers:
# ============================================================
vmware-user &
# exec i3
exec gnome-session

# switching between desktop enviroments/window managers:
# ============================================================
