# 配置路径
$globalPackagesPath = "$env:USERPROFILE\.nuget\packages"
$projectAssetsFile = "obj\project.assets.json"
$outputDir = ".\ExtractedPackages"

# 创建输出目录
New-Item -Path $outputDir -ItemType Directory -Force | Out-Null

# 解析 project.assets.json
$assetsJson = Get-Content $projectAssetsFile | ConvertFrom-Json
$packages = $assetsJson.libraries.PSObject.Properties | Where-Object { $_.Value.type -eq "package" }

# 复制包
foreach ($pkg in $packages) {
    $pkgFullName = $pkg.Name
    $pkgParts = $pkgFullName.Split('/')
    $pkgName = $pkgParts[0].ToLower()
    $pkgVersion = $pkgParts[1]
    
    $sourcePath = Join-Path $globalPackagesPath "$pkgName\$pkgVersion"
    $destPath = Join-Path $outputDir "$pkgName\$pkgVersion"
    
    if (Test-Path $sourcePath) {
        Write-Host "Copying $pkgFullName ..."
        Copy-Item -Path $sourcePath -Destination $destPath -Recurse -Force
    } else {
        Write-Warning "Package not found: $pkgFullName"
    }
}

Write-Host "Extracted packages saved to: $outputDir"