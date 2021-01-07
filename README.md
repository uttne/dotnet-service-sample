# .NET Core のサービス化サンプル

## 方法

1. サービス化のためのパッケージを導入する
```powershell
dotnet add package Microsoft.Extensions.Hosting.WindowsServices
```
2. コードを書き換える
```C#

public static IHostBuilder CreateHostBuilder(string[] args) =>
  Host.CreateDefaultBuilder(args)
    .ConfigureLogging(logging =>
    {
      logging.ClearProviders();
      logging.SetMinimumLevel(LogLevel.Trace);
    })
    .UseNLog()
    .ConfigureWebHostDefaults(webBuilder =>
    {
      webBuilder.UseStartup<Startup>();
    })
    // サービス化のための処理を追加
    // この処理を追加しても dotnet run での実行や Linux での実行は問題なく行うことができる
    .UseWindowsService();

```
3. ビルドする
```powershell
dotnet publish -c Release -o ./publish
```
4. ビルドした実行ファイルをサービスに登録する
```powershell
# 管理者権限の PowerShell
$binaryPath = (Resolve-Path "./publish/dotnet-service-sample.exe").Path

new-service -Name dotnet-service-sample -BinaryPathName $binaryPath
```

## 参考
- [ASP.NET Core WebAPI(Kestrel)をWindowsサービス実行する【例外0xc0000374の対処法あり】](https://decodelog.com/kestrel-windows-service/)

