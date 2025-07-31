@echo off
echo Replacing collection.html with the fixed version...
echo.

REM Check if the fixed file exists
if not exist "collection_fixed.html" (
    echo ERROR: collection_fixed.html not found!
    echo Please run the fix script first.
    pause
    exit /b 1
)

REM Create a backup of the original file
echo Creating backup of original collection.html...
copy "collection.html" "collection_backup.html" >nul
if %errorlevel% neq 0 (
    echo ERROR: Could not create backup of original file!
    pause
    exit /b 1
)

REM Replace the original with the fixed version
echo Replacing collection.html with collection_fixed.html...
copy "collection_fixed.html" "collection.html" >nul
if %errorlevel% neq 0 (
    echo ERROR: Could not replace collection.html!
    echo Restoring backup...
    copy "collection_backup.html" "collection.html" >nul
    pause
    exit /b 1
)

echo.
echo SUCCESS! collection.html has been replaced with the fixed version.
echo.
echo Files created:
echo   - collection_backup.html (backup of original)
echo   - collection.html (fixed version)
echo   - .htaccess (server configuration)
echo   - test_fixed.html (test page)
echo.
echo You can now open collection.html in your browser.
echo If you still have issues, try opening test_fixed.html first.
echo.
pause 