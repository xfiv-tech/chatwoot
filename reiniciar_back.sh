# reiniciar contenedeores del back

cd back docker-compose down --rmi all --remove-orphans

cd back && docker-compose up -d
