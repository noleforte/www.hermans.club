# Fix HERMANS logos

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    $pattern = 'viewbox="0 0 1554 227"'
    
    if ($content -match $pattern) {
        $content = $content -replace '<svg[^>]*viewbox="0 0 1554 227"[^>]*>.*?</svg>', '<img src="images/svgs/hermans-logo.svg" alt="HERMANS" class="h-auto w-32 text-stone-800">'
        
        $content | Out-File -FilePath $file.FullName -Encoding UTF8
        Write-Host "  Replaced HERMANS logo in $($file.Name)"
    } else {
        Write-Host "  No HERMANS logo found in $($file.Name)"
    }
}

Write-Host "All files processed!" 