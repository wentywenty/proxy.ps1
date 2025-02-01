#!/usr/bin/env zsh

# 设置颜色
autoload -U colors && colors

# 询问用户输入代理地址和端口
print -P "%F{cyan}Enter proxy host (default 127.0.0.1): %f"
read "PROXY_HOST?"
PROXY_HOST=${PROXY_HOST:-127.0.0.1}

print -P "%F{cyan}Enter proxy port (default 10809): %f"
read "PROXY_PORT?"
PROXY_PORT=${PROXY_PORT:-10809}

function set_git_proxy() {
    git config --global http.proxy "http://$PROXY_ADDR"
    git config --global https.proxy "http://$PROXY_ADDR"
    echo "Git proxy has been set to $PROXY_ADDR"
}

function remove_git_proxy() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "Git proxy has been removed"
}

function set_scoop_proxy() {
    scoop config proxy "$PROXY_ADDR"
    echo "Scoop proxy has been set to $PROXY_ADDR"
}

function remove_scoop_proxy() {
    scoop config rm proxy
    echo "Scoop proxy has been removed"
}

function set_env_proxy() {
    export http_proxy="http://$PROXY_ADDR"
    export https_proxy="http://$PROXY_ADDR"
    echo "Environment proxy has been set to $PROXY_ADDR"
}

function remove_env_proxy() {
    unset http_proxy
    unset https_proxy
    echo "Environment proxy has been removed"
}

function show_menu() {
    print -P "\n%F{cyan}=== Proxy Management Menu ===%f"
    echo "1. Set Git Proxy"
    echo "2. Remove Git Proxy"
    echo "3. Set Scoop Proxy"
    echo "4. Remove Scoop Proxy"
    echo "5. Set Environment Proxy"
    echo "6. Remove Environment Proxy"
    echo "7. Set All Proxies"
    echo "8. Remove All Proxies"
    echo "Q. Quit"
    print -P "%F{cyan}=========================%f"
}

function proxy_manager() {
    while true; do
        clear
        show_menu
        read "choice?Enter your choice: "
        
        case $choice in
            1) set_git_proxy ;;
            2) remove_git_proxy ;;
            3) set_scoop_proxy ;;
            4) remove_scoop_proxy ;;
            5) set_env_proxy ;;
            6) remove_env_proxy ;;
            7)
                set_git_proxy
                set_scoop_proxy
                set_env_proxy
                ;;
            8)
                remove_git_proxy
                remove_scoop_proxy
                remove_env_proxy
                ;;
            [Qq]) break ;;
            *) echo "Invalid choice. Please try again." ;;
        esac
        
        read "?Press [Enter] to continue..."
    done
}

# 启动代理管理器
proxy_manager