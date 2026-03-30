# DevOps for Developers Project 74

JS Fastify Blog — приложение для блога, упакованное в Docker с полной CI/CD интеграцией.

## Требования к системе

- Docker Desktop (Windows/Mac) или Docker Engine (Linux)
- Docker Compose v2+
- Git
- Make (опционально, для удобства)

## Быстрый старт

### Клонирование репозитория

```bash
git clone git@github.com:SspablosS/devops-for-developers-project-74.git
cd devops-for-developers-project-74
```

### Запуск приложения (локальная разработка)

```bash
# Запуск всех сервисов (app, db, caddy)
make dev
# или
docker-compose up

# Приложение доступно по адресу:
# http://localhost → редирект на https://localhost
# https://localhost → главная страница
```

### Запуск тестов

```bash
# Запуск тестов через Docker Compose
make ci
# или
docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app
```

### Сборка production-образа

```bash
make build
# или
docker-compose -f docker-compose.yml build app
```

### Push на Docker Hub

```bash
make push
# или
docker-compose -f docker-compose.yml push app
```

## Docker Hub образ

**sspabloss/devops-for-developers-project-74:latest**

Запуск production-образа:

```bash
docker run -p 8080:8080 -e NODE_ENV=development sspabloss/devops-for-developers-project-74:latest make dev
```

## Архитектура

### Сервисы

| Сервис | Описание | Порты |
|--------|----------|-------|
| app | Node.js + Fastify приложение | 8080 (внутренний) |
| db | PostgreSQL база данных | 5432 (внутренний) |
| caddy | Reverse proxy с HTTPS | 80, 443 |

### Переменные окружения

Приложение конфигурируется через переменные окружения:

| Переменная | Описание | Значение по умолчанию |
|------------|----------|----------------------|
| DATABASE_HOST | Хост базы данных | db |
| DATABASE_NAME | Имя базы данных | postgres |
| DATABASE_USERNAME | Пользователь БД | postgres |
| DATABASE_PASSWORD | Пароль БД | password |
| DATABASE_PORT | Порт БД | 5432 |
| NODE_ENV | Окружение (development/production/test) | development |

## Makefile команды

| Команда | Описание |
|---------|----------|
| `make setup` | Установка зависимостей |
| `make dev` | Запуск для разработки |
| `make test` | Запуск тестов |
| `make ci` | CI команда (тесты) |
| `make build` | Сборка production-образа |
| `make push` | Пуш образа на Docker Hub |
| `make up` | Запуск в фоне |
| `make down` | Остановка контейнеров |
| `make logs` | Просмотр логов |

## CI/CD

Проект использует GitHub Actions для непрерывной интеграции:

- **Тесты** — запускаются при каждом push и pull request
- **Build & Push** — при пуше в ветку `main`

[![CI](https://github.com/SspablosS/devops-for-developers-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/SspablosS/devops-for-developers-project-74/actions/workflows/push.yml)

## Структура проекта

```
.
├── .github/workflows/
│   ├── hexlet-check.yml    # Hexlet проверки
│   └── push.yml            # CI workflow
├── services/caddy/
│   └── Caddyfile           # Конфигурация Caddy
├── app/                    # Исходный код приложения
├── docker-compose.yml      # Production конфигурация
├── docker-compose.override.yml  # Development конфигурация
├── Dockerfile              # Development Dockerfile
├── Dockerfile.production   # Production Dockerfile
├── Makefile                # Make команды
└── README.md
```
