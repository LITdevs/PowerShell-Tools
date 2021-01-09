 param (
    # CHANGE THE BELOW VALUE TO THE PATH TO YOUR SALAD PACKAGES FOLDER (Example: D:\Git\salad-applications\packages)
    [string]$basepath = '',
    # MODIFY VARIABLES ABOVE TO CUSTOMIZE DEFAULTS!!! DO NOT MODIFY THINGS BELOW #
    [switch]$yarn = $false,
    [switch]$yarnall = $false,
    [switch]$multiapp = $false,
    [switch]$desktopapp = $false,
    [switch]$webapp = $false,
    [switch]$gitpull = $false,
    [switch]$gitfork = $false,
    [switch]$lesslogs = $false
 )

$version = "0.4.2 (alpha)"
function Check-Command($cmdname)
{
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

# Initial prepping
Write-Output "Salad Dev Toolkit by Vukky Limited - version $version"
if ($basepath -eq '') {
    Write-Error 'Please set your base path in the source code, on line 3.'
    exit
}
if (Check-Command -cmdname 'yarn') { } else {
    Write-Error 'Building tools not installed.'
    exit
}

# Updating git repos
if($lesslogs -eq $false) {Write-Host 'Updating files and forks with git...'}
if($gitpull -eq $true -or $gitfork -eq $true) {
    if(Check-Command -cmdname 'git') { 
        pushd $basepath
        if ($gitpull -eq $true) {
            git pull origin
        }
        if ($gitfork -eq $true) {
            git fetch upstream
            git merge upstream/master
        }
        popd
    } else {
        Write-Host 'git is not installed.'
    }
} else {
    if($lesslogs -eq $false) {Write-Host 'No git arguments have been specified. You can use -gitpull to pull changes from origin, or -gitfork to merge changes from upstream for forks.'}
}

# Building
if($lesslogs -eq $false) {Write-Host "Building in $basepath."}
if ($yarnall -eq $true) {
    pushd $basepath/web-app
    yarn install
    popd
    pushd $basepath/desktop-app
    yarn install
    popd
}
if ($multiapp -eq $true) {
    Write-Host 'External windows will be opened to perform this task.'
    if ($yarn -eq $true -or $yarnall -eq $true) {
        start powershell {.\saladbuilder.ps1 -webapp -yarn}
        start powershell {.\saladbuilder.ps1 -desktopapp -yarn}
    } else {
        start powershell {.\saladbuilder.ps1 -webapp}
        start powershell {.\saladbuilder.ps1 -desktopapp}
    }
    exit
} elseif ($webapp -eq $true) {
    pushd $basepath\web-app
    if ($yarn -eq $true) {
        yarn install
    } else { 
        if($lesslogs -eq $false) {Write-Host -ForegroundColor yellow "Not running yarn install. This may result in errors. `nSpecify the -yarn argument to use yarn install."}
    }
    yarn start
} elseif ($desktopapp -eq $true) {
    pushd $basepath\desktop-app
    if ($yarn -eq $true) {
        yarn install
    } else { 
        if($lesslogs -eq $false) {Write-Host -ForegroundColor yellow "Not running yarn install. This may result in errors. `nSpecify the -yarn argument to use yarn install."}
    }
    yarn start
} else {
    if($lesslogs -eq $false) {Write-Host "You must specify an app argument to build. Use -multiapp, -desktopapp, or -webapp. `nYou can use -yarn to run yarn install for that app before building, or -yarnall to run yarn install for both the web app and the desktop app."}
}