# 询问用户输入代理地址和端口
$proxyHost = Read-Host "Enter proxy host (default 127.0.0.1)"
if ([string]::IsNullOrEmpty($proxyHost)) {
    $proxyHost = "127.0.0.1"
}

$proxyPort = Read-Host "Enter proxy port (default 10809)"
if ([string]::IsNullOrEmpty($proxyPort)) {
    $proxyPort = "10809"
}

# 定义代理地址
$proxyAddress = "${proxyHost}:${proxyPort}"

Write-Host "Using proxy address: $proxyAddress" -ForegroundColor Green

function Set-GitProxy {
    git config --global http.proxy "http://$proxyAddress"
    git config --global https.proxy "http://$proxyAddress"
    Write-Host "Git proxy has been set to $proxyAddress"
}

function Remove-GitProxy {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    Write-Host "Git proxy has been removed"
}

function Set-ScoopProxy {
    scoop config proxy "$proxyAddress"
    Write-Host "Scoop proxy has been set to $proxyAddress"
}

function Remove-ScoopProxy {
    scoop config rm proxy
    Write-Host "Scoop proxy has been removed"
}

function Set-EnvironmentProxy {
    $env:http_proxy = "http://$proxyAddress"
    $env:https_proxy = "http://$proxyAddress"
    Write-Host "Environment proxy has been set to $proxyAddress"
}

function Remove-EnvironmentProxy {
    Remove-Item Env:http_proxy -ErrorAction SilentlyContinue
    Remove-Item Env:https_proxy -ErrorAction SilentlyContinue
    Write-Host "Environment proxy has been removed"
}

function Show-Menu {
    Write-Host "`n=== Proxy Management Menu ===" -ForegroundColor Cyan
    Write-Host "1. Set Git Proxy"
    Write-Host "2. Remove Git Proxy"
    Write-Host "3. Set Scoop Proxy"
    Write-Host "4. Remove Scoop Proxy"
    Write-Host "5. Set Environment Proxy"
    Write-Host "6. Remove Environment Proxy"
    Write-Host "7. Set All Proxies"
    Write-Host "8. Remove All Proxies"
    Write-Host "Q. Quit"
    Write-Host "=========================" -ForegroundColor Cyan
}

function Start-ProxyManager {
    do {
        Show-Menu
        $choice = Read-Host "`nEnter your choice"
        
        switch ($choice) {
            '1' { Set-GitProxy }
            '2' { Remove-GitProxy }
            '3' { Set-ScoopProxy }
            '4' { Remove-ScoopProxy }
            '5' { Set-EnvironmentProxy }
            '6' { Remove-EnvironmentProxy }
            '7' { 
                Set-GitProxy
                Set-ScoopProxy
                Set-EnvironmentProxy
            }
            '8' { 
                Remove-GitProxy
                Remove-ScoopProxy
                Remove-EnvironmentProxy
            }
            'Q' { return }
            'q' { return }
            default { Write-Host "Invalid choice. Please try again." -ForegroundColor Red }
        }
        
        Write-Host "`nPress any key to continue..."
        $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        Clear-Host
    } while ($true)
}

# 启动代理管理器
Start-ProxyManager