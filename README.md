# ALT Package Tester

## Описание
**ALT Package Tester** — это система для тестирования пакетов в изолированном контейнере на базе ALT Linux Sisyphus.

## Структура проекта
```
.
├── build-image.sh                # Скрипт сборки Docker-образа
├── devel-dependencies.txt        # Зависимости для тестирования внутри контейнера
├── Dockerfile                    # Dockerfile для создания тестового контейнера
├── package-dependencies/         # Директория с зависимостями пакетов
│   ├── cement.txt                # Зависимости для пакета Cement
│   └── empty.txt                 # Пустой файл зависимостей
└── run-container.sh              # Скрипт запуска контейнера
```

## Начало работы

### 1. Клонирование репозитория
```bash
git clone https://github.com/zef2f/alt-package-tester.git
cd alt-package-tester
```

### 2. Настройка зависимостей
Создайте файл в `package-dependencies/` с зависимостями тестируемого пакета.

Пример: `package-dependencies/my-package.txt`
```
python3-module-example
python3-module-sample
```

### 3. Сборка Docker-образа
```bash
./build-image.sh sisyphus-test ./Dockerfile my-package.txt
```

### 4. Запуск контейнера
```bash
./run-container.sh sisyphus-test /path/to/local/import /home/testuser/import
```

### Параметры `run-container.sh`
- **`<image-name>`** — имя Docker-образа (по умолчанию `sisyphus-test`).
- **`<import-path>`** — путь к локальной папке с RPM-пакетами для монтирования.
- **`[container-mount-path]`** — точка монтирования в контейнере (по умолчанию `/home/testuser/import`).

## Как добавить новый пакет
1. Создайте файл зависимостей в `package-dependencies/`.
2. Убедитесь, что зависимости правильные.
3. Выполните сборку и запуск контейнера.

## Лицензия
Проект лицензирован под MIT License. Подробнее см. в файле [LICENSE](LICENSE).


