# cmake_minimum_required(VERSION 3.10)
# project(DrogonApiApp)

# # Установим стандарт C++17
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

# # Найдём Drogon
# find_package(Drogon REQUIRED)

# # Добавим исполняемый файл
# add_executable(main main.cpp)

# # Подключим Drogon к нашему исполняемому файлу
# target_link_libraries(main PRIVATE Drogon::Drogon)










cmake_minimum_required(VERSION 3.10)
project(DrogonApiApp)

# Установим стандарт C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Найдём Drogon
find_package(Drogon REQUIRED)

# Добавим исполняемый файл приложения
add_executable(main main.cpp)

# Подключим Drogon к нашему исполняемому файлу
target_link_libraries(main PRIVATE Drogon::Drogon)

# --- Добавление поддержки Google Test для юнит-тестов ---

# Добавляем поддиректорию googletest
add_subdirectory(googletest)

# Добавляем исполняемый файл для тестов
# Создайте директорию 'test' в корне вашего проекта и файл 'test_main.cpp' внутри нее.
add_executable(drogon_api_tests test/test_main.cpp)

# Привязываем Google Test к нашему тестовому исполняемому файлу
target_link_libraries(drogon_api_tests PRIVATE gtest_main)

# Включаем автоматический поиск тестов для CTest (для CI/CD)
enable_testing()
add_test(NAME DrogonApiUnitTests COMMAND drogon_api_tests)








# cmake_minimum_required(VERSION 3.10)
# project(DrogonApiApp)

# # Установим стандарт C++17
# set(CMAKE_CXX_STANDARD 17)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)

# # --- Добавление Drogon из исходников ---
# # Добавляем поддиректорию с исходным кодом Drogon
# # Теперь CMake будет компилировать Drogon как часть вашего проекта
# add_subdirectory(drogon)

# # Теперь Drogon доступен как таргет Drogon::Drogon

# # Добавим исполняемый файл приложения
# add_executable(main main.cpp)

# # Подключим Drogon к нашему исполняемому файлу
# # Мы линкуемся с таргетом Drogon::Drogon, который был создан после add_subdirectory
# # target_link_libraries(main PRIVATE Drogon::Drogon)
# target_link_libraries(main PRIVATE drogon) # Измените Drogon::Drogon на просто drogon

# # --- Добавление поддержки Google Test для юнит-тестов ---
# # Убедитесь, что папка googletest находится в корне проекта
# add_subdirectory(googletest)

# # Добавляем исполняемый файл для тестов
# # Убедитесь, что папка test/ с test_main.cpp находится в корне проекта
# add_executable(drogon_api_tests test/test_main.cpp)

# # Привязываем Google Test к нашему тестовому исполняемому файлу
# target_link_libraries(drogon_api_tests PRIVATE gtest_main)

# # Включаем автоматический поиск тестов для CTest (для CI/CD)
# enable_testing()
# add_test(NAME DrogonApiUnitTests COMMAND drogon_api_tests)
