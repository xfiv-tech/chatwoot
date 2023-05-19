# Listar los nombres de los contenedores
# Preguntar si desea reiniciar el back, front o un contendeor en específico
# si elige back, reiniciar_back.sh
# si elige front, reiniciar_front.sh
#  escriba el nombre del contenedor que desea reiniciar de la lista presentada anterior mente


docker ps --format "table {{.Names}}"
echo "Configuracion de contenedores: "
echo "1. Reiniciar back"
echo "2. Reiniciar front"
echo "3. Reiniciar contenedor en específico"

read -p "Escriba el número de la opción que desea ejecutar: " opcion

if [ $opcion -eq 1 ]
then
    echo "Reiniciando back"
    ./reiniciar_back.sh
elif [ $opcion -eq 2 ]
then
    echo "Reiniciando front"
    ./reiniciar_front.sh
elif [ $opcion -eq 3 ]
then
    echo "Reiniciando contenedor en específico"
    read -p "Escriba el nombre del contenedor que desea reiniciar: " nombre_contenedor
    docker restart $nombre_contenedor
else
    echo "Opción no válida"
fi
