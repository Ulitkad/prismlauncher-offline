$CONSOLE_ENCODING=[Console]::OutputEncoding
$NORMAL_PATH="$env:APPDATA\PrismLauncher"

function set_language {
    if ([System.Globalization.CultureInfo]::CurrentCulture.TwoLetterISOLanguageName -eq "ru") {
        $global:prismlauncher_running="PrismLauncher запущен! Закрытие.."
        $global:configuration_directory_detected="Конфигурация PrismLauncher обнаружена по пути: "
        $global:detected_system="Обнаруженная система:"
        $global:config_directory_failed="Не удалось автоматически обнаружить директорию с конфигурацией PrismLauncher!"
        $global:specify_path="Укажите путь к директории, где находиться prismlauncher.cfg: "
        $global:unknown_os="Неизвестная ОС!"
        $global:try_to_specify_path="Попробуйте указать путь к директории, где находится prismlauncher.cfg: "
        $global:modifying_accounts="Изменение файла accounts.json.."
        $global:success="Успешно! Теперь вы можете добавить свой оффлайн аккаунт в Prism Launcher"
        $global:no_success="Во время исполнения скрипта произошли ошибки."
        $global:path_not_found="Путь не найден!"
    } else {
        $global:prismlauncher_running="PrismLauncher running! Closing.."
        $global:configuration_directory_detected="Detected PrismLauncher configuration in: "
        $global:detected_system="Detected system:"
        $global:config_directory_failed="Failed to automatically detect PrismLauncher configuration directory!"
        $global:specify_path="Specify path to the directory, where prismlauncher.cfg is located: "
        $global:unknown_os="Unknown OS!"
        $global:try_to_specify_path="Try to specify path to the directory, where prismlauncher.cfg is located: "
        $global:modifying_accounts="Modifying accounts.json file.."
        $global:success="Success! You can now add your offline account in Prism Launcher."
        $global:no_success="Errors occurred during the execution of the script."
        $global:path_not_found="Path not found!"
    }

}

function write_localized([string]$text) {
    param (
        [string]$Text,
        [Parameter(ValueFromRemainingArguments=$true)]
        $WriteHostArgs
    )

    $CONSOLE_ENCODING = [Console]::OutputEncoding
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
    $converted = $CONSOLE_ENCODING.GetString($bytes)

    Write-Host $converted @WriteHostArgs
}

function close_launcher {
    if (Get-Process -Name "prismlauncher" -ErrorAction SilentlyContinue) {
        write_localized $prismlauncher_running
        Stop-Process -Name "prismlauncher"
    }
}

function found_launcher_path {
    if (Test-Path $NORMAL_PATH) {
        $LAUNCHER_PATH = $NORMAL_PATH
        write_localized "$configuration_directory_detected $LAUNCHER_PATH"
    } else {
        write_localized $config_directory_failed
        $LAUNCHER_PATH = Read-Host $specify_path
        $LAUNCHER_PATH = $LAUNCHER_PATH.Trim()

        if (-not (Test-Path $LAUNCHER_PATH)) {
            write_localized $path_not_found -ForegroundColor Red
            exit
        }
    }

    return $LAUNCHER_PATH
}



function modify_accounts_json {
    param ([string]$x)

    if (-not $x) {
        exit
    }

    $x = $x.Trim()

    if (-not (Test-Path $x)) {
        write_localized $path_not_found -ForegroundColor Red
        exit
    }

    write_localized $modifying_accounts

    $accountsPath = Join-Path -Path $x -ChildPath "accounts.json"

    '{"accounts": [{"entitlement": {"canPlayMinecraft": true, "ownsMinecraft": true}, "type": "MSA"}], "formatVersion": 3}' |
        Out-File -FilePath $accountsPath -Encoding utf8 -Force

    if ($?) {
        write_localized $success -ForegroundColor Green
    } else {
        write_localized $no_success -ForegroundColor Red
    }
}



set_language
close_launcher
$LAUNCHER_PATH = found_launcher_path
modify_accounts_json $LAUNCHER_PATH
