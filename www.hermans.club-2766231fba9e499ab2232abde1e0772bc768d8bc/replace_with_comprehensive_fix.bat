@echo off
echo Replacing collection.html with the comprehensive fix...
echo.

REM Check if the comprehensive fixed file exists
if not exist "collection_fixed_comprehensive.html" (
    echo ERROR: collection_fixed_comprehensive.html not found!
    echo Please run the comprehensive fix script first.
    pause
    exit /b 1
)

REM Create a backup of the original file
echo Creating backup of original collection.html...
copy "collection.html" "collection_backup_original.html" >nul
if %errorlevel% neq 0 (
    echo ERROR: Could not create backup of original file!
    pause
    exit /b 1
)

REM Replace the original with the comprehensive fixed version
echo Replacing collection.html with collection_fixed_comprehensive.html...
copy "collection_fixed_comprehensive.html" "collection.html" >nul
if %errorlevel% neq 0 (
    echo ERROR: Could not replace collection.html!
    echo Restoring backup...
    copy "collection_backup_original.html" "collection.html" >nul
    pause
    exit /b 1
)

echo.
echo SUCCESS! collection.html has been replaced with the comprehensive fix.
echo.
echo Files created:
echo   - collection_backup_original.html (backup of original)
echo   - collection.html (comprehensive fixed version)
echo   - verify_srcset.py (verification script)
echo.
echo This version should completely eliminate all srcset parsing errors.
echo.
echo To verify the fixes work:
echo 1. Open collection.html in your browser
echo 2. Check the browser console for any remaining errors
echo 3. If you have Python: python verify_srcset.py
echo.
pause 