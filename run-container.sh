#!/usr/bin/env bash

# Имя образа (по умолчанию)
IMAGE_NAME=${1:-sisyphus-test}

# Путь к локальной папке import (обязательный параметр)
IMPORT_PATH=${2:-/home/denis/hasher/repo/x86_64/RPMS.hasher/}

# Точка монтирования внутри контейнера (по умолчанию)
CONTAINER_IMPORT_PATH=${3:-/home/testuser/import}

# Проверяем, задан ли путь к локальной папке
if [ -z "$IMPORT_PATH" ]; then
  echo "Error: Path to the local folder is required as the second argument." >&2
  echo "Usage: $0 <image-name> <import-path> [container-mount-path]" >&2
  exit 1
fi

# Проверяем, существует ли указанная папка
if [ ! -d "$IMPORT_PATH" ]; then
  echo "Error: Directory '$IMPORT_PATH' does not exist." >&2
  exit 1
fi

# Выводим информацию о запуске
echo "Starting container from image: $IMAGE_NAME"
echo "Mounting local directory: $IMPORT_PATH -> $CONTAINER_IMPORT_PATH"

# Запускаем контейнер
podman run -it --rm \
  -v "$IMPORT_PATH":"$CONTAINER_IMPORT_PATH":Z \
  "$IMAGE_NAME"
