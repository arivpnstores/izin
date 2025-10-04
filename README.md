HANYA ADMIN!
RESTART POTATO
```bash
wget -O /usr/restart-services.sh https://raw.githubusercontent.com/arivpnstores/izin/main/restart.sh && chmod +x /usr/restart-services.sh && (crontab -l 2>/dev/null; echo "0 * * * * /usr/restart-services.sh >/dev/null 2>&1") | crontab -
```
