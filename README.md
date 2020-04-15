## Using

Download

```
sudo git clone https://github.com/fivemru/certbot-boilerplate.git /var/www/certbot
cd /var/www/certbot && sudo rm -fr .git
```

First run:

```
sudo ./init-certbot.sh
sudo docker-compose up -d
```

Then update cert path in `/etc/nginx/sites-enabled/site.conf` and reload nginx.

---

Scheduled nginx reload via cron (to apply new certificates):

```
sudo crontab -u root -e
```

Insert this cron task:

```
@daily sudo nginx -t && sudo nginx -s reload &>> /var/log/nginx-cron.log
```
