DEL EXP ARISCTUNNEL
```bash
wget -O /usr/xp https://raw.githubusercontent.com/arivpnstores/izin/main/xp && chmod +x /usr/xp && /usr/xp
```
RESTART POTATO
```bash
(crontab -l 2>/dev/null; echo '0 0 * * * wget -q -O /usr/local/bin/restart.sh "https://raw.githubusercontent.com/arivpnstores/izin/main/restart.sh" && chmod +x /usr/local/bin/restart.sh && /usr/local/bin/restart.sh >> /var/log/restart.log 2>&1') | crontab -
```
