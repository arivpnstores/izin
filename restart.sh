#!/bin/bash
# Remote restart by GitHub schedule

REPO_URL="https://raw.githubusercontent.com/arivpnstores/izin/main/restart.flag"
LOCAL_FLAG="/usr/restart.flag"

# Ambil daftar jam dari GitHub (misal: 12,18)
SCHEDULE=$(curl -s $REPO_URL | tr -d '\r')
HOUR_NOW=$(date +%H)

# Cek apakah jam sekarang ada di daftar dari GitHub
if echo "$SCHEDULE" | grep -q "\b$HOUR_NOW\b"; then
    # Cegah restart berulang dalam 1 jam
    if [ "$(cat $LOCAL_FLAG 2>/dev/null)" != "$HOUR_NOW" ]; then
        echo "⏰ Jam cocok ($HOUR_NOW) — menjalankan restart..."
        systemctl restart nginx
        systemctl restart ssh sshd dropbear
        systemctl restart paradis
        systemctl restart sketsa
        systemctl restart drawit
        echo "$HOUR_NOW" > $LOCAL_FLAG
    else
        echo "Sudah restart di jam $HOUR_NOW, skip..."
    fi
else
    echo "Belum waktunya restart ($HOUR_NOW)..."
fi
