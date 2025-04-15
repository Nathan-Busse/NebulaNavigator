# |------------------------------------------DO NOT IGNORE---------------------------------------------------|
# |  Make sure that you are using POWERSHELL 7.0 or higher.                                                  |
# |  This script must run with Administrator privileges to execute properly.                                 |
# |  It will auto-relaunch as Administrator if needed, and set its working directory correctly.              |
# |----------------------------------------------------------------------------------------------------------|

# This script combines the tasks of Git setup and configuration with enabling Windows long path support:
# - Automatically restarting with Administrator privileges if required.
# - Automatically changing the working directory to the script's location.
# - Configuring Git to support long paths globally.
# - Automating Git commit and push operations.
# - Enabling Windows Long Path Support via registry and group policy.

# ---------------------------------------------------CHANGELOG------------------------------------------------------
# v1.0.0 - Initial combined script created for Git operations and long path configuration.
# v1.1.0 - Added automatic relaunch as Administrator using Start-Process with -Verb RunAs.
# v1.2.0 - Improved handling of working directories with $PSScriptRoot.
# v1.3.0 - Enhanced compatibility for running outside of VS Code.
# v1.4.0 - Added countdown timer before resuming for user clarity.
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
    } catch {
        Write-Error "Failed to relaunch as Administrator. Please manually run this script with Administrator privileges."
    }
}

# Step 1: Automatically change the working directory to the script's location (repo root assumed).
try {
    Set-Location -Path $PSScriptRoot
    Write-Host "Changed directory to the script's location: $PSScriptRoot"
} catch {
    Write-Error "Failed to change directory to the script's location. Check if the script path is accessible."
}

# Step 2: Configure Git's long path support globally.
try {
    Write-Host "Checking Git installation..."
    $gitCommand = Get-Command git -ErrorAction SilentlyContinue
    if (-not $gitCommand) {
        Write-Error "Git is not installed on this system. Please install Git and re-run this script."
    }

    Write-Host "Enabling Git's long path support globally..."
    git config --global core.longpaths true
    Write-Host "Git global long path support enabled successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to enable Git's long path support globally. Please ensure Git is installed."
}

# Step 3: Automate Git commit and push operations.
try {
    $commitMsg = Read-Host "Enter your commit message"
    if ([string]::IsNullOrWhiteSpace($commitMsg)) {
        Write-Error "Commit message cannot be empty. Exiting..."
    }

    Write-Host "Staging all changes..."
    git add .
    Write-Host "Committing changes..."
    git commit -m "$commitMsg"
    Write-Host "Pushing changes to the remote repository..."
    git push

    Write-Host "`nGit operations complete. Your changes are now live!" -ForegroundColor Green
} catch {
    Write-Error "Failed during Git commit/push operations. Please check your repository settings."
    
    Write-Host "`nResuming program in:" -ForegroundColor Yellow
    For ($i = 10; $i -ge 1; $i--) {
        Write-Host "$i seconds remaining..." -ForegroundColor Cyan
        Start-Sleep -Seconds 1
    }
    Write-Host "Program will now resume!" -ForegroundColor Green

    }

# Step 4: Enable Windows Long Path Support by modifying the registry.
try {
    Write-Host "Enabling Windows Long Path Support in the registry..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name LongPathsEnabled -Value 1 -Force
    Write-Host "Long Path Support enabled successfully in the registry." -ForegroundColor Green
} catch {
    Write-Error "Failed to modify the registry. Ensure you have administrative privileges."
    Start-Sleep -Seconds 10
}

# Step 5: Update group policy to apply the changes.
try {
    Write-Host "Updating group policy..."
    gpupdate /force | Out-Null
    Write-Host "Group policy updated successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to update group policy. Please ensure your system supports group policy updates."
    Start-Sleep -Seconds 10
}

# Program continues here (add any other subsequent logic or execution steps).
Write-Host "`nSetup process completed successfully. Ready for the next steps!" -ForegroundColor Green
# --------------------------------------------------------END--------------------------------------------------------