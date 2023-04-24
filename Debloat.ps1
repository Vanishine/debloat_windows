# These files and a folder will be used or created.
$iso_file_path = (Get-ChildItem 'C:\*windows_10*.iso').FullName
$new_wim_path = 'C:\Windows_10_22H2.wim'
$wim_mount_dir = 'C:\mount'

# Mount the ISO file to get `install.wim`.
$iso = Mount-DiskImage $iso_file_path
$iso_driver_letter = (Get-Volume -DiskImage $iso).DriveLetter
$wim_file_path = "$iso_driver_letter`:\sources\install.wim"

# Display image infomation. Pick an `ImageIndex` you like.
Get-WindowsImage -ImagePath $wim_file_path
$wim_image_index = 3

# Extract what you selected to a new `.wim` file.
Export-WindowsImage -SourceImagePath $wim_file_path -SourceIndex $wim_image_index -DestinationImagePath $new_wim_path
Dismount-DiskImage -ImagePath $iso.ImagePath

# Now mount the new image file.
mkdir $wim_mount_dir
Mount-WindowsImage -ImagePath $new_wim_path -Index 1 -Path $wim_mount_dir

# Romove provisioned packages except allowed ones.
$pkgs = Get-AppProvisionedPackage -Path $wim_mount_dir
$pkgs_allowed = @'
Microsoft.DesktopAppInstaller
Microsoft.StorePurchaseApp
Microsoft.VCLibs.140.00
Microsoft.WindowsStore
Microsoft.Xbox.TCUI
Microsoft.XboxApp
Microsoft.XboxIdentityProvider
'@.Trim() -split "`n"

foreach ($pkg in $pkgs) {
  if ($pkg.DisplayName -in $pkgs_allowed) { continue }
  Remove-AppProvisionedPackage -Path $wim_mount_dir -PackageName $pkg.PackageName
}

# Remove some capabilities.
$caps = Get-WindowsCapability -Path $wim_mount_dir | Where-Object { $_.State -eq 'Installed' }
foreach ($cap in $caps) {
  if ($cap.Name -like 'Microsoft.Windows.Notepad*') { continue }
  if ($cap.Name -like 'DirectX.Configuration.Database*') { continue }
  if ($cap.Name -like 'Language.Basic~~~zh-CN*') { continue }
  if ($cap.Name -like 'Language.Fonts.Hans*') { continue }
  if ($cap.Name -like 'Windows.Client.ShellComponents*') { continue }
  Remove-WindowsCapability -Path $wim_mount_dir -Name $cap.Name
}

# Get features.
Get-WindowsOptionalFeature -Path $wim_mount_dir | Where-Object { $_.State -eq 'Enabled' }

# Disable features.
$feats_blocked = @'
Printing-PrintToPDFServices-Features
Windows-Defender-Default-Definitions
Printing-XPSServices-Features
MSRDC-Infrastructure
WorkFolders-Client
Printing-Foundation-Features
Printing-Foundation-InternetPrinting-Client
MicrosoftWindowsPowerShellV2Root
MicrosoftWindowsPowerShellV2
'@.Trim() -split "`n"

foreach ($feat in $feats_blocked) {
  Disable-WindowsOptionalFeature -Path $wim_mount_dir -FeatureName $feat -Remove
}

# Tweak registry.
. (Join-Path $PSScriptRoot .\Registery.ps1)

# Commit image and unmount.
Dismount-WindowsImage -Path $wim_mount_dir -Save -CheckIntegrity
