# Listar los nombres de los contenedores
# Preguntar si desea reiniciar el back, front o un contendeor en específico
# si elige back, reiniciar_back.sh
# si elige front, reiniciar_front.sh
# reconstruir imagen de contenedor
#  escriba el nombre del contenedor que desea reiniciar de la lista presentada anterior mente


docker ps --format "table {{.Names}}"
echo ""
echo ""
echo "##############################################"
echo "1. Reiniciar contenedor en específico"
echo "2. Reconstruir imagen de contenedor"
echo "3. Levantar contenedores caidos"
echo "0. Salir"
echo "###############################################"
echo ""
echo ""

read -p "Escriba el número de la opción que desea ejecutar: " opcion

if [ $opcion -eq 1 ]; then
    echo "Reiniciando contenedor en específico"
    read -p "Escriba el nombre del contenedor que desea reiniciar: " nombre_contenedor
    docker restart $nombre_contenedor
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}" > tabla_contenedores.txt
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}"

elif [ $opcion -eq 2 ]; then
    echo "Reconstruir imagen de contenedor"
    read -p "Escriba el nombre del contenedor que desea reconstruir: " nombre_contenedor
    docker stop $nombre_contenedor
    docker rm $nombre_contenedor
    docker-compose build $nombre_contenedor
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}" > tabla_contenedores.txt
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}"
elif [ $opcion -eq 3 ]; then
    echo "Levantando contenedores caidos"
    docker-compose up -d
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}" > tabla_contenedores.txt
    docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Size}}"
elif [ $opcion -eq 0 ]; then
    echo "Listo."
else
    echo "Opción no válida"
fi
