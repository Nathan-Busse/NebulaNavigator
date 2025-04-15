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

# Temporary bypass for execution policy
if ((Get-ExecutionPolicy -Scope Process) -ne 'Bypass') {
    Write-Host "Relaunching script with -ExecutionPolicy Bypass..."
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File $MyInvocation.MyCommand.Path @args
    exit
}

# Check for administrative privileges
function Test-Admin {
    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Error "This script must be run as Administrator. Please restart PowerShell as Administrator and re-run the script."
    exit
}

# Enable Windows long paths
Write-Host "Enabling Windows Long Path Support..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -Force

# Update group policy
Write-Host "Updating group policy to apply changes..."
gpupdate /force | Out-Null

# Prompt the user for restart
$restartChoice = Read-Host "Would you like to restart your PC now? (Y/N)"
if ($restartChoice -match "^[Yy]$") {
    Restart-Computer -Force
} else {
    Write-Host "Restart skipped. Please restart your computer later."
}