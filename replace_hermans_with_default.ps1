# Replace HERMANS logo with default.png

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace HERMANS logo SVG with default.png
    $content = $content -replace '<img src="images/svgs/hermans-logo.svg"[^>]*>', '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    # Also replace any remaining SVG logos with default.png
    $content = $content -replace '<svg[^>]*viewbox="0 0 1554 227"[^>]*>.*?</svg>', '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced HERMANS logo with default.png in $($file.Name)"
}

Write-Host "All files processed!" 