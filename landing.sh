#!/bin/bash

# Directorio temporal de destino
LANDING_DIR="/home/hadoop/landing"

# URL del archivo a descargar (versión raw)
FILE_URL="https://raw.githubusercontent.com/fpineyro/homework-0/master/starwars.csv"

# Directorio de HDFS de destino
HDFS_INGEST_DIR="/ingest"

# Nombre del archivo
FILE_NAME="starwars.csv"

# 1. Crear el directorio temporal si no existe
echo "Creando el directorio temporal $LANDING_DIR si no existe..."
mkdir -p "$LANDING_DIR"

# 2. Descargar el archivo al directorio temporal usando wget
echo "Descargando el archivo $FILE_NAME al directorio $LANDING_DIR..."
wget -O "$LANDING_DIR/$FILE_NAME" "$FILE_URL"

# Verificar si la descarga fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: La descarga del archivo falló. Por favor, asegúrate de que 'wget' esté instalado y que la URL sea correcta."
    exit 1
fi

# 3. Enviar el archivo a HDFS
echo "Enviando el archivo a HDFS en el directorio $HDFS_INGEST_DIR..."
# Utiliza -f para sobrescribir si el archivo ya existe en HDFS
hdfs dfs -put -f "$LANDING_DIR/$FILE_NAME" "$HDFS_INGEST_DIR"

# Verificar si la subida a HDFS fue exitosa
if [ $? -ne 0 ]; then
    echo "Error: La subida a HDFS falló."
    exit 1
fi

# 4. Borrar el archivo del directorio temporal
echo "Borrando el archivo local..."
rm "$LANDING_DIR/$FILE_NAME"

echo "Script terminado. El archivo se ha movido exitosamente a HDFS."