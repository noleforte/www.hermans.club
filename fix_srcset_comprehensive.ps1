# Comprehensive fix for all srcset parsing errors
# This script handles all the different patterns of malformed srcset attributes

$inputFile = "collection.html"
$outputFile = "collection_fixed_comprehensive.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!"
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "Fixing all srcset attributes comprehensively..."

# Pattern 1: Fix srcset attributes with 384w?url= patterns
$content = $content -replace 'srcset="([^"]*?384w\?url=[^"]*?)"', {
    param($match)
    $srcsetValue = $match.Groups[1].Value
    
    # Extract the base image path (before the query parameters)
    if ($srcsetValue -match '_next/[^?]+\.png') {
        $basePath = $matches[0]
        return "srcset=`"$basePath 384w`""
    }
    
    return $match.Value
}

# Pattern 2: Fix srcset attributes with multiple URLs and descriptors
$content = $content -replace 'srcset="([^"]*?384w[^"]*?384w[^"]*?)"', {
    param($match)
    $srcsetValue = $match.Groups[1].Value
    
    # Extract all image paths
    $imagePaths = @()
    if ($srcsetValue -match '_next/[^?]+\.png') {
        $imagePaths += $matches[0]
    }
    
    # If we found image paths, create a clean srcset
    if ($imagePaths.Count -gt 0) {
        $cleanSrcset = ($imagePaths | ForEach-Object { "$_ 384w" }) -join ', '
        return "srcset=`"$cleanSrcset`""
    }
    
    return $match.Value
}

# Pattern 3: Fix srcset attributes with any malformed descriptors
$content = $content -replace 'srcset="([^"]*?384w[^"]*?[^w][^"]*?)"', {
    param($match)
    $srcsetValue = $match.Groups[1].Value
    
    # Extract the base image path
    if ($srcsetValue -match '_next/[^?]+\.png') {
        $basePath = $matches[0]
        return "srcset=`"$basePath 384w`""
    }
    
    return $match.Value
}

# Pattern 4: Remove any srcset attributes that are completely malformed
$content = $content -replace 'srcset="[^"]*?384w[^"]*?[^w][^"]*?"', ''

# Pattern 5: Fix any remaining srcset with query parameters
$content = $content -replace 'srcset="([^"]*?\?[^"]*?)"', {
    param($match)
    $srcsetValue = $match.Groups[1].Value
    
    # Extract the base image path (before the query parameters)
    if ($srcsetValue -match '_next/[^?]+\.png') {
        $basePath = $matches[0]
        return "srcset=`"$basePath 384w`""
    }
    
    return $match.Value
}

Write-Host "Removing problematic React hydration code..."
$content = $content -replace 'data-reactroot="[^"]*"', ''
$content = $content -replace 'data-reactid="[^"]*"', ''

Write-Host "Fixing script loading issues..."
$content = $content -replace 'src="/_next/', 'src="./_next/'
$content = $content -replace 'src="//_next/', 'src="./_next/'

Write-Host "Removing auto-refresh meta tags..."
$content = $content -replace '<meta[^>]*http-equiv=["'']refresh["''][^>]*>', ''

Write-Host "Fixing Content Security Policy..."
$content = $content -replace 'http-equiv="Content-Security-Policy"[^>]*content="[^"]*frame-ancestors[^"]*"', ''

Write-Host "Fixing MIME type issues..."
$content = $content -replace '<script([^>]*?)>', '<script$1 type="text/javascript">'

Write-Host "Removing problematic external scripts..."
$content = $content -replace '<script[^>]*src="[^"]*matrica[^"]*"[^>]*></script>', '<!-- Removed problematic Matrica script -->'
$content = $content -replace '<script[^>]*src="[^"]*walletconnect[^"]*"[^>]*></script>', '<!-- Removed problematic WalletConnect script -->'

Write-Host "Fixing relative paths..."
$content = $content -replace 'href="/', 'href="./'
$content = $content -replace 'src="/', 'src="./'

Write-Host "Writing fixed content to $outputFile..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Creating a verification script..."
$verifyScript = @"
# Verification script to check for remaining srcset issues
import re

def check_srcset_issues(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Check for problematic patterns
    patterns = [
        r'srcset="[^"]*?384w\?url=',
        r'srcset="[^"]*?384w[^"]*?[^w][^"]*?"',
        r'srcset="[^"]*?\?[^"]*?"'
    ]
    
    issues_found = 0
    for pattern in patterns:
        matches = re.findall(pattern, content)
        if matches:
            print(f"Found {len(matches)} issues with pattern: {pattern}")
            issues_found += len(matches)
    
    if issues_found == 0:
        print("✅ No srcset parsing issues found!")
    else:
        print(f"⚠️  Found {issues_found} remaining issues")
    
    return issues_found == 0

if __name__ == "__main__":
    check_srcset_issues("collection_fixed_comprehensive.html")
"@

$verifyScript | Out-File -FilePath "verify_srcset.py" -Encoding UTF8

Write-Host "Done! The comprehensively fixed file has been saved as collection_fixed_comprehensive.html"
Write-Host "Additional files created:"
Write-Host "  - verify_srcset.py (verification script)"
Write-Host ""
Write-Host "To verify the fixes:"
Write-Host "1. Run: python verify_srcset.py"
Write-Host "2. Open collection_fixed_comprehensive.html in your browser"
Write-Host ""
Write-Host "This version should completely eliminate all srcset parsing errors." 