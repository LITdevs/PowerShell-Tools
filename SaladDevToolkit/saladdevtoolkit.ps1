param ([switch] $web = $false, [switch] $desktop = $false, [switch] $storybook = $false, $basepath = '')

$version = "1.0.0"
function Check-Command($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Initial prepping
Write-Output "Salad Dev Toolkit by Vukky Limited - version $version"
Write-Host ''
if (Check-Command -cmdname 'npm') { 
    if (Check-Command -cmdname 'yarn') { } else {
        $confirmation = Read-Host 'Salad requires Yarn. Install Yarn (Y/N)'
        if ($confirmation -eq 'y') {
            npm install -g yarn
        } else {
            exit
        }
    }
} else {
    Write-Error 'Please install Node.js first.'
    exit
}

if ($pwd.Path.EndsWith("\packages")) { $basepath = $pwd.Path }
if ($basepath -eq '') { 
    Write-Error 'Please set the base path.'
    exit
}

if ($web -eq $true -or $storybook -eq $true) {
    pushd "$basepath\web-app"
    yarn install
    if ($storybook -eq $true) {
        yarn storybook
    } else {
        yarn start
    }
} elseif ($desktop -eq $true) {
    pushd "$basepath\desktop-app"
    yarn install
    yarn start
} else {
    Write-Error 'Please specify a project to build.'
    exit
}

popd