# Prism Launcher offline

## Описание
Этот репозиторий содержит скрипты, которые позволяют добавлять автономные аккаунты в PrismLauncher, просто выполнив однострочную команду в терминале.

---

## Использование

### Windows (PowerShell)
1. Установите PrismLauncher [официального сайта](https://prismlauncher.org/download/).  
2. Выполните следующую команду в PowerShell:
```powershell
iex (Invoke-RestMethod 'https://prism.ulitka.space/windows.ps1')
```
3. Откройте PrismLauncher, добавьте новый автономный аккаунт и установите его как основной.

### Linux / macOS (Bash)
1. Установите PrismLauncher через: [оффициальный сайт](https://prismlauncher.org/download/) / [flathub](https://flathub.org/en/apps/org.prismlauncher.PrismLauncher) / пакетный менеджер.
2. Выполните следующую команду в терминале:
```bash
bash -c "$(curl -fsSL https://prism.ulitka.space/linux.sh)"
```
3. Откройте PrismLauncher, добавьте новый автономный аккаунт и установите его как основной.

---

## Как это работает
Каждый скрипт:
1. Определяет папку конфигурации PrismLauncher  
2. Закрывает лаунчер, если он запущен  
3. Изменяет файл `accounts.json`, чтобы можно было добавить автономный аккаунт.

---

## Credits
This script was inspired by [antunnitraj/Prism-Launcher-PolyMC-Offline-Bypass](https://github.com/antunnitraj/Prism-Launcher-PolyMC-Offline-Bypass),
