#!/bin/bash

OS=$(uname -s)

NORMAL_PATH=$HOME/.local/share/PrismLauncher
FLATPAK_PATH=$HOME/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher
MACOS_PATH=$HOME/Library/Application\ Support/PrismLauncher

close_launcher() {
    pids=$(pgrep prismlauncher)

    if [ -n "$pids" ]; then
        echo "PrismLauncher running! Closing.."
        kill $pids
    fi
}

found_launcher_path() {
    if [ "$OS" = "Linux" ]; then
        echo "Detected system: Linux"

        if [ -e $NORMAL_PATH ]; then
            PATH=$NORMAL_PATH
            echo "Detected prismlauncher configuration in: $PATH"


        elif [ -e $FLATPAK_PATH ]; then
            PATH=$FLATPAK_PATH
            echo "Detected prismlauncher configuration in: $PATH"

        else
            echo "Failed to automacticly detect prismlauncher configuration directory!"
            read -p "Specify path to the directory, where prismlauncher.cfg is located: " PATH
        fi

    elif [ "$OS" = "Darwin" ]; then
        echo "Detected system: macOS"

        if [ -e $MACOS_PATH ]; then
            PATH=$MACOS_PATH
            echo "Detected prismlauncher configuration in: $PATH"

        else
            echo "Failed to automacticly detect prismlauncher configuration directory!"
            read -p "Specify path to the directory, where prismlauncher.cfg is located: " PATH
        fi

    else
        echo "Unknown OS! $OS"
        read -p "Try to specify path to the directory, where prismlauncher.cfg is located: " PATH
    fi
}

modify_accounts_json() {
    echo "Modifing accounts.json file.."
    echo '{"accounts": [{"entitlement": {"canPlayMinecraft": true,"ownsMinecraft": true},"type": "MSA"}],"formatVersion": 3}' > $1/accounts.json

    if [ $? -eq 0 ]; then
        echo -e "\e[32mSuccess! You can now add your offline account in PrismLauncher.\e[0m"
    else
        echo -e "\e[31mErrors occurred during the execution of the script!\e[0m"
    fi
}

close_launcher
found_launcher_path
modify_accounts_json $PATH



