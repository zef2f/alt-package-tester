#!/usr/bin/env bash

# Название образа
TAG=${1:-sisyphus-test}

# Путь к Dockerfile
DOCKERFILE_PATH=${2:-./Dockerfile}

# Имя файла зависимостей пакета
PACKAGE_DEPENDENCIES_FILE=${3:-empty.txt}

# Проверяем существование Dockerfile
if [ ! -f "$DOCKERFILE_PATH" ]; then
  echo "Ошибка: Dockerfile не найден по пути '$DOCKERFILE_PATH'." >&2
  exit 1
fi

# Проверяем существование файла зависимостей пакета
if [ ! -f "./package-dependencies/$PACKAGE_DEPENDENCIES_FILE" ]; then
  echo "Ошибка: Файл зависимостей '$PACKAGE_DEPENDENCIES_FILE' не найден в 'package-dependencies'." >&2
  exit 1
fi

echo "Начало сборки образа: $TAG с использованием Dockerfile: $DOCKERFILE_PATH и зависимостей: $PACKAGE_DEPENDENCIES_FILE"

# Сборка контейнера
if podman build -t "$TAG" --build-arg PACKAGE_DEPENDENCIES_FILE=$PACKAGE_DEPENDENCIES_FILE -f "$DOCKERFILE_PATH" .; then
  echo "Образ '$TAG' успешно собран."
else
  echo "Ошибка: Не удалось собрать образ '$TAG'." >&2
  exit 1
fi
