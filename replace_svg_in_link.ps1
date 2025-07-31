# Replace link with SVG with simple img tag

$htmlFiles = Get-ChildItem -Path "." -Include "*.html", "*.htm" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the entire link with SVG with simple img tag
    $pattern = '<a href="index-1\.htm\?skipIntro=true"><svg[^>]*viewBox="0 0 1554 227"[^>]*>.*?</svg></a>'
    $replacement = '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    $content = $content -replace $pattern, $replacement
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced link with SVG in $($file.Name)"
}

Write-Host "All files processed!" 