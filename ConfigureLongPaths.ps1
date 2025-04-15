# |------------------------------------------DO NOT IGNORE---------------------------------------------------|
# |      It is recommended to run this script in a PowerShell session with administrative privileges.        |
# |----------------------------------------------------------------------------------------------------------|

# This script configures long paths in Windows 10 and later.
# It enables long paths in the registry and sets the group policy for long paths. 
# It also checks if the system is running Windows 10 or later before making changes.
# It requires administrative privileges to run. 
# The script will prompt the user for administrative privileges if not already running as an administrator.
# The script also includes error handling to catch any exceptions that may occur during execution.
#
# Once changes have been made, the script will prompt the user to restart the system for the changes to
# take effect. This is achieved by using the Restart-Computer cmdlet.
#       --> If the user inputs yes, the script will restart the system.
#       --> If the user inputs no, the script will exit without restarting.
#

# If the current process execution policy is not Bypass, relaunch the script with the Bypass flag.
if ((Get-ExecutionPolicy -Scope Process) -ne 'Bypass') {
    Write-Host "Relaunching script with -ExecutionPolicy Bypass..."
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File $MyInvocation.MyCommand.Path @args
    exit
}

#--------------------------------------------------BEGIN--------------------------------------------------------
# This script configures long paths in Windows 10 and later.
# It enables long paths in the registry and applies group policy changes.
# It checks if the system is running Windows 10 or later before making changes.
# Administrative privileges are required, and the script will prompt accordingly.
#
# After making the necessary changes, the script will prompt the user to restart the system
# for the changes to take effect.
#   - If the user inputs "Y", the script will restart the system.
#   - If the user inputs "N", the script will exit without restarting.
#--------------------------------------------------BEGIN--------------------------------------------------------

# Function to check for administrative privileges.
function Test-Admin {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Error "This script must be run as Administrator. Please restart PowerShell as Administrator and re-run the script."
    exit
}

# Check if the OS is Windows 10 or later.
Write-Host "Checking Windows version..."
$osVersion = [System.Environment]::OSVersion.Version
if ($osVersion.Major -lt 10) {
    Write-Error "This script requires Windows 10 or later. Your current version is $($osVersion.ToString()). Exiting..."
    exit
}

# Enable long path support by modifying the registry.
Write-Host "Enabling Windows Long Path Support in the registry..."
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
try {
    Set-ItemProperty -Path $regPath -Name LongPathsEnabled -Value 1 -Force
    Write-Host "Long path support enabled successfully in the registry." -ForegroundColor Green
} catch {
    Write-Warning "Failed to enable long path support in the registry. Error details: $_"
}

# Update group policy to ensure that changes are applied.
Write-Host "Updating group policy to apply changes..."
try {
    gpupdate /force | Out-Null
    Write-Host "Group policy updated successfully." -ForegroundColor Green
} catch {
    Write-Warning "Failed to update group policy. Error details: $_"
}

Write-Host ""

# Prompt the user to restart the PC for the change to take effect.
$restartChoice = Read-Host "Would you like to restart your PC now? (Y/N)"
if ($restartChoice -match "^[Yy]$") {
    Write-Host "Restarting the PC now..." -ForegroundColor Yellow
    Restart-Computer -Force
} else {
    Write-Host "Restart skipped. Please restart your computer later to ensure all changes take effect." -ForegroundColor Cyan
}

#--------------------------------------------------------END--------------------------------------------------------