#!/bin/bash

# Generate a self-signed SSL certificate if it doesn't exist
if [ ! -f "$CERTS" ] || [ ! -f "$CERTS_KEY" ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$CERTS_KEY" -out "$CERTS" \
    -subj "/C=MA/L=Agadir/O=UM6P/OU=1337/CN=localhost"
fi

# Use envsubst to replace environment variables in the NGINX config
envsubst '${CERTS} ${CERTS_KEY} ${LOGIN}' \
< /etc/nginx/sites-enabled/default \
> /etc/nginx/sites-enabled/default.tmp

# Move the temporary file to the final location
mv /etc/nginx/sites-enabled/default.tmp /etc/nginx/sites-enabled/default

mkdir -p /etc/nginx/ssl

# Ensure the proper ownership for the web directory
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Output the NGINX configuration to verify
echo "# Output the NGINX configuration to verify"
cat /etc/nginx/sites-enabled/default

# Start NGINX
nginx -g "daemon off;"
