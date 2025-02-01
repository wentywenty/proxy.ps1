# proxy.ps1

快速代理管理工具,支持 Git、Scoop 和系统环境代理设置。

## ⚡ 快速开始

> 只需一行命令即可运行:

```powershell
irm https://proxyps1.short.gy/ | iex
```

## 详细使用方法

选择你喜欢的环境直接运行:

### PowerShell
```powershell
irm https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.ps1 | iex
```

```
irm https://raw.gitmirror.com/wentywenty/proxy.ps1/main/proxy.ps1 | iex
```

```
irm https://proxyps1.short.gy/ | iex
```

### Bash/Zsh
```bash
curl -sSL https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.sh | bash
# 或
curl -sSL https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.zsh | zsh
```

### CMD
```cmd
curl -sSL https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.bat -o proxy.bat && proxy.bat
```

### Fish
```fish
curl -sSL https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.fish | fish
```

## 功能

- 一键设置/删除所有代理
- 分别管理 Git/Scoop/系统环境代理
- 默认代理配置: 127.0.0.1:10809

## 注意

首次使用建议查看脚本内容以确保安全。可以先下载到本地:
```bash
curl -O https://raw.githubusercontent.com/wentywenty/proxy.ps1/main/proxy.ps1
```