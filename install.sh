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

sudo certbot --nginx -d cloud-dev.xfiv.chat -m dmarret@intelnexo.com --agree-tos --redirect

sudo cp default.nginx /etc/nginx/sites-available/cloud-dev.xfiv.chat
sudo ln -s /etc/nginx/sites-available/cloud-dev.xfiv.chat /etc/nginx/sites-enabled/cloud-dev.xfiv.chat


sudo systemctl status certbot.timer

sudo certbot renew --dry-run

sudo systemctl restart nginx
