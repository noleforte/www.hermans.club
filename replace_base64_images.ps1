# Script to replace base64 encoded SVG images with file paths
Write-Host "Replacing base64 encoded SVG images with file paths..." -ForegroundColor Green

$inputFile = "collection.html"
$outputFile = "collection_no_base64.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "Replacing base64 encoded SVG images..."

# Replace the specific base64 SVG with the file path
$base64Pattern = 'data:image/svg\+xml;base64,PHN2ZyB2aWV3Qm94PScwIDAgMTAyNCAxMDI0JyBmaWxsPSdub25lJyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHN0eWxlPSdoZWlnaHQ6MjhweDt3aWR0aDoyOHB4Jz48cmVjdCB3aWR0aD0nMTAyNCcgaGVpZ2h0PScxMDI0JyBmaWxsPScjMDA1MkZGJyByeD0nMTAwJyByeT0nMTAwJz48L3JlY3Q+PHBhdGggZmlsbC1ydWxlPSdldmVub2RkJyBjbGlwLXJ1bGU9J2V2ZW5vZGQnIGQ9J00xNTIgNTEyQzE1MiA3MTAuODIzIDMxMy4xNzcgODcyIDUxMiA4NzJDNzEwLjgyMyA4NzIgODcyIDcxMC44MjMgODcyIDUxMkM4NzIgMzEzLjE3NyA3MTAuODIzIDE1MiA1MTIgMTUyQzMxMy4xNzcgMTUyIDE1MiAzMTMuMTc3IDE1MiA1MTJaTTQyMCAzOTZDNDA2Ljc0NSAzOTYgMzk2IDQwNi43NDUgMzk2IDQyMFY2MDRDMzk2IDYxNy4yNTUgNDA2Ljc0NSA2MjggNDIwIDYyOEg2MDRDNjE3LjI1NSA2MjggNjI4IDYxNy4yNTUgNjI4IDYwNFY0MjBDNjI4IDQwNi43NDUgNjE3LjI1NSAzOTYgNjA0IDM5Nkg0MjBaJyBmaWxsPSd3aGl0ZSc+PC9wYXRoPjwvc3ZnPg=='

$filePath = 'images/svgs/plus-icon.svg'

# Replace the base64 with the file path
$content = $content -replace $base64Pattern, $filePath

# Also replace any other base64 SVG patterns that might exist
$content = $content -replace 'data:image/svg\+xml;base64,[^"]*"', 'images/svgs/plus-icon.svg"'

Write-Host "Writing updated content..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "SUCCESS! Base64 images replaced with file paths." -ForegroundColor Green
Write-Host "File saved as: $outputFile" -ForegroundColor Green
Write-Host "The base64 SVG has been replaced with: $filePath" -ForegroundColor Green 