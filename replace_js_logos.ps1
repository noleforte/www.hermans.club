# Replace hermans-logo.svg references in JavaScript files

$jsFiles = Get-ChildItem -Path "_next" -Filter "*.js" -Recurse

Write-Host "Found $($jsFiles.Count) JavaScript files to process..."

foreach ($file in $jsFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace hermans-logo.svg with default.png
    $content = $content -replace '/images/svgs/hermans-logo\.svg', '/images/pngs/default.png'
    $content = $content -replace 'images/svgs/hermans-logo\.svg', 'images/pngs/default.png'
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced hermans-logo.svg with default.png in $($file.Name)"
}

Write-Host "All JavaScript files processed!" 