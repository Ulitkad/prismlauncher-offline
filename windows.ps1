$NORMAL_PATH="$env:APPDATA\PrismLauncher"

function set_language {
    if ([System.Globalization.CultureInfo]::CurrentCulture.TwoLetterISOLanguageName -eq "ru") {
        $prismlauncher_running="PrismLauncher запущен! Закрытие.."
        $configuration_directory_detected="Конфигурация PrismLauncher обнаружена по пути: "
        $detected_system="Обнаруженная система:"
        $config_directory_failed="Не удалось автоматически обнаружить директорию с конфигурацией PrismLauncher!"
        $specify_path="Укажите путь к диркетории, где находиться prismlauncher.cfg: "
        $unknown_os="Неизвестная ОС!"
        $try_to_specify_path="Попробуйте указать путь к директории, где находиться prismlauncher.cfg: "
        $modifing_accounts="Изменение файла accounts.json.."
        $success="Успешно! Теперь вы можете добавить свой оффлайн аккаунт в Prism Launcher"
        $no_success="Во время исполнения скрипта произошли ошибки."
        $path_not_found="Путь не найден!"
    } else {
        $prismlauncher_running="PrismLauncher running! Closing.."
        $configuration_directory_detected="Detected PrismLauncher configuration in: "
        $detected_system="Detected system:"
        $config_directory_failed="Failed to automacticly detect PrismLauncher configuration directory!"
        $specify_path="Specify path to the directory, where prismlauncher.cfg is located: "
        $unknown_os="Unknown OS!"
        $try_to_specify_path="Try to specify path to the directory, where prismlauncher.cfg is located: "
        $modifing_accounts="Modifing accounts.json file.."
        $success="Success! You can now add your offline account in Prism Launcher."
        $no_success="Errors occurred during the execution of the script."
        $path_not_found="Path not found!"
    }

}

function close_launcher {
    if (Get-Process -Name "prismlauncher" -ErrorAction SilentlyContinue) {
        Write-Output $prismlauncher_running
        Stop-Process -Name "prismlauncher"
    }
}

function found_launcher_path {
    if (Test-Path $NORMAL_PATH) {
        $LAUNCHER_PATH = $NORMAL_PATH
        Write-Output "$configuration_directory_detected $LAUNCHER_PATH"
    } else {
        Write-Output $config_directory_failed
        $LAUNCHER_PATH = Read-Host $specify_path
        $LAUNCHER_PATH = $LAUNCHER_PATH.Trim()

        if (-not (Test-Path $LAUNCHER_PATH)) {
            Write-Host $path_not_found -ForegroundColor Red
            exit
        }
    }

    return $LAUNCHER_PATH
}


function modify_accounts_json {
    param ($x)

    if (-not $x) {
        exit
    }

    $x = $x.Trim()

    if (-not (Test-Path $x)) {
        Write-Host $path_not_found -ForegroundColor Red
        exit
    }

    Write-Output $modifing_accounts

    '{"accounts": [{"entitlement": {"canPlayMinecraft": true, "ownsMinecraft": true}, "type": "MSA"}], "formatVersion": 3}' |
        Out-File -FilePath (Join-Path $x "accounts.json") -Encoding utf8 -Force

    if ($?) {
        Write-Host $success -ForegroundColor Green
    } else {
        Write-Host $no_success -ForegroundColor Red
    }
}


set_language
close_launcher
$LAUNCHER_PATH = found_launcher_path
modify_accounts_json $LAUNCHER_PATH
