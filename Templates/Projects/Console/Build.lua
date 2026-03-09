project "<ProjectName>"
    kind          "ConsoleApp" -- ConsoleApp WindowedApp SharedLib StaticLib
    language      "C++"
    cppdialect    "C++17"
    staticruntime "off"
    characterset  "Unicode"

    pchheader "Pch.hpp"
    pchsource "Source/Pch.cpp"

    targetdir  ("%{wks.location}/Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir     ("%{wks.location}/Binaries-Intermediates/" .. OutputDir .. "/%{prj.name}")

    vsprops
    {
        -- VcpkgTriplet = "x64-windows-static",
        -- VcpkgEnabled = "true",
        -- PublicIncludeDirectories = "Include",
    }

    nuget
    {
        -- "Microsoft.Windows.ImplementationLibrary:<verion here...>",
    }

    files
    {
        "Source/**.cpp", "Source/**.hpp",
    }

    includedirs
    {
        "Source",
    }

    links
    {
        "<TargetLibraryName>",
    }

    prebuildcommands
    {
    }

    postbuildcommands
    {
    }
