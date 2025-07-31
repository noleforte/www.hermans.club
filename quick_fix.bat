@echo off
echo Quick fix: Replacing collection.html with emergency fixed version...
echo.

REM Backup original
copy "collection.html" "collection_backup_emergency.html" >nul

REM Replace with emergency fix
copy "collection_emergency_fixed.html" "collection.html" >nul

echo.
echo SUCCESS! Auto-refresh should be stopped now.
echo.
echo Open collection.html in your browser - it should NOT refresh anymore.
echo.
pause 