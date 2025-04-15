# |------------------------------------------DO NOT IGNORE---------------------------------------------------|
# |  Make sure that you are using POWERSHELL 7.0 or higher.                                                  |
# |  This script must run with Administrator privileges to execute properly.                                 |
# |  It will auto-relaunch as Administrator if needed, and set its working directory correctly.              |
# |----------------------------------------------------------------------------------------------------------|

# This script enables Windows Long Path Support by:
# - Automatically restarting with Administrator privileges if required.
# - Automatically changing the working directory to the script's location.
# - Modifying the registry to enable long paths.
# - Updating group policy to apply the changes.
# - Prompting the user to restart for changes to take effect.

# ---------------------------------------------------CHANGELOG------------------------------------------------------
# v1.0.0 - Initial script created to modify the registry and enable long paths. Included group policy update.
# v1.1.0 - Added automatic relaunch as Administrator using Start-Process with -Verb RunAs.
# v1.2.0 - Improved handling of working directories with $PSScriptRoot.
# v1.3.0 - Enhanced compatibility for running outside of VS Code.
# ---------------------------------------------------BEGIN---------------------------------------------------------

# Step 0: Auto-relaunch with Administrator privileges if not already elevated.
function Test-Admin {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "Script is not running as Administrator. Relaunching as Administrator..."
    try {
        Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        Write-Host "Waiting 10 seconds before exiting to allow the relaunch process to start..." -ForegroundColor Yellow
        Start-Sleep -Seconds 10
        exit
    } catch {
        Write-Error "Failed to relaunch as Administrator. Please manually run this script with Administrator privileges."
        Start-Sleep -Seconds 10
        exit
    }
}

# Step 1: Automatically change the working directory to the script's location (repo root assumed).
try {
    Set-Location -Path $PSScriptRoot
    Write-Host "Changed directory to the script's location: $PSScriptRoot"
} catch {
    Write-Error "Failed to change directory to the script's location. Check if the script path is accessible."
    exit
}

# Step 2: Enable Windows Long Path Support by modifying the registry.
try {
    Write-Host "Enabling Windows Long Path Support in the registry..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -Force
    Write-Host "Long Path Support enabled successfully in the registry." -ForegroundColor Green
} catch {
    Write-Error "Failed to modify the registry. Ensure you have administrative privileges."
    exit
}

# Step 3: Update group policy to apply the changes.
try {
    Write-Host "Updating group policy..."
    gpupdate /force | Out-Null
    Write-Host "Group policy updated successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to update group policy. Please ensure your system supports group policy updates."
    exit
}

# Step 4: Prompt the user to restart the computer for changes to take effect.
$restartChoice = Read-Host "Would you like to restart your PC now? (Y/N)"
if ($restartChoice -match "^[Yy]$") {
    try {
        Write-Host "Restarting the computer now..." -ForegroundColor Yellow
        Restart-Computer -Force
    } catch {
        Write-Error "Failed to restart the computer. Please restart manually."
        exit
    }
} else {
    Write-Host "Restart skipped. Remember to restart later to apply changes." -ForegroundColor Cyan
}

Write-Host "`nConfiguration complete. Long paths are now enabled!"
# --------------------------------------------------------END--------------------------------------------------------