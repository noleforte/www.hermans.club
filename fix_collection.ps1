# PowerShell script to fix srcset parsing errors in collection.html

$inputFile = "collection.html"
$outputFile = "collection_fixed.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!"
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "Fixing srcset attributes..."

# Fix malformed srcset attributes that contain query parameters
# This regex matches srcset attributes with 384w?url= patterns and fixes them
$content = $content -replace 'srcset="([^"]*?384w\?url=[^"]*?)"', {
    param($match)
    $srcsetValue = $match.Groups[1].Value
    
    # Extract the base image path (before the query parameters)
    if ($srcsetValue -match '_next/[^?]+\.png') {
        $basePath = $matches[0]
        return "srcset=`"$basePath 384w`""
    }
    
    return $match.Value  # Return unchanged if we can't fix it
}

Write-Host "Removing auto-refresh meta tags..."
# Remove meta refresh tags that might cause continuous updates
$content = $content -replace '<meta[^>]*http-equiv=["'']refresh["''][^>]*>', ''

Write-Host "Writing fixed content to $outputFile..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Done! The fixed file has been saved as collection_fixed.html"
Write-Host "You can now replace the original file with the fixed version." 