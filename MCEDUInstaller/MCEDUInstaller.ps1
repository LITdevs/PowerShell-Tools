param (
    [string]$InstallType = ''
)
Function pause ($message)
{
    # Check if running Powershell ISE
    if ($psISE)
    {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("$message")
    }
    else
    {
        Write-Host "$message" -ForegroundColor Yellow
        $x = $host.ui.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    }
}

Clear-Host
Write-Host "Welcome to the unofficial Minecraft: Education Edition installer!"
Write-Host "(c) LIT Devs 2021-2022`n"
if ($InstallType -eq "") {
    $InstallType = Read-Host -Prompt "Do you want to install, update, or uninstall the game?`nType Install, Update, or Uninstall"
}
if ($InstallType -ne "Install" -And $InstallType -ne "Update" -And $InstallType -ne "Uninstall") {
    Write-Host "$InstallType is not Install, Update, or Uninstall."
    $InstallType = "Install"
    pause "Press any key to install Minecraft: Education Edition."
}
try { 
  Clear-Host
  Clear-Host
  if ($InstallType -eq "Install") {
    Write-Host "Installing Minecraft: Education Edition... `nThis might take a while. Please be patient."
    Add-AppxPackage https://aka.ms/downloadmee
  }
  if ($InstallType -eq "Update") {
    Write-Host "Updating Minecraft: Education Edition... `nThis might take a while. Please be patient."
    #$MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
    #Get-AppxPackage $MCEE
    Add-AppxPackage -Update https://aka.ms/downloadmee
  }
  if ($InstallType -eq "Uninstall") {
    Write-Host "Uninstalling Minecraft: Education Edition... `nAll your Minecraft: Education Edition data on this device is being removed."
    $MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
    Remove-AppxPackage -Package $MCEE.PackageFullName
  }
  Clear-Host
  if ($InstallType -eq "Install" -Or $InstallType -eq "Update") {
      $MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
      Write-Host "Minecraft: Education Edition" $MCEE.Version " has been installed!"
  }
  if ($InstallType -eq "Uninstall") {
    Write-Host "Minecraft: Education Edition" $MCEE.Version "has been uninstalled."
  }
  pause "Press any key to exit."
}
catch {
  Clear-Host
  Write-Host "Uh oh, something went wrong. Please send this error to Vukky!"
  Write-Host $_
  pause "Press any key to exit."
}
