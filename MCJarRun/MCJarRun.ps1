$mclocation = Read-Host -Prompt "Enter the full path to your Minecraft runtime folder"
$jarlocation = Read-Host -Prompt "Enter the full path to the JAR you want to execute"

Start-Process $mclocation/jre-x64/bin/java.exe -ArgumentList '-jar', "$jarlocation"