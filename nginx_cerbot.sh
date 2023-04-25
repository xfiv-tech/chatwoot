# instalar  nginx y certbot en ubuntu 20.04
# pedir dominio y correo

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
echo "server {
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

}"
echo " "
echo "Por favor, copia el codigo anterior y pegalo en el archivo de configuracion de nginx"
echo "Si nececita editar agalo bajo su responsabilidad"
echo "Cuando termie de copiar o editar presionar ctrl +d para finalizar la edicion del archivo."



if [ -f /etc/nginx/sites-enabled/$dominio ]; then
    echo "El archivo de configuracion ya existe"
    sleed 5
else
    sudo cat > /etc/nginx/sites-available/$dominio
    crearEnslaSimbolico
fi
sleep 5s



function crearEnslaSimbolico(){
  if [ -f /etc/nginx/sites-enabled/$dominio ]; then
      echo "El enlace simbolico ya existe"
      End
  else
      sudo ln -s /etc/nginx/sites-available/$dominio /etc/nginx/sites-enabled/
      End
  fi
}



# reiniciar nginx
function reiniciarNginx(){
  # sudo systemctl status certbot.timer
  sudo systemctl restart nginx
}

function End(){
  echo "proceso finalizado:"
  echo "reiniciando nginx"
  reiniciarNginx
  exit 0
}

