docker login -u "intelnexoec" -p "dckr_pat_EY2hedAJR91hc9Vn9Hx6-qVpgg0"
docker-compose build
docker-compose up -d
docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}\t{{.Status}}"
