# プロジェクト開発ガイドライン

## 1. ディレクトリ構成

本プロジェクトは再利用性を重視し、以下のようなディレクトリ構成を採用します。

```plaintext
<ProjectRoot>/
│  .editorconfig
│  .gitattributes
│  .gitconfig
│  .gitignore
│  Build.lua
│  LICENSE.txt
│  README.md
│
├─Documents/       # 設計資料・仕様書など
├─Licenses/        # 外部ライブラリのライセンス
├─Projects/        # 実際のアプリケーション・ライブラリ
├─Resources/       # 共通リソース（画像・設定ファイルなど）
├─Scripts/         # ビルド・セットアップ用スクリプト
├─Templates/       # プロジェクトテンプレート群
│  └─Projects/
│     ├─/Console   # Console Application
│     ├─/Windowed  # Windowed Application
│     ├─/Static    # Static Library
│     └─/Dynamic   # Dynamic Library
└─Vendor/          # 外部ツール（例：Premake5）
```

## 2. ビルドシステム

### 使用ツール

- Premake5 を公式ビルド定義ツールとして採用します。

### ビルド手順（Windows）

```bat
Scripts\Build.bat  # Premake によるプロジェクト生成
```

- プロジェクトのビルド構成は `Debug`, `Release`, `Distribute` の3種類を標準とし、生成されるバイナリの出力先は `Binaries/<構成名>/<プロジェクト名>/` に統一しています。

- 将来ここに `MSBuild.exe` を実行するコードを記述して、Visual Studioを起動することなくビルドできたらなと考えています。

## 3. プロジェクトの追加

### 手順

1. 以下のスクリプトを実行します：

```bat
Scripts\AddProject.bat <ProjectName> <Console | Application | Static | Dynamic>
```

2. 指定されたテンプレート（`Templates/Projects/` 以下）から、対応する構成が `Projects/` 以下にコピーされます。

3. `<ProjectRoot>/Projects/Build.lua` が開くので、プロジェクト名やリンクするライブラリの名前を編集します。

4. `<ProjectRoot>/Build.lua` が開くので、エントリポイントとなるプロジェクトの名前を編集し、プロジェクトの `Build.lua` を Include するコードを記述します。

## 4. ソースコードの文字コードと改行コード

### 基本方針

- 本プロジェクトにおけるソースコードの文字コードは**UTF-8-BOM**とします。
- 改行コードは **CRLF**(Windows標準)を使用します。

### 自動制御と適用方法

- プロジェクトルートに配置された `.editorconfig` によって、**文字コードと改行コードは自動的に統一**されます。

## 5. 免責事項

本プロジェクトの内容を利用したことにより生じたいかなる損害についても、作成者および関係者は一切の責任を負いかねます。  
ご利用にあたっては、自己の責任においてご判断くださいますようお願いいたします。
