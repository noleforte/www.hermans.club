# Replace React SVG component with img tag

$jsFiles = Get-ChildItem -Path "_next" -Filter "*.js" -Recurse

Write-Host "Found $($jsFiles.Count) JavaScript files to process..."

foreach ($file in $jsFiles) {
    Write-Host "Processing: $($file.Name)"
    
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Replace the React SVG component with img tag
    $pattern = 'className:r\}=e;return\(0,s\.jsxs\)\("svg",\{viewBox:"0 0 1554 227",fill:"none",xmlns:"http://www\.w3\.org/2000/svg",className:r,children:\[.*?\]\}\)'
    $replacement = 'className:r}=e;return(0,s.jsx)("img",{src:"images/pngs/default.png",alt:"HERMANS",className:r})'
    
    $content = $content -replace $pattern, $replacement
    
    # Write back to file
    $content | Out-File -FilePath $file.FullName -Encoding UTF8
    Write-Host "  Replaced React SVG with img in $($file.Name)"
}

Write-Host "All JavaScript files processed!" 