# Aggressive fix to completely remove all problematic elements
Write-Host "AGGRESSIVE FIX: Removing ALL problematic elements..." -ForegroundColor Red

$inputFile = "collection.html"
$outputFile = "collection_aggressive_fixed.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "AGGRESSIVE: Removing ALL problematic scripts and elements..."

# Remove ALL external scripts that might cause issues
$content = $content -replace '<script[^>]*src="[^"]*"[^>]*></script>', '<!-- REMOVED EXTERNAL SCRIPT -->'

# Remove ALL inline scripts that might cause refresh or errors
$content = $content -replace '<script[^>]*>.*?</script>', '<!-- REMOVED INLINE SCRIPT -->'

# Remove ALL meta refresh tags
$content = $content -replace '<meta[^>]*http-equiv=["'']refresh["''][^>]*>', ''

# Remove ALL problematic React attributes
$content = $content -replace 'data-reactroot="[^"]*"', ''
$content = $content -replace 'data-reactid="[^"]*"', ''

# Remove ALL srcset attributes that are causing parsing errors
$content = $content -replace 'srcset="[^"]*"', ''

# Remove ALL iframe elements that might cause CSP issues
$content = $content -replace '<iframe[^>]*>.*?</iframe>', '<!-- REMOVED IFRAME -->'

# Remove ALL problematic external resources
$content = $content -replace 'href="[^"]*matrica[^"]*"', 'href="#"'
$content = $content -replace 'href="[^"]*walletconnect[^"]*"', 'href="#"'
$content = $content -replace 'src="[^"]*matrica[^"]*"', 'src="#"'
$content = $content -replace 'src="[^"]*walletconnect[^"]*"', 'src="#"'

# Remove ALL Content Security Policy headers
$content = $content -replace 'http-equiv="Content-Security-Policy"[^>]*content="[^"]*"', ''

# Fix ALL relative paths
$content = $content -replace 'href="/', 'href="./'
$content = $content -replace 'src="/', 'src="./'

# Remove ALL problematic JavaScript files
$content = $content -replace 'src="[^"]*1684-[^"]*"', 'src="#"'
$content = $content -replace 'src="[^"]*4bd1b696-[^"]*"', 'src="#"'
$content = $content -replace 'src="[^"]*4655-[^"]*"', 'src="#"'
$content = $content -replace 'src="[^"]*2397-[^"]*"', 'src="#"'

# Remove ALL webpack chunks that are causing 404 errors
$content = $content -replace 'src="[^"]*webpack-[^"]*"', 'src="#"'

Write-Host "Writing aggressively fixed content..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "AGGRESSIVE FIX COMPLETE!" -ForegroundColor Green
Write-Host "File saved as: collection_aggressive_fixed.html" -ForegroundColor Green
Write-Host "This should completely eliminate ALL JavaScript errors and refresh issues!" -ForegroundColor Green 