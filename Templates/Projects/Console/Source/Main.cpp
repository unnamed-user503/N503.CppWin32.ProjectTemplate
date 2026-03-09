#include "Pch.hpp"
#include <iostream>
#include <locale>

int main(int argc, wchar_t** argv)
{
    std::locale::global(std::locale(".UTF-8"));
    std::wcout.imbue(std::locale());
    std::wcout << L"こんにちは、世界！" << std::endl;
    return 0;
}
