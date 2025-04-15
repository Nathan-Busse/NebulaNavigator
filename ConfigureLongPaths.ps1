# |------------------------------------------DO NOT IGNORE---------------------------------------------------|
# |      It is recommended to run this script in a PowerShell session with administrative privileges.        |
# |----------------------------------------------------------------------------------------------------------|

# This script configures long paths in Windows 10 and later.
# It enables long paths in the registry and sets the group policy for long paths. 
# It also checks if the system is running Windows 10 or later before making changes.
# It requires administrative privileges to run. 
# The script will prompt the user for administrative privileges if not already running as an administrator.
# The script also includes error handling to catch any exceptions that may occur during execution.


# Once changes have been made, the script will prompt the user to restart the system for the changes to-
#   take effect this is achieved by using the Restart-Computer cmdlet.
#       --> If the user inputes yes, the script will restart the system, otherwise it will exit without restarting.
#       --> If the user inputes no, the script will exit without restarting.

#--------------------------------------------------BEGIN--------------------------------------------------------




























#--------------------------------------------------------END--------------------------------------------------------