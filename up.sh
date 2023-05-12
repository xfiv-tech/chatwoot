docker login -u "intelnexoec" -p "dckr_pat_EY2hedAJR91hc9Vn9Hx6-qVpgg0"
docker network create xfiv-dev
docker-compose build
docker-compose run --rm rails bundle exec rails db:chatwoot_prepare
docker exec -it $(basename $(pwd))_rails_1 sh -c 'RAILS_ENV=production bundle exec rails c'
docker-compose up -d
#--remove-orphans
echo "Ahora se ejecutará el comando para crear el back interno de chatwoot personalizado"
seelp 5

# cd back && docker-compose up -d
echo "Up se ejecutó correctamente"
echo ""
echo "Este comando se ejecutó solo una vez, si desea volver a ejecutarlo, debe ejecutar el comando down.sh y luego up.sh"
echo "Si quieres reiniciar los contenedores del back reiniciar_back.sh"
