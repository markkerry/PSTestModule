$manifest = Import-PowerShellDataFile $PSScriptRoot\PSTestModule\PSTestModule.psd1 
[version]$version = $Manifest.ModuleVersion
# Add one to the build of the version number
[version]$newVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1) 
# Update the manifest file
Update-ModuleManifest -Path $PSScriptRoot\PSTestModule\PSTestModule.psd1 -ModuleVersion $newVersion
Write-Output "PSTestModule.psd1 version changed from $version to $newVersion"