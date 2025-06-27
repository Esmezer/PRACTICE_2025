# FROM gcc:4.9
# COPY . /src
# WORKDIR /src
# RUN gcc -o myapp main.cpp
# CMD ["./myapp"]


# # --- Этап 1: Сборка приложения (builder stage) ---
# # Используем более свежий образ GCC, который может быть оптимизирован
# FROM gcc:latest AS builder

# # Устанавливаем необходимые зависимости для сборки, если они есть
# # Для Drogon это может быть cmake, openssl-dev, libjsoncpp-dev и т.д.
# # Пример:
# # RUN apt-get update && apt-get install -y cmake libssl-dev libjsoncpp-dev && rm -rf /var/lib/apt/lists/*

# WORKDIR /src

# # Копируем только то, что нужно для сборки
# COPY . /src

# # Команда компиляции
# # Если у вас Drogon, здесь будет что-то вроде cmake . && make
# RUN gcc -o myapp main.cpp


# # --- Этап 2: Запуск приложения (runtime stage) ---
# # Используем минимальный образ для запуска.
# # alpine очень маленький, но для C++ приложений на Debian/Ubuntu
# # часто нужен debian:stable-slim или debian:bookworm-slim
# FROM debian:bookworm-slim

# # Устанавливаем runtime зависимости, если они нужны и не входят в slim образ
# # Например, если ваше приложение динамически линкуется с какой-либо библиотекой
# # RUN apt-get update && apt-get install -y libstdc++6 # Пример для C++

# WORKDIR /app

# # Копируем скомпилированный исполняемый файл из первого этапа
# COPY --from=builder /src/myapp /app/myapp

# # Открываем порт, если это REST API (для Drogon, скорее всего, 8080)
# #EXPOSE 8080

# # Запускаем ваше приложение
# CMD ["./myapp"]


# --- Этап 1: Сборка приложения (builder stage) ---
# Используем образ с компилятором (gcc:latest - это обычно более свежий и может быть более оптимизированный образ)
# FROM gcc:latest AS builder

# WORKDIR /src

# # Копируем только ваш исходный файл main.cpp
# COPY main.cpp .

# # Компилируем ваше C++ приложение
# # Создаем исполняемый файл с именем myapp
# RUN g++ main.cpp -o myapp

# # --- Этап 2: Запуск приложения (runtime stage) ---
# # Используем минимальный образ для запуска.
# # debian:bookworm-slim - это очень маленький образ, основанный на Debian.
# # Он содержит только самые необходимые системные библиотеки.
# FROM debian:bookworm-slim

# WORKDIR /app

# # Копируем скомпилированный исполняемый файл из первого этапа
# # COPY --from=builder /src/myapp /app/myapp
# # Для простейшей программы Hello World, возможно, вам даже не нужна libstdc++6 явно,
# # но для более сложных C++ программ она может потребоваться.
# # Если столкнетесь с ошибками при запуске, раскомментируйте строку ниже:
# RUN apt-get update && apt-get install -y libstdc++6 && rm -rf /var/lib/apt/lists/*

# COPY --from=builder /src/myapp /app/myapp

# # Запускаем ваше приложение при старте контейнера
# CMD ["./myapp"]


# # --- Этап 1: Сборка приложения (builder stage) ---
# # Используем образ с компилятором gcc:latest
# # --- Этап 1: Сборка приложения (builder stage) ---
# # Используем стабильный Debian образ и устанавливаем инструменты сборки
# FROM debian:bookworm AS builder

# # Устанавливаем build-essential (GCC, G++, make и т.д.)
# RUN apt-get update && apt-get install -y build-essential \
#     # Очищаем кэш apt, чтобы уменьшить размер образа
#     && rm -rf /var/lib/apt/lists/*

# WORKDIR /src

# # Копируем ваш исходный файл main.cpp
# COPY main.cpp .

# # Компилируем ваше C++ приложение
# # Создаем исполняемый файл с именем myapp
# RUN g++ main.cpp -o myapp

# # --- Этап 2: Запуск приложения (runtime stage) ---
# # Используем минимальный образ для запуска
# FROM debian:bookworm-slim

# WORKDIR /app

# # Устанавливаем libstdc++6, если она нужна и отсутствует в slim-образе
# # Этот шаг должен быть достаточным для простых программ
# RUN apt-get update && apt-get install -y libstdc++6 \
#     # Очищаем кэш apt
#     && rm -rf /var/lib/apt/lists/*

# # Копируем скомпилированный исполняемый файл из первого этапа
# COPY --from=builder /src/myapp /app/myapp

# # Запускаем ваше приложение при старте контейнера
# CMD ["./myapp"]


# Используем официальный образ Drogon с CMake и g++
FROM drogonframework/drogon

# Установка рабочей директории
WORKDIR /app

# Копируем проект в контейнер
COPY . /app

# Собираем проект
RUN mkdir -p build && cd build && cmake .. && make

# Запуск
CMD ["./build/main"]



