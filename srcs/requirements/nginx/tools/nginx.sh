#!/bin/bash

# Generate a self-signed SSL certificate if it doesn't exist
if [ ! -f "$CERTS" ] || [ ! -f "$CERTS_KEY" ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERTS_KEY" -out "$CERTS" \
    -subj "/C=MA/L=Agadir/O=UM6P/OU=1337/CN=localhost"
fi


envsubst '${CERTS} ${CERTS_KEY} ${LOGIN}' \
< /etc/nginx/sites-enabled/default \
> /etc/nginx/sites-enabled/default.tmp

# Move the temporary file to the final location
mv /etc/nginx/sites-enabled/default.tmp /etc/nginx/sites-enabled/default

# Ensure the proper ownership for the web directory
chown -R www-data:www-data /var/www/html/

# Start NGINX
nginx -g "daemon off;"
