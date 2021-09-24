param ($i, $o, [switch] $keepgif = $false)
$i = "$i.gif"

$version = "0.1.0 (alpha)"
function Check-Command($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

Write-Output "The Stickerinator by Vukky Limited - version $version"
if (Check-Command -cmdname 'gifsicle') { } else {
    Write-Error 'Please make sure you have gifsicle in your PATH.'
    exit
}
if (Check-Command -cmdname 'ffmpeg') { } else {
    Write-Error 'Please make sure you have ffmpeg in your PATH.'
    exit
}

# hell begins here
Write-Output ''
$poop = $pwd.Path
$imagedata = [System.Drawing.Image]::FromFile("$poop\$i")
$currentwip = $o.gif # store the file name of the latest modified gif so we don't touch older ones

# resize the gif
if ($imagedata.width -gt 320) {
    Write-Output "Resizing $i to 320px"
    gifsicle $i --resize-width 320 -o stickerinatorresized$o.gif
    $currentwip = "stickerinatorresized$o.gif"
}

# cut the gif
$poopframe = 0
$poopduration = 0.00
# try to find the problematic frame for cutting
ForEach ($line in gifsicle --info .\$currentwip) {
    if($line -match '  \+ image #(?<frameid>.*) .*x.*') {
        $poopframe = $matches['frameid']
    }
    if($line -match '.* delay (?<delay>.*)') { $poopduration += $matches['delay'].Replace('s', '') }
    if($poopduration -gt 4.99) { 
        Write-Output "Cutting $i to 4.99 seconds"
        $goodframe = $poopframe - 1 
        gifsicle $currentwip "#0-$goodframe" -o stickerinatorcut$o.gif
        $currentwip = "stickerinatorcut$o.gif"
        break 
    }
}

# compress the gif
if ((Get-Item .\$currentwip).length / 1kb -gt 500) {
    Write-Output "Compressing $i"
    gifsicle $currentwip -O3 --lossy=200 -o stickerinatorcompressed$o.gif
    $currentwip = "stickerinatorcompressed$o.gif"
}

Write-Output "`n-----Converting $i to an APNG-----"
gif2apng $currentwip "$o.png"
$oldwip = $currentwip
$currentwip = "$o.png"
Write-Output "`n-----Converting $i to an APNG-----"

if ((Get-Item .\$currentwip).length / 1kb -gt 500) {
    if($keepgif -eq $true) {
        Rename-Item -Path $oldwip -NewName "$o.gif"
        Remove-Item -Path $currentwip -ErrorAction SilentlyContinue
    }
    Remove-Item stickerinatorresized$o.gif -ErrorAction SilentlyContinue
    Remove-Item stickerinatorcut$o.gif -ErrorAction SilentlyContinue
    Remove-Item stickerinatorcompressed$o.gif -ErrorAction SilentlyContinue
    Write-Output "`nThe Stickerinator has failed to get your file down to its required size.`nHowever, the size it is at now should hopefully be suitable for further compression and conversion on Ezgif."
} else {
    Remove-Item stickerinatorresized$o.gif -ErrorAction SilentlyContinue
    Remove-Item stickerinatorcut$o.gif -ErrorAction SilentlyContinue
    Remove-Item stickerinatorcompressed$o.gif -ErrorAction SilentlyContinue
    Write-Output "`nThe Stickerinator has successfully made your file Discord-compatible."
}