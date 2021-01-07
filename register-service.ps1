$binaryPath = (Resolve-Path "./publish/dotnet-service-sample.exe").Path

new-service -Name dotnet-service-sample -BinaryPathName $binaryPath
