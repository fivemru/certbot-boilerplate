#!/bin/bash

set -e

# configuration
domains=(site.com www.site.com)
email="info@site.com"
rsa_key_size=2048
# Set to 1 if you're testing your setup to avoid hitting request limits
staging=0
# config dir
conf_dir="./conf"
www_dir="./www"
# /configuration

# check www and conf dir or create it
[ -d "$conf_dir" ] || mkdir $conf_dir
[ -d "$www_dir" ] || mkdir $www_dir

# check docker-compose
if ! [ -x "$(command -v docker-compose)" ]; then
  echo 'Error: docker-compose is not installed.' >&2
  exit 1
fi

echo "### Requesting Let's Encrypt certificate for $domains ..."
domain_args=""
for domain in "${domains[@]}"; do
  domain_args="$domain_args -d $domain"
done

# Select appropriate email arg
case "$email" in
"") email_arg="--register-unsafely-without-email" ;;
*) email_arg="--email $email" ;;
esac

# Enable staging mode if needed
if [ $staging != "0" ]; then staging_arg="--staging"; fi

# create config inside certbot container
docker-compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $staging_arg \
    $email_arg \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal" certbot

echo -e ""
echo -e "DONE"
