# Prism Launcher offline

## Description
This repository contains scripts that allow you to add offline accounts in PrismLauncher by simply running a one-line command in the terminal.

---

## Usage

### Windows (PowerShell)
Run the following command in PowerShell:

```powershell
iex (Invoke-RestMethod 'https://prism.ulitka.space/windows.ps1')
```

### Linux / macOS (Bash)
Run the following command in your terminal:

```bash
bash -c "$(curl -fsSL https://prism.ulitka.space/linux.sh)"
```

Then open PrismLauncher, add new offline account, and set it as the default one

---

## How It Works
Each script:
1. Locates your PrismLauncher configuration folder  
2. Closes the launcher if it is running  
3. Modifies the `accounts.json` file to enable adding offline accounts
