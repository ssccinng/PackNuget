# NuGet包提取工具

这个PowerShell脚本用于从本地NuGet缓存中提取项目依赖的所有NuGet包到指定目录。

## 功能说明

`pack_nuget.ps1` 脚本通过解析项目的 `project.assets.json` 文件来识别项目依赖的所有NuGet包，并从本地NuGet缓存中复制这些包到指定的输出目录。

## 脚本工作原理

1. 从项目的 `obj\project.assets.json` 文件中解析依赖的NuGet包信息
2. 从本地NuGet缓存（默认位于 `%USERPROFILE%\.nuget\packages`）中查找这些包
3. 将找到的包复制到指定的输出目录（默认为 `.\ExtractedPackages`）

## 使用方法

1. 将脚本放置在包含 `obj\project.assets.json` 文件的项目目录中
2. 打开PowerShell并导航到该目录
3. 执行脚本：

```powershell
.\pack_nuget.ps1
```

## 配置选项

脚本包含以下可配置参数（可在脚本头部修改）：

- `$globalPackagesPath`：本地NuGet缓存路径，默认为 `$env:USERPROFILE\.nuget\packages`
- `$projectAssetsFile`：项目资源文件路径，默认为 `obj\project.assets.json`
- `$outputDir`：输出目录路径，默认为 `.\ExtractedPackages`

## 输出结果

脚本执行后，将在输出目录中创建与NuGet包结构相同的文件夹结构，每个包都按照 `{包名}\{版本号}` 的方式组织。

## 注意事项

- 确保执行脚本前，已通过 `dotnet restore` 或 Visual Studio 还原了项目的NuGet包
- 如果某些包在本地缓存中不存在，脚本将显示警告信息
- 该脚本仅复制在 `project.assets.json` 中列出的包