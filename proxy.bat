@echo off
REM filepath: /D:/github/proxy_changer/proxy.bat

set /p "PROXY_HOST=Enter proxy host (default 127.0.0.1): "
if "%PROXY_HOST%"=="" set PROXY_HOST=127.0.0.1

set /p "PROXY_PORT=Enter proxy port (default 10809): "
if "%PROXY_PORT%"=="" set PROXY_PORT=10809

REM 设置代理地址
set PROXY_ADDR=%PROXY_HOST%:%PROXY_PORT%

echo Using proxy address: %PROXY_ADDR%

:menu
cls
echo.
echo === Proxy Management Menu ===
echo 1. Set Git Proxy
echo 2. Remove Git Proxy
echo 3. Set Scoop Proxy
echo 4. Remove Scoop Proxy
echo 5. Set Environment Proxy
echo 6. Remove Environment Proxy
echo 7. Set All Proxies
echo 8. Remove All Proxies
echo Q. Quit
echo =========================
echo.

set /p choice="Enter your choice: "

if "%choice%"=="1" call :setGitProxy
if "%choice%"=="2" call :removeGitProxy
if "%choice%"=="3" call :setScoopProxy
if "%choice%"=="4" call :removeScoopProxy
if "%choice%"=="5" call :setEnvProxy
if "%choice%"=="6" call :removeEnvProxy
if "%choice%"=="7" call :setAllProxies
if "%choice%"=="8" call :removeAllProxies
if /i "%choice%"=="Q" exit /b

pause
goto menu

:setGitProxy
git config --global http.proxy http://%PROXY_ADDR%
git config --global https.proxy http://%PROXY_ADDR%
echo Git proxy has been set to %PROXY_ADDR%
exit /b

:removeGitProxy
git config --global --unset http.proxy
git config --global --unset https.proxy
echo Git proxy has been removed
exit /b

:setScoopProxy
scoop config proxy %PROXY_ADDR%
echo Scoop proxy has been set to %PROXY_ADDR%
exit /b

:removeScoopProxy
scoop config rm proxy
echo Scoop proxy has been removed
exit /b

:setEnvProxy
set http_proxy=http://%PROXY_ADDR%
set https_proxy=http://%PROXY_ADDR%
echo Environment proxy has been set to %PROXY_ADDR%
exit /b

:removeEnvProxy
set http_proxy=
set https_proxy=
echo Environment proxy has been removed
exit /b

:setAllProxies
call :setGitProxy
call :setScoopProxy
call :setEnvProxy
exit /b

:removeAllProxies
call :removeGitProxy
call :removeScoopProxy
call :removeEnvProxy
exit /b