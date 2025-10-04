#!/bin/bash
# Auto restart dari GitHub trigger

REPO_URL="https://raw.githubusercontent.com/USERNAME/REPO/main/restart.flag"
LOCAL_FLAG="/root/restart.flag"

# Download file terbaru
curl -s -o /root/latest.flag $REPO_URL

# Bandingkan dengan versi lama
if ! cmp -s /root/latest.flag $LOCAL_FLAG; then
    echo "Perubahan terdeteksi di GitHub — menjalankan restart..."
    systemctl restart nginx
    systemctl restart paradis
    systemctl restart sketsa
    systemctl restart drawit
    mv /root/latest.flag $LOCAL_FLAG
else
    echo "Tidak ada perubahan, skip..."
    rm -f /root/latest.flag
fi
