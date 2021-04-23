param (
    [string]$mcpath = '',
    [string]$jarpath = '',
    [string]$noconsole = $false
)

if($mcpath -eq '') {
    $mcpath = Read-Host -Prompt "Enter the full path to your Minecraft runtime folder"
}
if($jarpath -eq '') {
    $jarpath = Read-Host -Prompt "Enter the full path to the JAR you want to execute"
}

if($noconsole -eq $true) {
    Start-Process $mcpath/jre-x64/bin/javaw.exe -ArgumentList '-jar', "$jarpath"
} else {
    Start-Process $mcpath/jre-x64/bin/java.exe -ArgumentList '-jar', "$jarpath"
}