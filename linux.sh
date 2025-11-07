#!/bin/bash

OS=$(uname -s)

NORMAL_PATH="$HOME/.local/share/PrismLauncher"
FLATPAK_PATH="$HOME/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher"
MACOS_PATH="$HOME/Library/Application Support/PrismLauncher"

set_language() {
    if [[ "$LANG" == *"ru_RU"* ]]; then
        prismlauncher_running="PrismLauncher запущен! Закрытие..."
        configuration_directory_detected="Конфигурация PrismLauncher обнаружена по пути:"
        detected_system="Обнаруженная система:"
        config_directory_failed="Не удалось автоматически обнаружить директорию с конфигурацией PrismLauncher!"
        specify_path="Укажите путь к директории, где находится prismlauncher.cfg: "
        unknown_os="Неизвестная ОС!"
        try_to_specify_path="Попробуйте указать путь к директории, где находится prismlauncher.cfg: "
        modifying_accounts="Изменение файла accounts.json..."
        success="\e[32mУспешно! Теперь вы можете добавить свой оффлайн аккаунт в Prism Launcher\e[0m"
        no_success="\e[31mВо время исполнения скрипта произошли ошибки.\e[0m"
        path_not_found="Путь не найден!"
    else
        prismlauncher_running="PrismLauncher running! Closing..."
        configuration_directory_detected="Detected PrismLauncher configuration in: "
        detected_system="Detected system:"
        config_directory_failed="Failed to automatically detect PrismLauncher configuration directory!"
        specify_path="Specify path to the directory where prismlauncher.cfg is located:"
        unknown_os="Unknown OS!"
        try_to_specify_path="Try to specify the directory where prismlauncher.cfg is located: "
        modifying_accounts="Modifying accounts.json file..."
        success="\e[32mSuccess! You can now add your offline account in Prism Launcher.\e[0m"
        no_success="\e[31mErrors occurred during the execution of the script.\e[0m"
        path_not_found="Path not found!"
    fi
}

close_launcher() {
    pids=$(pgrep prismlauncher)
    if [ -n "$pids" ]; then
        echo "$prismlauncher_running"
        kill -15 $pids
    fi
}

found_launcher_path() {
    if [ "$OS" = "Linux" ]; then
        echo "$detected_system Linux"

        if [ -d "$NORMAL_PATH" ]; then
            LAUNCHER_PATH="$NORMAL_PATH"
            echo "$configuration_directory_detected $LAUNCHER_PATH"
        elif [ -d "$FLATPAK_PATH" ]; then
            LAUNCHER_PATH="$FLATPAK_PATH"
            echo "$configuration_directory_detected $LAUNCHER_PATH"
        else
            echo "$config_directory_failed"
            read -p "$specify_path" LAUNCHER_PATH
            if [ ! -d "$LAUNCHER_PATH" ]; then
                echo "$path_not_found"
                exit 1
            fi
        fi

    elif [ "$OS" = "Darwin" ]; then
        echo "$detected_system macOS"

        if [ -d "$MACOS_PATH" ]; then
            LAUNCHER_PATH="$MACOS_PATH"
            echo "$configuration_directory_detected $LAUNCHER_PATH"
        else
            echo "$config_directory_failed"
            read -p "$specify_path" LAUNCHER_PATH
            if [ ! -d "$LAUNCHER_PATH" ]; then
                echo "$path_not_found"
                exit 1
            fi
        fi

    else
        echo "$unknown_os $OS"
        read -p "$try_to_specify_path" LAUNCHER_PATH
        if [ ! -d "$LAUNCHER_PATH" ]; then
            echo "$path_not_found"
            exit 1
        fi
    fi
}

modify_accounts_json() {
    echo "$modifying_accounts"
    echo '{"accounts": [{"entitlement": {"canPlayMinecraft": true,"ownsMinecraft": true},"type": "MSA"}],"formatVersion": 3}' > "$1/accounts.json"

    if [ $? -eq 0 ]; then
        echo -e "$success"
    else
        echo -e "$no_success"
    fi
}

set_language
close_launcher
found_launcher_path
modify_accounts_json "$LAUNCHER_PATH"
