$apiKey = "AQ.Ab8RN6L65Gw1Tc3v-Xq3fxsXuvW07uu302nckRtykViKttwUtA"
$projectId = "16328324704716522470"
$baseUrl = "https://stitch.googleapis.com/mcp"

$screens = @(
    @{ name="design_system"; id="asset-stub-assets-60d9cb8ea1c14bd3901d52d516c8afa9-1774199971450" },
    @{ name="entry_page";    id="0f1f2bd7be8245568542e1776b191d3e" },
    @{ name="sponsors";      id="bb2a5239011341888c847a47fc3e615a" },
    @{ name="website_plan";  id="f5e540c74d5d4d00b58ac1d2dc9a09d0" },
    @{ name="gallery";       id="fa8ac4aed03241c6bed0bd98f392ae49" },
    @{ name="home_screen";   id="ff018238bc2d4f36bd90949f5662c743" }
)

foreach ($screen in $screens) {
    $screenName = "projects/$projectId/screens/$($screen.id)"
    $body = '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_screen","arguments":{"name":"' + $screenName + '"}}}'
    $outFile = "screen_$($screen.name).json"
    Write-Host "Fetching: $($screen.name) ..."
    [System.IO.File]::WriteAllText("$PWD\body_tmp.json", $body, [System.Text.Encoding]::UTF8)
    curl.exe -s -X POST $baseUrl -H "Content-Type: application/json" -H "X-Goog-Api-Key: $apiKey" --data-binary "@body_tmp.json" -o $outFile
    $item = Get-Item $outFile -ErrorAction SilentlyContinue
    if ($item) {
        Write-Host "  Saved: $outFile ($([Math]::Round($item.Length / 1KB, 1)) KB)"
    } else {
        Write-Host "  Failed: $outFile"
    }
}
Write-Host "Done!"
