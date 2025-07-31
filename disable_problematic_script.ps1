# Disable problematic script that causes page reloads

Write-Host "🔧 Disabling problematic script..." -ForegroundColor Yellow

# Create backup of the problematic script
$scriptPath = "_next/static/chunks/4bd1b696-c15bdc9f9823f0f9.js"
$backupPath = "_next/static/chunks/4bd1b696-c15bdc9f9823f0f9.js.backup"

if (Test-Path $scriptPath) {
    # Create backup
    Copy-Item $scriptPath $backupPath
    Write-Host "✅ Created backup: $backupPath" -ForegroundColor Green
    
    # Replace with empty script
    "" | Out-File -FilePath $scriptPath -Encoding UTF8
    Write-Host "✅ Disabled problematic script" -ForegroundColor Green
} else {
    Write-Host "❌ Script not found: $scriptPath" -ForegroundColor Red
}

Write-Host "`n🎯 Next steps:" -ForegroundColor Cyan
Write-Host "1. Refresh your browser page" -ForegroundColor White
Write-Host "2. Check if the reloading stops" -ForegroundColor White
Write-Host "3. If it works, the script was causing the issue" -ForegroundColor White
Write-Host "4. If not, restore with: Copy-Item backup file to original" -ForegroundColor White 