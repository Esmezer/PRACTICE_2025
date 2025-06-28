// test/test_main.cpp
#include "gtest/gtest.h" // Заголовочный файл Google Test
#include <string>
#include <locale>
#include <codecvt>
#include <cwctype>

// ВНИМАНИЕ: В реальном проекте эту функцию (или другие тестируемые функции)
// следует вынести в отдельный заголовочный файл (.h) и .cpp файл,
// чтобы избежать дублирования кода. Для демонстрации я скопировал ее сюда.
std::string capitalizeFirstUtf8(const std::string &input) {
    if (input.empty()) return "";

    std::wstring_convert<std::codecvt_utf8<wchar_t>> conv;
    std::wstring wstr = conv.from_bytes(input);

    if (!wstr.empty()) {
        wstr[0] = std::towupper(wstr[0]);
    }

    return conv.to_bytes(wstr);
}


// Определяем набор тестов (Test Suite) для функции capitalizeFirstUtf8
TEST(CapitalizeTest, BasicAscii) {
    // Проверка с простой ASCII строкой
    EXPECT_EQ(capitalizeFirstUtf8("hello"), "Hello");
    EXPECT_EQ(capitalizeFirstUtf8("world"), "World");
    EXPECT_EQ(capitalizeFirstUtf8(""), ""); // Тест для пустой строки
}

TEST(CapitalizeTest, Utf8Cyrillic) {
    // Проверка с кириллицей
    // Убедитесь, что локаль корректно настроена для UTF-8
    std::setlocale(LC_ALL, "en_US.UTF-8");

    EXPECT_EQ(capitalizeFirstUtf8("привет"), "Привет");
    EXPECT_EQ(capitalizeFirstUtf8("тест"), "Тест");
}

TEST(CapitalizeTest, AlreadyCapitalized) {
    // Проверка, если первая буква уже заглавная
    EXPECT_EQ(capitalizeFirstUtf8("Hello"), "Hello");
    EXPECT_EQ(capitalizeFirstUtf8("Привет"), "Привет");
}

TEST(CapitalizeTest, NonAlphaNumeric) {
    // Проверка с неалфавитными символами
    EXPECT_EQ(capitalizeFirstUtf8("123test"), "123test");
    EXPECT_EQ(capitalizeFirstUtf8("!test"), "!test");
}

// Главная функция для запуска всех тестов Google Test
int main(int argc, char **argv) {
    // Инициализация Google Test с аргументами командной строки
    ::testing::InitGoogleTest(&argc, argv);
    // Запуск всех зарегистрированных тестов
    return RUN_ALL_TESTS();
}
