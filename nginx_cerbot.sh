# instalar  nginx y certbot en ubuntu 20.04
# pedir dominio y correo


# instalar docker y docker-compose

sudo apt update

sudo apt install docker.io -y

sudo apt install docker-compose -y


# dar permisos a docker

sudo usermod -aG docker $USER


# instalar nodejs 18 y npm

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -

sudo apt-get install -y nodejs

# instalar pm2

sudo npm install pm2@latest -g

# instalar git

sudo apt install git -y

# Instalar nginx

sudo apt update

sudo apt install nginx -y

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
echo " "
ruta="/etc/nginx/sites-available/$dominio"

contenido="server {
    listen 80;
    server_name $dominio;
    return 301 https://$dominio$request_uri;
}

server {
    listen 443 ssl;
    server_name $dominio;

    ssl_certificate /etc/letsencrypt/live/$dominio/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$dominio/privkey.pem;

    set $upstream 127.0.0.1:3000;

    underscores_in_headers on;
    location /.well-known {
      alias /var/www/ssl-proof/chatwoot/.well-known;
    }

  location / {
      proxy_pass_header Authorization;
      proxy_pass http://$upstream;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header X-Forwarded-Ssl on; # Optional

      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

      proxy_http_version 1.1;
      proxy_set_header Connection “”;
      proxy_buffering off;

      client_max_body_size 0;
      proxy_read_timeout 36000s;
      proxy_redirect off;
    }

    location /admin_xfiv {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:3011/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:3011/ https://$dominio;
    }

    location /exchange/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:8093/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:8093/ https://$dominio;

    }

    location /accessconfig/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:3002/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:3002/ https://$dominio;
    }

    location /ocr/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:1221/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:1221/ https://$dominio;
    }

    location /internetbot/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:4202/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:4202/ https://$dominio;
    }

    location /keys/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:1010/;
    proxy_read_timeout      600;
    proxy_redirect  https://localhost:1010/ https://$dominio;
    }

    location /sensor/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:8088/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:8088/ https://$dominio;
    }

    location /whatsapp_qr/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:4203/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:4203/ https://$dominio;
    }

    location /upload/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:4030/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:4030/ https://$dominio;
    }

    location /cloud-dev/ {
    proxy_set_header Upgrade           $http_upgrade;
    proxy_set_header Connection        "upgrade";
    proxy_set_header Host              $host;
    proxy_set_header X-Real-IP         $remote_addr;
    proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host  $host;
    proxy_set_header X-Forwarded-Port  $server_port;
    proxy_pass      http://localhost:3005/;
    proxy_read_timeout      600;
    proxy_redirect  http://localhost:3005/ https://$dominio;
    }

}"

echo "$contenido" > "$ruta"

sudo ln -s /etc/nginx/sites-available/$dominio /etc/nginx/sites-enabled/
sudo systemctl restart nginx
echo "reiniciando nginx"

