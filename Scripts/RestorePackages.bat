@echo off
chcp 65001 > nul

:bootstrap
    setlocal

    :: 固定パスとファイル名
    set "SOLUTION=Workspace.slnx"
    set "RESTORE_PATH=.\Packages"
    :: set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2026\Community\MSBuild\Current\Bin\msbuild.exe"
    set "ROOT=%~dp0\.."

    :: vswhereを使って最新のMSBuildのパスを動的に取得
    set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
    
    for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
        set "MSBUILD=%%i"
    )

    :: パスが見つからなかった場合のバックアップ用エラー
    if not exist "%MSBUILD%" (
        echo [ERROR] MSBuild が見つかりませんでした。
        pause
        exit /b 1
    )

    if not exist "%SOLUTION%" (
        echo [ERROR] ソリューションファイルが見つかりません: %SOLUTION%
        exit /b 1
    )

    pushd "%ROOT%"
    call :main
    popd

    endlocal
    exit /b

:main
    echo [INFO] パッケージの復元を開始します...
    echo        ソリューション: %SOLUTION%
    echo        パス: %RESTORE_PATH%

    "%MSBUILD%" "%SOLUTION%" -t:restore -p:RestorePackagesConfig=true -p:RestorePackagesPath="%RESTORE_PATH%"
    exit /b

:end
    rem 終了処理（必要に応じて拡張可）
    exit /b
