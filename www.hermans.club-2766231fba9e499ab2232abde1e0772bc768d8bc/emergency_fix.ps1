# Emergency fix to stop page auto-refresh
Write-Host "Emergency fix: Stopping page auto-refresh..." -ForegroundColor Red

$inputFile = "collection.html"
$outputFile = "collection_emergency_fixed.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "EMERGENCY: Removing all auto-refresh mechanisms..."

# Remove ALL meta refresh tags
$content = $content -replace '<meta[^>]*http-equiv=["'']refresh["''][^>]*>', ''

# Remove JavaScript that might cause refresh
$content = $content -replace '<script[^>]*>.*?location\.reload.*?</script>', ''
$content = $content -replace '<script[^>]*>.*?window\.location.*?</script>', ''

# Remove setInterval and setTimeout that might cause refresh
$content = $content -replace '<script[^>]*>.*?setInterval.*?</script>', ''
$content = $content -replace '<script[^>]*>.*?setTimeout.*?</script>', ''

# Remove problematic external scripts
$content = $content -replace '<script[^>]*src="[^"]*matrica[^"]*"[^>]*></script>', ''
$content = $content -replace '<script[^>]*src="[^"]*walletconnect[^"]*"[^>]*></script>', ''

# Fix srcset errors that might cause issues
$content = $content -replace 'srcset="[^"]*?384w\?url=[^"]*?"', ''

Write-Host "Writing emergency fixed file..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "EMERGENCY FIX COMPLETE!" -ForegroundColor Green
Write-Host "File saved as: collection_emergency_fixed.html" -ForegroundColor Green
Write-Host "This should stop the auto-refresh immediately!" -ForegroundColor Green 