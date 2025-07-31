# Replace ALL remaining links with SVG

$htmlFiles = Get-ChildItem -Path "." -Include "*.html", "*.htm" -Recurse

Write-Host "Found $($htmlFiles.Count) HTML files to process..."

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Multiple patterns to catch different variations
    $patterns = @(
        # Pattern 1: Complete link with SVG
        '<a href="index-1\.htm\?skipIntro=true"><svg[^>]*viewBox="0 0 1554 227"[^>]*>.*?</svg></a>',
        
        # Pattern 2: Link with any SVG inside
        '<a href="index-1\.htm\?skipIntro=true"><svg[^>]*>.*?</svg></a>',
        
        # Pattern 3: Just the link tag (in case SVG was already replaced)
        '<a href="index-1\.htm\?skipIntro=true">[^<]*</a>'
    )
    
    $replacement = '<img src="images/pngs/default.png" alt="HERMANS" class="h-auto w-32 text-stone-800">'
    
    foreach ($pattern in $patterns) {
        $content = $content -replace $pattern, $replacement
    }
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced remaining links in $($file.Name)"
}

Write-Host "All files processed!" 