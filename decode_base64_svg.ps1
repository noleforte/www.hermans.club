# Script to decode the base64 SVG
Write-Host "Decoding base64 SVG..." -ForegroundColor Green

$base64String = "PHN2ZyB2aWV3Qm94PScwIDAgMTAyNCAxMDI0JyBmaWxsPSdub25lJyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHN0eWxlPSdoZWlnaHQ6MjhweDt3aWR0aDoyOHB4Jz48cmVjdCB3aWR0aD0nMTAyNCcgaGVpZ2h0PScxMDI0JyBmaWxsPScjMDA1MkZGJyByeD0nMTAwJyByeT0nMTAwJz48L3JlY3Q+PHBhdGggZmlsbC1ydWxlPSdldmVub2RkJyBjbGlwLXJ1bGU9J2V2ZW5vZGQnIGQ9J00xNTIgNTEyQzE1MiA3MTAuODIzIDMxMy4xNzcgODcyIDUxMiA4NzJDNzEwLjgyMyA4NzIgODcyIDcxMC44MjMgODcyIDUxMkM4NzIgMzEzLjE3NyA3MTAuODIzIDE1MiA1MTIgMTUyQzMxMy4xNzcgMTUyIDE1MiAzMTMuMTc3IDE1MiA1MTJaTTQyMCAzOTZDNDA2Ljc0NSAzOTYgMzk2IDQwNi43NDUgMzk2IDQyMFY2MDRDMzk2IDYxNy4yNTUgNDA2Ljc0NSA2MjggNDIwIDYyOEg2MDRDNjE3LjI1NSA2MjggNjI4IDYxNy4yNTUgNjI4IDYwNFY0MjBDNjI4IDQwNi43NDUgNjE3LjI1NSAzOTYgNjA0IDM5Nkg0MjBaJyBmaWxsPSd3aGl0ZSc+PC9wYXRoPjwvc3ZnPg=="

try {
    $bytes = [System.Convert]::FromBase64String($base64String)
    $decodedString = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    Write-Host "Decoded SVG content:" -ForegroundColor Yellow
    Write-Host $decodedString -ForegroundColor Cyan
    
    # Save the decoded SVG to a file
    $decodedString | Out-File -FilePath "decoded_svg.svg" -Encoding UTF8
    Write-Host "Decoded SVG saved to: decoded_svg.svg" -ForegroundColor Green
    
} catch {
    Write-Host "Error decoding base64: $($_.Exception.Message)" -ForegroundColor Red
} 