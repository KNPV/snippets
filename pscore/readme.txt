いろいろと似たものがある

PowerShell Core
2018/09/20 - 米Microsoftは9月13日（現地時間）、スクリプティング環境「PowerShell」の最新版「PowerShell Core 6.1」を一般公開した。
コマンドレット　古いモジュール？


PowerShell Az module
これが最先端？
https://qiita.com/yoshiwatanabe/items/2dcaf031704f27e4e2f3


Azure Cloud Shell（Pythonベース）
https://shell.azure.com/
Azコマンド


WindowsのコマンドプロンプトでもSDKをインストールすればAzコマンドが使える



PSCoreから呼べるモジュールの作り方
[PowerShell]
https://tech.guitarrapc.com/entry/2013/12/03/014013
[PowerShell Core]
https://github.com/PowerShell/PowerShell/blob/master/docs/cmdlet-example/visual-studio-simple-example.md

* .Net coreのバージョンをあげたり、System.Management.Automationをインストールしたり


C#からコマンドレット実行
http://hensa40.cutegirl.jp/archives/2178

VS Codeを使うと良い

Azureへのコマンドレットのデプロイ
Automationサービスには、.NetCoreではなくて.NetFrameworkだと成功した

.NetCore版のコマンドレットは、csprojに
    <PackageReference Include="Newtonsoft.Json" Version="11.0.2" />
    <PackageReference Include="System.Management.Automation" Version="6.1.0" />
を追加するとビルド、PowerShell Coreからの読み込みと実行に成功した Install-Module

Azure環境で、.NetCoreのコマンドレットがまだうまくいかない
Azure環境にパッケージをインストールする方法がわからない　Install-Moduleとか

動いてないけど、
    # パッケージプロバイダにNugetを追加
    Install-PackageProvider -Name Nuget

    # Nugetからパッケージ名を検索して、インストール実行
    Find-Package -Name DocumentFormat.OpenXml -Source https://www.nuget.org/api/v2 -RequiredVersion 2.5.0 | Install-Package
    Find-Package -Name ClosedXML -Source https://www.nuget.org/api/v2 -RequiredVersion 0.76.0 | Install-Package

    # パッケージのインストール確認
    Get-Package -ProviderName Nuget
みたいな感じらしい
