# Базовый образ ALT Linux Sisyphus
FROM registry.altlinux.org/alt/alt:sisyphus

# Аргументы для пользователя
ARG cuid=500
ARG cgid=500
ARG cuidname=testuser
ARG cgidname=testgroup
ARG PACKAGE_DEPENDENCIES_FILE="cement.txt"

# Обновляем систему
USER root
RUN apt-get update && apt-get dist-upgrade -y

# Копируем файлы зависимостей
COPY devel-dependencies.txt /tmp/devel-dependencies.txt
COPY package-dependencies/${PACKAGE_DEPENDENCIES_FILE} /tmp/package-dependencies.txt

# Устанавливаем зависимости разработки
RUN if [ -f "/tmp/devel-dependencies.txt" ]; then \
        xargs -a /tmp/devel-dependencies.txt apt-get install -y; \
    fi

# Устанавливаем зависимости пакета
RUN if [ -f "/tmp/package-dependencies.txt" ]; then \
        xargs -a /tmp/package-dependencies.txt apt-get install -y; \
    fi

# Устанавливаем sudo и настраиваем окружение
RUN apt-get install -y sudo && \
    control sudo public && \
    control sudowheel enabled

# Создаем пользователя для тестирования
RUN groupadd -g $cgid $cgidname && \
    groupadd sudo && \
    useradd -m -u $cuid -g $cgidname -G sudo -s /usr/bin/bash $cuidname && \
    echo "$cuidname ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Настраиваем hasher для тестового пользователя
RUN hasher-useradd $cuidname

# Устанавливаем рабочий каталог
USER $cuidname
WORKDIR /home/$cuidname

# Завершаем Dockerfile
CMD ["/bin/bash"]
