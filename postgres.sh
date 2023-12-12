# instalar postgres

sudo apt update

sudo apt install postgresql postgresql-contrib -y

#sudo -u postgres psql -c "CREATE USER xfivdev WITH PASSWORD 'dev*2023';"

# Cambiar al usuario postgres y ejecutar comandos
sudo -u postgres psql -c "CREATE USER xfivdev WITH PASSWORD 'dev*2023';"
sudo -u postgres psql -c "ALTER USER xfivdev CREATEDB SUPERUSER;"

# Crear bases de datos
sudo -u postgres psql -c "CREATE DATABASE chatwoot;"
sudo -u postgres psql -c "CREATE DATABASE typebot;"

# Conceder privilegios al usuario
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE chatwoot TO xfivdev;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE typebot TO xfivdev;"
