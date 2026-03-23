$files = @("index.html", "apply.html", "sponsors.html", "gallery.html")
foreach ($file in $files) {
    if (-not (Test-Path $file)) { continue }
    $content = [System.IO.File]::ReadAllText("$PWD\$file")
    $content = $content -replace 'href="#">Home', 'href="index.html">Home'
    $content = $content -replace 'href="#">Gallery', 'href="gallery.html">Gallery'
    $content = $content -replace 'href="#">Apply', 'href="apply.html">Apply'
    $content = $content -replace 'href="#">Sponsors', 'href="sponsors.html">Sponsors'
    # Also fix Apply Now button
    $content = $content -replace 'href="#">Contestants', 'href="gallery.html">Contestants'
    [System.IO.File]::WriteAllText("$PWD\$file", $content, [System.Text.Encoding]::UTF8)
    Write-Host "Fixed: $file"
}
Write-Host "All nav links updated!"
