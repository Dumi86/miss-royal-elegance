$files = @("index.html", "apply.html", "sponsors.html", "gallery.html")
foreach ($file in $files) {
    if (-not (Test-Path $file)) { continue }
    $content = [System.IO.File]::ReadAllText("$PWD\$file")
    
    # We find the Home link and append the About link immediately after it.
    # We have to account for the unique styling of the Home link depending on the page.
    $inactiveLinkClass = 'text-slate-600 font-medium hover:text-purple-900 transition-colors font-label uppercase tracking-widest text-xs'
    
    # What does the Home link look like in index.html (active)?
    $indexHome = '<a class="text-purple-900 font-bold border-b-2 border-yellow-600 pb-1 font-label uppercase tracking-widest text-xs" href="index.html">Home</a>'
    # What does it look like in other pages (inactive)?
    $otherHome = '<a class="text-slate-600 font-medium hover:text-purple-900 transition-colors font-label uppercase tracking-widest text-xs" href="index.html">Home</a>'
    
    $aboutLink = "`n<a class=`"$inactiveLinkClass`" href=`"about.html`">About</a>"
    
    if ($content -match "\>Home\</a\>") {
        if ($file -eq "index.html") {
            $content = $content.Replace($indexHome, $indexHome + $aboutLink)
        } else {
            $content = $content.Replace($otherHome, $otherHome + $aboutLink)
            # Just in case it's slightly different in gallery.html
            $galleryHome = '<a class="text-slate-600 font-medium hover:text-purple-900 transition-colors font-label uppercase tracking-widest text-xs" href="index.html">Home</a>'
        }
    }
    
    [System.IO.File]::WriteAllText("$PWD\$file", $content, [System.Text.Encoding]::UTF8)
    Write-Host "Injected About link into $file"
}
