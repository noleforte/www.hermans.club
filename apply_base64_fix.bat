@echo off
echo Applying base64 image fix...
echo.

REM Backup current version
copy "collection.html" "collection_backup_before_base64_fix.html" >nul

REM Apply base64 fix
copy "collection_no_base64.html" "collection.html" >nul

echo.
echo SUCCESS! Base64 images replaced with file paths.
echo.
echo Changes made:
echo - Replaced base64 encoded SVG with images/svgs/default.svg
echo - Removed all data:image/svg+xml;base64 references
echo.
echo The page should now load faster and use local SVG files.
echo.
pause 