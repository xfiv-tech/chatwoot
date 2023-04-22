docker-compose run --rm rails bundle exec rails db:chatwoot_prepare
seelp 5
docker exec -it $(basename $(pwd))_rails_1 sh -c 'RAILS_ENV=production bundle exec rails c'
seelp 5
docker-compose up -d
#--remove-orphans
