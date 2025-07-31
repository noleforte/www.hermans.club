# Final comprehensive replacement of ALL hermans-logo.svg references

# Get ALL files (HTML, JS, etc.)
$allFiles = Get-ChildItem -Path "." -Include "*.html", "*.htm", "*.js" -Recurse

Write-Host "Found $($allFiles.Count) files to process..."

foreach ($file in $allFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace ALL variations of hermans-logo.svg
    $content = $content -replace 'images/svgs/hermans-logo\.svg', 'images/pngs/default.png'
    $content = $content -replace '/images/svgs/hermans-logo\.svg', '/images/pngs/default.png'
    $content = $content -replace 'images\\svgs\\hermans-logo\.svg', 'images/pngs/default.png'
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced hermans-logo.svg with default.png in $($file.Name)"
}

Write-Host "All files processed!" 