# Final replacement of all remaining link tags

$htmlFiles = Get-ChildItem -Path "." -Include "*.html", "*.htm" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace any remaining link tags with just the img
    $content = $content -replace '<a href="index-1\.htm\?skipIntro=true">[^<]*<img[^>]*></a>', '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    # Also replace any empty link tags
    $content = $content -replace '<a href="index-1\.htm\?skipIntro=true">[^<]*</a>', '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Final replacement in $($file.Name)"
}

Write-Host "All files processed!" 