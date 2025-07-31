@echo off
echo Applying HERMANS logo fix...

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "replace_hermans_logo.ps1"

REM Create backup of original file
if exist "collection.html" (
    copy "collection.html" "collection_backup_before_hermans_logo.html"
    echo Backup created: collection_backup_before_hermans_logo.html
)

REM Replace the original file with the fixed version
if exist "collection_no_hermans_logo.html" (
    copy "collection_no_hermans_logo.html" "collection.html"
    echo HERMANS logo replaced successfully!
    echo Original file backed up as: collection_backup_before_hermans_logo.html
) else (
    echo Error: Fixed file not found!
)

pause 