# Prism Launcher offline

## Description
This repository contains scripts that allow you to add offline accounts in PrismLauncher by simply running a one-line command in the terminal.

---

## Usage

### Windows (PowerShell)
1. Install prismlauncher from [official site](https://prismlauncher.org/download/).
2. Run the following command in powershell:
```powershell
iex (Invoke-RestMethod 'https://prism.ulitka.space/windows.ps1')
```
3. Open PrismLauncher, add new offline account, and set it as the default one.

### Linux / macOS (Bash)
1. Install prismlauncher from [official site](https://prismlauncher.org/download/)/[flathub](https://flathub.org/en/apps/org.prismlauncher.PrismLauncher)/distro repositories.
2. Run the following command in your terminal:
```bash
bash -c "$(curl -fsSL https://prism.ulitka.space/linux.sh)"
```
3. Open PrismLauncher, add new offline account, and set it as the default one.

---

## How It Works
Each script:
1. Locates your PrismLauncher configuration folder  
2. Closes the launcher if it is running  
3. Modifies the `accounts.json` file to enable adding offline accounts

---

## Credits
This script was inspired by [antunnitraj/Prism-Launcher-PolyMC-Offline-Bypass](https://github.com/antunnitraj/Prism-Launcher-PolyMC-Offline-Bypass),
