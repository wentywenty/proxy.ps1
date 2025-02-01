# 设置默认代理地址
read -P "Enter proxy host (default 127.0.0.1): " PROXY_HOST
set -g PROXY_HOST (test -n "$PROXY_HOST" && echo "$PROXY_HOST" || echo "127.0.0.1")

read -P "Enter proxy port (default 10809): " PROXY_PORT
set -g PROXY_PORT (test -n "$PROXY_PORT" && echo "$PROXY_PORT" || echo "10809")

# 设置代理地址
set -g PROXY_ADDR "$PROXY_HOST:$PROXY_PORT"

set_color green
echo "Using proxy address: $PROXY_ADDR"
set_color normal

function set_git_proxy
    git config --global http.proxy "http://$PROXY_ADDR"
    git config --global https.proxy "http://$PROXY_ADDR"
    echo "Git proxy has been set to $PROXY_ADDR"
end

function remove_git_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "Git proxy has been removed"
end

function set_scoop_proxy
    scoop config proxy "$PROXY_ADDR"
    echo "Scoop proxy has been set to $PROXY_ADDR"
end

function remove_scoop_proxy
    scoop config rm proxy
    echo "Scoop proxy has been removed"
end

function set_env_proxy
    set -gx http_proxy "http://$PROXY_ADDR"
    set -gx https_proxy "http://$PROXY_ADDR"
    echo "Environment proxy has been set to $PROXY_ADDR"
end

function remove_env_proxy
    set -e http_proxy
    set -e https_proxy
    echo "Environment proxy has been removed"
end

function show_menu
    echo -e "\n=== Proxy Management Menu ==="
    echo "1. Set Git Proxy"
    echo "2. Remove Git Proxy"
    echo "3. Set Scoop Proxy"
    echo "4. Remove Scoop Proxy"
    echo "5. Set Environment Proxy"
    echo "6. Remove Environment Proxy"
    echo "7. Set All Proxies"
    echo "8. Remove All Proxies"
    echo "Q. Quit"
    echo "========================="
end

function proxy_manager
    set -g running true
    
    while test "$running" = true
        clear
        show_menu
        read -P "Enter your choice: " choice
        
        switch $choice
            case 1
                set_git_proxy
            case 2
                remove_git_proxy
            case 3
                set_scoop_proxy
            case 4
                remove_scoop_proxy
            case 5
                set_env_proxy
            case 6
                remove_env_proxy
            case 7
                set_git_proxy
                set_scoop_proxy
                set_env_proxy
            case 8
                remove_git_proxy
                remove_scoop_proxy
                remove_env_proxy
            case Q q
                set running false
                return
            case '*'
                echo "Invalid choice. Please try again."
        end
        
        read -P "Press [Enter] to continue..."
    end
end

# 启动代理管理器
echo "Using proxy address: $PROXY_ADDR"
proxy_manager