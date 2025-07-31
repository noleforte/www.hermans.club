# Restore original scripts from backup

Write-Host "Restoring scripts from backup..."

# Read the backup file
$backupContent = Get-Content "collection_backup_before_aggressive.html" -Raw -Encoding UTF8

# Read the current file
$currentContent = Get-Content "collection.html" -Raw -Encoding UTF8

# Extract script sections from backup (lines 16-83 and around line 428)
$backupLines = $backupContent -split "`n"
$scriptSections = @()

# Get the script sections from backup
$inScriptSection = $false
$scriptSection = ""
for ($i = 0; $i -lt $backupLines.Count; $i++) {
    $line = $backupLines[$i]
    
    # Start of script section
    if ($line -match '<script' -and $line -notmatch '</script>') {
        $inScriptSection = $true
        $scriptSection = $line
    }
    # End of script section
    elseif ($line -match '</script>') {
        $scriptSection += "`n" + $line
        $scriptSections += $scriptSection
        $inScriptSection = $false
        $scriptSection = ""
    }
    # Inside script section
    elseif ($inScriptSection) {
        $scriptSection += "`n" + $line
    }
}

Write-Host "Found $($scriptSections.Count) script sections in backup"

# Replace REMOVED EXTERNAL SCRIPT comments with original scripts
$restoredContent = $currentContent

# Replace the first batch of removed scripts (around lines 16-32)
$firstScripts = $scriptSections[0..15] -join "`n"
$restoredContent = $restoredContent -replace '<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->', $firstScripts

# Replace the second batch (around line 82)
$secondScripts = $scriptSections[16..17] -join "`n"
$restoredContent = $restoredContent -replace '<!-- REMOVED EXTERNAL SCRIPT -->', $secondScripts

# Replace the third batch (around line 358)
$thirdScripts = $scriptSections[18] 
$restoredContent = $restoredContent -replace '<!-- REMOVED EXTERNAL SCRIPT -->', $thirdScripts

# Replace the fourth batch (around lines 420-422)
$fourthScripts = $scriptSections[19..21] -join "`n"
$restoredContent = $restoredContent -replace '<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->\s*<!-- REMOVED EXTERNAL SCRIPT -->', $fourthScripts

# Write the restored content
$restoredContent | Out-File -FilePath "collection.html" -Encoding UTF8

Write-Host "Scripts restored successfully!" 