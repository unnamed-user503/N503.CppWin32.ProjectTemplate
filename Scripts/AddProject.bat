@echo off
chcp 65001 > nul

:bootstrap
    setlocal

    :: ヘルプ表示
    if /i "%~1"=="/h"  goto :usage
    if /i "%~1"=="--help" goto :usage

    set "PROJECT_NAME=%~1"
    set "TEMPLATE_NAME=%~2"

    set "ROOT=%~dp0\.."
    set "TEMPLATE_PATH=%ROOT%\Templates\Projects\%TEMPLATE_NAME%"
    set "DEST_PATH=%ROOT%\Projects\%PROJECT_NAME%"

    pushd "%ROOT%"
    call :main
    popd

    endlocal
    exit /b

:main
    call :check_arguments || goto :usage
    call :create_project
    call :open_files
    goto :end

:check_arguments
    if "%PROJECT_NAME%"=="" (
        echo [ERROR] プロジェクト名が指定されていません。
        exit /b 1
    )

    if "%TEMPLATE_NAME%"=="" (
        echo [ERROR] テンプレート名が指定されていません。
        exit /b 1
    )

    if not exist "%TEMPLATE_PATH%" (
        echo [ERROR] テンプレートが見つかりません: %TEMPLATE_PATH%
        exit /b 1
    )

    exit /b 0

:create_project
    if exist "%DEST_PATH%" (
        echo [INFO] プロジェクト "%PROJECT_NAME%" は既に存在します。
    ) else (
        echo [INFO] テンプレート "%TEMPLATE_NAME%" から "%PROJECT_NAME%" を作成します...
        robocopy "%TEMPLATE_PATH%" "%DEST_PATH%" /E /DCOPY:DAT /XF .gitkeep /XD .git > nul
    )
    exit /b

:open_files
    if exist "%DEST_PATH%\Build.lua" (
        start /wait "" "%DEST_PATH%\Build.lua"
    )

    if exist "%ROOT%\Build.lua" (
        start /wait "" "%ROOT%\Build.lua"
    )
    exit /b

:usage
    echo.
    echo [USAGE] AddProject.bat ^<ProjectName^> { Console | Windowed | Static | Dynamic }
    echo         Example: AddProject.bat MyLibrary StaticLibrary
    echo.
    echo         # 利用可能なテンプレートは Templates\Projects\ 以下に配置されています。
    echo.
    exit /b 1

:end
    rem 終了処理（必要に応じて拡張可）
    exit /b
