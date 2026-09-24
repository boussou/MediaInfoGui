#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo ./install.sh"
    exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -p "Which flavour do you want? 1) Qt6  2) GTK3  3) GTK4  4) auto (recommended) [4]: " sel
sel=${sel:-4}

if [ "$sel" = "1" ]; then
    cp "$DIR"/MediaInfoGuiQt.desktop   /usr/share/applications/MediaInfoGui.desktop
    prompt="python3-pyqt6 (PyQt6)"
elif [ "$sel" = "2" ]; then
    cp "$DIR"/MediaInfoGuiGTK3.desktop /usr/share/applications/MediaInfoGui.desktop
    prompt="python3-gi with GTK3"
elif [ "$sel" = "3" ]; then
    cp "$DIR"/MediaInfoGuiGTK4.desktop /usr/share/applications/MediaInfoGui.desktop
    prompt="python3-gi with GTK4"
elif [ "$sel" = "4" ]; then
    # no toolkit in the Exec line - MediaInfoGui.py picks GTK4, GTK3 or Qt6
    # depending on what is installed
    cp "$DIR"/MediaInfoGui.desktop     /usr/share/applications/MediaInfoGui.desktop
    prompt="python3-gi (GTK3/GTK4) or python3-pyqt6 (Qt6)"
else
    echo "Invalid choice. Aborting."
    exit 1
fi

install -d /opt/mediainfogui
cp "$DIR"/*.py  /opt/mediainfogui/
cp "$DIR"/*.png /opt/mediainfogui/
chmod 755 /opt/mediainfogui/MediaInfoGui.py

ln -sf /opt/mediainfogui/MediaInfoGui.py /usr/bin/mediainfogui

echo "MediaInfoGui installed."
echo "Required packages: mediainfo ${prompt}"
echo "Optional: ffprobe (from ffmpeg) for MPEG-TS program info"
