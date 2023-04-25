# These files and a folder will be used or created.
$iso_file_path = (Get-ChildItem 'C:\*windows_10*.iso').FullName
$new_wim_path = 'C:\Windows_10_22H2.wim'
$wim_mount_dir = 'C:\mount'
$wsudo = "C:\Privexec-5.1.0-win-x64\wsudo.exe"
