#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo ./uninstall.sh"
    exit 1
fi

rm -rf /opt/mediainfogui
rm -f  /usr/bin/mediainfogui
rm -f  /usr/share/applications/MediaInfoGui.desktop

echo "MediaInfoGui uninstalled."
