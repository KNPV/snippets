# ここに置かれたモジュールが読み込まれる
# https://tech.guitarrapc.com/entry/2013/12/03/014013を参照
Write-Output $env:USERPROFILE\Documents\WindowsPowerShell\Modules

Import-Module hoge -PassThru

<#
現在の PowerShellプロセスで実行されている RunSpaceに読み込まれたモジュールを確認するには以下のようにします。
#>
Get-Module

<#
読み込まれたモジュールメンバーの確認
一度モジュールが読み込まれた後に、PowerShellコマンド全体から指定したモジュールメンバーのコマンドレットを取得することもできます。
#>
Get-Command -Module hoge

<#
複数行のコメントアウト
一度読み込んだモジュールをセッションから取り除くなら 以下のようにします。
#>
Remove-Module hoge

<#
もし同一RunSpaceでモジュールの再読み込みを行うには、-Forceスイッチを付けてImport-Moduleします。
#>
Import-Module hoge -Force

<#
Binary Moduleは、C# で PowerShell アセンブリ(.dll) 形式を生成し、PowerShellにモジュールとして読み込ませる方式を指します。
https://onedrive.live.com/view.aspx?resid=DC03E2A501A05D02!71393&cid=dc03e2a501a05d02&app=PowerPoint&authkey=!AL5dmdB3wVu_Mm0
#>
#新規プロジェクトで、C# > クラスライブラリを選択します。
#これでアセンブリ > フレームワークで System.Management.Automationを追加できます。
#usingに using System.Management.Automation; と using System.Management; を加えて、
#下のサンプルコードを書きます。hogehoge! と出力されるだけの意味のないものです。

<#
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Management;
using System.Management.Automation;

namespace PowerShellClass1
{
    [Cmdlet(VerbsCommon.Get, "string")]
    public class GetString : Cmdlet
    {
        protected override void EndProcessing()
        {
            WriteObject("hogehoge!");
        }
    }
}
#>

#ビルドします。
#PowerShell から dllをパス指定してImport-Module します。

Import-Module PowerShellClass1.dll

#実行してみると、記述通り hogehoge! と出力されます。
Get-string

<#
ここまで詳解したスクリプトモジュール(.psm1) やバイナリモジュール(.dll) ですが、モジュール読み込み時に 
マニフェスト(.psd1) を利用することで「モジュールバージョン」や「作者情報」、「出力する Cmdletや変数」などの
制御が可能です。
#>
#スクリプトモジュール(.psm1)やバイナリモジュール(.dll)では、Import-Module でモジュールを読み込んだ時に
#バージョンなどを指定することができず、またモジュール内部で仕込む場所もありません
#マニフェストモジュールは、 先述したスクリプトモジュールやバイナリモジュールを
#マニフェスト(.psd1)を用いてきめ細かく制御します。

#マニフェストの生成には、専用のCmdlet が用意されています。

New-ModuleManifest

<#
現在のPowerShell セッション内部/インメモリにモジュール生成する
PowerShellセッションが切れるとダイナミックモジュールも消えます。この恒久的ではなく
一時的なモジュールという性質が他と大きく異なる点です。
#>

<#
PowerShellスクリプト単独でモジュールを作る場合、モジュールのファンクションや動作をモジュールファイル(.psm1)で定め、
マニフェスト(.psd1)で公開する情報を制御するマニフェストモジュールが最も利用されることでしょう。

モジュールファイルで複数のファンクションを読み込ませるにあたり、どのように配置するべきかを考えるとおよそ2つあるかと思います。
1. モジュールファイル(.psm1)に直接書き込む
すべてのファンクションが一つのファイルに存在するのは、可読性を著しく下げます。 
特にGitHubのようなバージョン管理ツールと相性が悪く、一部の機能でもファイル全体の更新という結果になります。

2. スクリプトファイル(.ps1)分散/モジュールファイル(.psm1)にドットソース読込
変数の受け渡しや、インテリセンスが .psm1に直接すべて記述するのに比べると難があります。
#>




#ブラウザのタブが、指定したものだけタスクバーに表示されたらいいのに
