// // #include <iostream>

// // int main()
// // {
// //     std::cout << "Hello World!" << std::endl;
// //     return 0;
// // }

// #include <drogon/drogon.h>
// #include <cctype>

// std::string capitalize(const std::string& input) {
//     if (input.empty()) return input;
//     std::string result = input;
//     result[0] = std::toupper(result[0]);
//     return result;
// }

// int main() {
//     drogon::app().registerHandler(
//         "/api/capitalize/{str}",
//         [](const drogon::HttpRequestPtr& req,
//            std::function<void(const drogon::HttpResponsePtr&)>&& callback,
//            std::string str) {
//             std::string capitalized = capitalize(str);
//             auto resp = drogon::HttpResponse::newHttpResponse();
//             resp->setContentTypeCode(drogon::CT_TEXT_PLAIN);
//             resp->setBody(capitalized);
//             callback(resp);
//         },
//         {drogon::Get});

//     drogon::app()
//         .addListener("0.0.0.0", 8080)
//         .run();
// }


#include <drogon/drogon.h>
#include <locale>
#include <codecvt>
#include <cwctype>

using namespace drogon;

// Функция для преобразования первой буквы UTF-8 строки в верхний регистр
std::string capitalizeFirstUtf8(const std::string &input) {
    if (input.empty()) return "";

    // Преобразуем из UTF-8 в wide string (UTF-32 на Linux)
    std::wstring_convert<std::codecvt_utf8<wchar_t>> conv;
    std::wstring wstr = conv.from_bytes(input);

    if (!wstr.empty()) {
        wstr[0] = std::towupper(wstr[0]);
    }

    // Преобразуем обратно в UTF-8
    return conv.to_bytes(wstr);
}

int main() {
    // Устанавливаем локаль для поддержки кириллицы
    std::setlocale(LC_ALL, "en_US.UTF-8");

    app().registerHandler("/api/capitalize/{string}",
        [](const HttpRequestPtr &req,
           std::function<void(const HttpResponsePtr &)> &&callback,
           std::string str) {
            std::string capitalized = capitalizeFirstUtf8(str);
            auto resp = HttpResponse::newHttpResponse();
            resp->setContentTypeCode(CT_TEXT_PLAIN);
            resp->setBody(capitalized);
            callback(resp);
        },
        {Get});

    app().addListener("0.0.0.0", 8080);
    app().run();
}
