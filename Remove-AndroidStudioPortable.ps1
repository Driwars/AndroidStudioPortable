﻿#Requires -Version 2.0

<#
    .SYNOPSIS
        Removes all installed packages but leaves the configuration
        directory specified in `$PortableHomeDirectory`.
 #>

#
# Definitions
#

. '.\AndroidStudioPortable-Definitions.ps1'

#
# Helpers
#

. '.\AndroidStudioPortable-Helpers.ps1'

#
# Remove temporary files.
#

$aria2RootDirectory =
    Get-RelativeRootDirectory -RelativePath $aria2Directory
$LessMSIRootDirectory =
    Get-RelativeRootDirectory -RelativePath $LessMSIDirectory
$7zRootDirectory =
    Get-RelativeRootDirectory -RelativePath $7zDirectory

$TemporaryFiles = @(
	$aria2Archive,
	$aria2RootDirectory,
    $LessMSIArchive,
    $LessMSIRootDirectory,
    $7zInstaller,
    $7zRootDirectory,
    $AndroidSDKArchive,
    $AndroidStudioArchive,
    $OracleJDKInstaller,
    $OracleJDKInternalArchive
)

$RemoveItemParameters = @{
    Path = $TemporaryFiles;
    ErrorAction = 'SilentlyContinue';
}
Remove-Item @RemoveItemParameters -Recurse -Force

#
# Remove installed packages.
#

$AndroidSDKRootDirectory =
    Get-RelativeRootDirectory -RelativePath $AndroidSDKDirectory
$AndroidStudioRootDirectory =
    Get-RelativeRootDirectory -RelativePath $AndroidStudioDirectory
$OracleJDKRootDirectory =
    Get-RelativeRootDirectory -RelativePath $OracleJDKDirectory

#
# 260 characters workaround
#

& 'CMD' '/C' 'RMDIR' '/S' '/Q' $AndroidSDKRootDirectory 2>&1 |
    Out-Null
& 'CMD' '/C' 'RMDIR' '/S' '/Q' $AndroidStudioRootDirectory 2>&1 |
    Out-Null

$InstalledPackages = @(
    $AndroidSDKRootDirectory,
    $AndroidStudioRootDirectory,
    $OracleJDKRootDirectory
)

$RemoveItemParameters = @{
    Path = $InstalledPackages;
    ErrorAction = 'SilentlyContinue';
}
Remove-Item @RemoveItemParameters -Recurse -Force
