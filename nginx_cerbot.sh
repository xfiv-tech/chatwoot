# instalar  nginx y certbot en ubuntu 20.04
# pedir dominio y correo

# Instalar nginx

sudo apt update

sudo apt install nginx

# Instalar certbot

sudo apt install certbot python3-certbot-nginx -y

# pedir dominio y correo

echo "Introduce el dominio:"

read dominio

echo "Introduce el correo:"

read correo


# pedir certificado

sudo certbot --nginx -d $dominio -m $correo --agree-tos --redirect

# editar el archivo de configuracion de nginx

sudo nano /etc/nginx/sites-available/cloud-dev.xfiv.chat

# copiar el siguiente codigo

server {
    listen 80;
    listen [::]:80;
    server_name $dominio;
    return 301 https://$dominio$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name $dominio;

    ssl_certificate /etc/letsencrypt/live/$dominio/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$dominio/privkey.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Ssl on;
        proxy_redirect off;
    }
}

# guardar y salir



# activar el archivo de configuracion de nginx

sudo ln -s /etc/nginx/sites-available/cloud-dev.xfiv.chat /etc/nginx/sites-enabled/


# reiniciar nginx
sudo systemctl status certbot.timer

sudo systemctl restart nginx


