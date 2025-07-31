# Comprehensive fix for collection.html issues
# This script addresses:
# 1. srcset parsing errors
# 2. React hydration errors
# 3. Server configuration issues
# 4. Resource loading problems

$inputFile = "collection.html"
$outputFile = "collection_fixed.html"

if (-not (Test-Path $inputFile)) {
    Write-Host "Error: $inputFile not found!"
    exit 1
}

Write-Host "Reading $inputFile..."
$content = Get-Content $inputFile -Raw -Encoding UTF8

Write-Host "Fixing srcset attributes..."
# Fix malformed srcset attributes that contain query parameters
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

Write-Host "Removing problematic React hydration code..."
# Remove or fix React hydration issues
$content = $content -replace 'data-reactroot="[^"]*"', ''
$content = $content -replace 'data-reactid="[^"]*"', ''

Write-Host "Fixing script loading issues..."
# Fix script src attributes that might be causing 404 errors
$content = $content -replace 'src="/_next/', 'src="./_next/'
$content = $content -replace 'src="//_next/', 'src="./_next/'

Write-Host "Removing auto-refresh meta tags..."
# Remove meta refresh tags that might cause continuous updates
$content = $content -replace '<meta[^>]*http-equiv=["'']refresh["''][^>]*>', ''

Write-Host "Fixing Content Security Policy..."
# Add proper CSP headers or remove problematic ones
$content = $content -replace 'http-equiv="Content-Security-Policy"[^>]*content="[^"]*frame-ancestors[^"]*"', ''

Write-Host "Fixing MIME type issues..."
# Ensure proper script type attributes
$content = $content -replace '<script([^>]*?)>', '<script$1 type="text/javascript">'

Write-Host "Removing problematic external scripts..."
# Remove or comment out problematic external scripts
$content = $content -replace '<script[^>]*src="[^"]*matrica[^"]*"[^>]*></script>', '<!-- Removed problematic Matrica script -->'
$content = $content -replace '<script[^>]*src="[^"]*walletconnect[^"]*"[^>]*></script>', '<!-- Removed problematic WalletConnect script -->'

Write-Host "Fixing relative paths..."
# Fix any remaining absolute paths to be relative
$content = $content -replace 'href="/', 'href="./'
$content = $content -replace 'src="/', 'src="./'

Write-Host "Writing fixed content to $outputFile..."
$content | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "Creating a simple server configuration file..."
# Create a simple .htaccess file for Apache or web.config for IIS
$htaccessContent = @"
# Fix MIME types for JavaScript files
AddType application/javascript .js
AddType text/css .css

# Enable CORS for local development
Header always set Access-Control-Allow-Origin "*"
Header always set Access-Control-Allow-Methods "GET, POST, OPTIONS"
Header always set Access-Control-Allow-Headers "Content-Type"

# Fix 405 Method Not Allowed
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteCond %{REQUEST_METHOD} !^(GET|POST|HEAD)$
    RewriteRule .* - [F]
</IfModule>
"@

$htaccessContent | Out-File -FilePath ".htaccess" -Encoding UTF8

Write-Host "Creating a simple web server script..."
$serverScript = @"
# Simple Python HTTP server for testing
import http.server
import socketserver
import os

PORT = 8000

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()
    
    def guess_type(self, path):
        if path.endswith('.js'):
            return 'application/javascript'
        return super().guess_type(path)

with socketserver.TCPServer(("", PORT), CustomHTTPRequestHandler) as httpd:
    print(f"Serving at http://localhost:{PORT}")
    print("Press Ctrl+C to stop")
    httpd.serve_forever()
"@

$serverScript | Out-File -FilePath "simple_server.py" -Encoding UTF8

Write-Host "Done! The fixed file has been saved as collection_fixed.html"
Write-Host "Additional files created:"
Write-Host "  - .htaccess (for Apache server configuration)"
Write-Host "  - simple_server.py (Python HTTP server for testing)"
Write-Host ""
Write-Host "To test the fixed version:"
Write-Host "1. Replace collection.html with collection_fixed.html"
Write-Host "2. Use a local server (not file:// protocol)"
Write-Host "3. Run: python simple_server.py"
Write-Host "4. Open http://localhost:8000/collection_fixed.html" 