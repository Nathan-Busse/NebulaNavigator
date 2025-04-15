# |------------------------------------------DO NOT IGNORE---------------------------------------------------|
# |  It is recommended to run this script in a PowerShell session with administrative privileges.            |
# |----------------------------------------------------------------------------------------------------------|

# This script enables Windows Long Path Support by:
# - Automatically bypassing execution policy if required.
# - Modifying the registry to enable long paths.
# - Updating the group policy to ensure the changes are applied.
# - Prompting the user to restart for changes to take effect.

# ---------------------------------------------------BEGIN---------------------------------------------------------

# Auto-relaunch with the Bypass execution policy if not already running with it.
if ((Get-ExecutionPolicy -Scope Process) -ne 'Bypass') {
    Write-Host "Relaunching script with -ExecutionPolicy Bypass..."
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File $MyInvocation.MyCommand.Path @args
    exit
}

# Check for administrative privileges.
function Test-Admin {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Error "This script must be run with administrative privileges. Restart PowerShell as Administrator."
    exit
}

# Enable Windows Long Path Support by modifying the registry.
Write-Host "Enabling Windows Long Path Support in the registry..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -Force
Write-Host "Long Path Support enabled in the registry successfully." -ForegroundColor Green

# Update group policy to apply the changes.
Write-Host "Updating group policy..."
gpupdate /force | Out-Null
Write-Host "Group policy updated successfully." -ForegroundColor Green

# Prompt the user to restart the computer for changes to take effect.
$restartChoice = Read-Host "Would you like to restart your PC now? (Y/N)"
if ($restartChoice -match "^[Yy]$") {
    Write-Host "Restarting the computer now..." -ForegroundColor Yellow
    Restart-Computer -Force
} else {
    Write-Host "Restart skipped. Remember to restart later to apply changes." -ForegroundColor Cyan
}

Write-Host "`nConfiguration complete. Long paths are now enabled!"
# --------------------------------------------------------END--------------------------------------------------------