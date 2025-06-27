cmake_minimum_required(VERSION 3.10)
project(DrogonApiApp)

# Установим стандарт C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Найдём Drogon
find_package(Drogon REQUIRED)

# Добавим исполняемый файл
add_executable(main main.cpp)

# Подключим Drogon к нашему исполняемому файлу
target_link_libraries(main PRIVATE Drogon::Drogon)

