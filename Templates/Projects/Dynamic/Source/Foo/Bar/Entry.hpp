#pragma once

#include <string>

namespace Foo::Bar
{

    class Entry final
    {
    public:
        Entry();
        ~Entry();

        // copying and moving are denied by default.
        Entry(const Entry&) = delete;
        Entry& operator=(const Entry&) = delete;

        Entry(Entry&&) noexcept = default;
        Entry& operator=(Entry&&) noexcept = default;

        // member functions
        void DoSomething();

    private:
        // member variables
    };

} // namespace Foo::Bar
