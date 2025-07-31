# Simple PowerShell script to replace HERMANS logo SVGs

# Get all HTML files
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    # Read the HTML file
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Simple pattern to find HERMANS logo
    $pattern = 'viewbox="0 0 1554 227"'
    
    if ($content -match $pattern) {
        # Replace the entire SVG with img tag
        $content = $content -replace '<svg[^>]*viewbox="0 0 1554 227"[^>]*>.*?</svg>', '<img src="images/svgs/hermans-logo.svg" alt="HERMANS" class="h-auto w-32 text-stone-800">'
        
        # Write back to file
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "  ✓ Replaced HERMANS logo in $($file.Name)" -ForegroundColor Green
    } else {
        Write-Host "  - No HERMANS logo found in $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host "All files processed!" -ForegroundColor Green 