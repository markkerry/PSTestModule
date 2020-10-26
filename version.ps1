# get the contents of the module manifest file
try {
    $file = (Get-Content $PSScriptRoot\PSTestModule\PSTestModule.psd1)
}
catch {
    Write-Error "Failed to Get-Content"
}

# Use RegEx to get the Version Number and set it as a version datatype
# \s* - between 0 and many whitespace
# ModuleVersion - literal
# \s - 1 whitespace
# = - literal
# \s - 1 whitespace
# ' - literal
# () - capture Group
# \d* - between 0 and many digits
# ' - literal
# \s* between 0 and many whitespace

[version]$Version = [regex]::matches($file, "\s*ModuleVersion\s=\s'(\d*.\d*.\d*)'\s*").groups[1].value
Write-Output "Old Version - $Version"

# Add one to the build of the version number
[version]$NewVersion = "{0}.{1}.{2}" -f $Version.Major, $Version.Minor, ($Version.Build + 1)
Write-Output "New Version - $NewVersion"

# Replace Old Version Number with New Version number in the file
try {
    (Get-Content $PSScriptRoot\PSTestModule\PSTestModule.psd1) -replace $version, $NewVersion | Out-File $PSScriptRoot\PSTestModule\PSTestModule.psd1
    Write-Output "Updated Module Version from $Version to $NewVersion"
}
catch {
    $_
    Write-Error "failed to set file"
}