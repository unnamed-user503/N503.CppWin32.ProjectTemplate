@echo off
chcp 65001 > nul

:bootstrap
    setlocal

    :: ヘルプ表示
    if /i "%~1"=="/h"  goto :usage
    if /i "%~1"=="--help" goto :usage

    :: デフォルトターゲット
    set "TARGET=%~1"
    if "%TARGET%"=="" (
        set "TARGET=vs2026"
    )

    set "ROOT=%~dp0\.."
    set "PREMAKE=%ROOT%\Vendor\Premake5\Bin\premake5.exe"
    set "BUILD_LUA=%ROOT%\Build.lua"

    pushd "%ROOT%"
    call :main
    popd

    endlocal
    exit /b

:main
    call :check_environment || goto :end
    call :run_premake
    goto :end

:check_environment
    if not exist "%PREMAKE%" (
        echo [ERROR] Premake5 が見つかりません: %PREMAKE%
        exit /b 1
    )

    if not exist "%BUILD_LUA%" (
        echo [ERROR] Build.lua が見つかりません: %BUILD_LUA%
        exit /b 1
    )

    exit /b 0

:run_premake
    echo [INFO] Premake5 を実行中... (%TARGET%)
    "%PREMAKE%" --file=Build.lua %TARGET%
    exit /b

:usage
    echo.
    echo [USAGE] Build.bat [Target]
    echo         Example: Build.bat vs2026
    echo.
    echo         # 省略時は vs2026 を使用します。
    echo.
    exit /b 0

:end
    rem 終了処理（必要に応じて拡張可）
    exit /b
