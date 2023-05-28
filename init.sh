docker-compose build

docker-compose run --rm rails bundle exec rails db:chatwoot_prepare

docker-compose up -d

docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}" > tabla_contenedores.txt

