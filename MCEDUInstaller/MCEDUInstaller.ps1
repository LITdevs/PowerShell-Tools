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
$ProgressPreference = "SilentlyContinue"
Write-Host "Minecraft: Education Edition - PowerShell Installer"
Write-Host "Vukky Limited is not responsible for any damages to your computer caused by this installer."
$InstallType = Read-Host -Prompt "Install, Update, or Uninstall"
if ($InstallType -ne "Install" -And $InstallType -ne "Update" -And $InstallType -ne "Uninstall") {
    Write-Host "$InstallType is not Install, Update, or Uninstall."
    $InstallType = "Install"
    pause "Press any key to install Minecraft: Education Edition."
}
try { 
  Clear-Host
  if ($InstallType -eq "Install" -Or $InstallType -eq "Update") {
    pause "Alert! If you will be using the iPads, make sure the iPads are on the same version as the latest MC:EDU version before continuing. Press any key to continue."
  }
  Clear-Host
  if ($InstallType -eq "Install") {
    Write-Host "Installing Minecraft: Education Edition... `nThis might take a while. Please be patient."
    Add-AppxPackage https://aka.ms/downloadmee
  }
  if ($InstallType -eq "Update") {
    Write-Host "Updating Minecraft: Education Edition... `nThis might take a while. Please be patient."
    $MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
    Get-AppxPackage $MCEE
    Add-AppxPackage -Update https://aka.ms/downloadmee
  }
  if ($InstallType -eq "Uninstall") {
    pause "Are you SURE you want to uninstall Minecraft: Education Edition? All Minecraft: Education Edition data on this device will be LOST. `nIf yes, press any key.`nIf no, please close this window."
    Clear-Host
    pause "THIS INSTALLER WILL NOT RESTORE YOUR DATA. ALL MINECRAFT: EDUCATION EDITION DATA on this device WILL BE LOST. ARE YOU STILL SURE? `nIf yes, press any key.`nIf no, please close this window."
    Clear-Host
    pause "THIS IS YOUR LAST CHANCE. DO YOU WANT TO UNINSTALL AND LOSE ALL MINECRAFT: EDUCATION EDITION DATA ON THIS DEVICE FOREVER? `nIf yes, press any key.`nIf no, please close this window."
    Clear-Host
    Write-Host "Uninstalling Minecraft: Education Edition... `nAll your Minecraft: Education Edition data on this device is being removed."
    $MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
    Remove-AppxPackage -Package $MCEE.PackageFullName
  }
  Clear-Host
  if ($InstallType -eq "Install" -Or $InstallType -eq "Update") {
      $MCEE = Get-AppxPackage Microsoft.MinecraftEducationEdition
      Write-Host "Minecraft: Education Edition" $MCEE.Version "installed!"
  }
  if ($InstallType -eq "Uninstall") {
    Write-Host "Minecraft: Education Edition" $MCEE.Version "has been uninstalled. `nYour Minecraft: Education Edition data has been removed from this device."
  }
  pause "Press any key to exit."
}
catch {
  Clear-Host
  Write-Host "Uh oh, something went wrong."
  Write-Host $_
  pause "Press any key to exit."
}