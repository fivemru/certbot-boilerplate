## Use

First run:

```
sudo ./init-certbot.sh
sudo docker-compose up -d
```

---

Scheduled nginx reload via cron (to apply new certificates):

```
sudo crontab -u root -e
```

Insert this cron task:
```
@daily sudo nginx -t && sudo nginx -s reload &>> /var/log/nginx-cron.log
```