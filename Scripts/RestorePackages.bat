@echo off
chcp 65001 > nul

:bootstrap
    setlocal

    :: 固定パスとファイル名
    set "SOLUTION=Workspace.sln"
    set "RESTORE_PATH=.\Packages"
    set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\msbuild.exe"
    set "ROOT=%~dp0\.."

    pushd "%ROOT%"
    call :main
    popd

    endlocal
    exit /b

:main
    call :check_environment || goto :end
    call :restore_packages
    goto :end

:check_environment
    if not exist "%SOLUTION%" (
        echo [ERROR] ソリューションファイルが見つかりません: %SOLUTION%
        exit /b 1
    )

    if not exist "%MSBUILD%" (
        echo [ERROR] MSBuild が見つかりません: %MSBUILD%
        exit /b 1
    )

    exit /b 0

:restore_packages
    echo [INFO] パッケージの復元を開始します...
    echo        ソリューション: %SOLUTION%
    echo        パス: %RESTORE_PATH%

    "%MSBUILD%" "%SOLUTION%" -t:restore -p:RestorePackagesConfig=true -p:RestorePackagesPath="%RESTORE_PATH%"
    exit /b

:end
    rem 終了処理（必要に応じて拡張可）
    exit /b
