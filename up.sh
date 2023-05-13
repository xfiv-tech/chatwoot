docker login -u "intelnexoec" -p "dckr_pat_EY2hedAJR91hc9Vn9Hx6-qVpgg0"
docker network create xfiv-dev
docker-compose build
docker-compose run --rm rails bundle exec rails db:chatwoot_prepare
docker exec -it $(basename $(pwd))_rails_1 sh -c 'RAILS_ENV=production bundle exec rails c'
docker-compose up -d
#--remove-orphans
docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}" > tabla_contenedores.txt
docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}"
seelp 5

# cd back && docker-compose up -d
