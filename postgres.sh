# instalar postgres

sudo apt update

sudo apt install postgresql postgresql-contrib -y

sudo -u postgres psql -c "CREATE USER xfivdev WITH PASSWORD 'dev*2023';"

sudo -u postgres psql -c "ALTER USER xfivdev WITH SUPERUSER;"

sudo -u postgres psql -c "CREATE DATABASE chatwoot;"

sudo -u postgres psql -c "CREATE DATABASE typebot;"

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE chatwoot TO xfivdev;"

sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE typebot TO xfivdev;"

sudo -u postgres psql -c "ALTER USER xfivdev CREATEDB;"

sudo -u postgres psql -c "ALTER USER xfivdev WITH PASSWORD 'dev*2023';"

sudo -u postgres psql -c "ALTER USER xfivdev WITH SUPERUSER;"
