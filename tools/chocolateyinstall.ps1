$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://developer.salesforce.com/media/salesforce-cli/sfdx-windows-386.exe'
$url64      = 'https://developer.salesforce.com/media/salesforce-cli/sfdx-windows-amd64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  url64bit      = $url64
  softwareName  = 'sfdx*'
  checksum      = 'c29bc7251b7ecbb02657cdc33b1efc373c7afff018a05039f036008f14eda12b'
  checksumType  = 'sha256'
  checksum64    = '9c33344aed91f6cc2cf97a64a69d99cbad9ebbf4a28920b8160cdfce83772326'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

$appPath = "$env:ProgramFiles\sfdx"
$statementsToRun = "/C `"$appPath\bin\sfdx.exe`" update"
$cmdExitCodes = @(0)
Start-ChocolateyProcessAsAdmin $statementsToRun cmd -validExitCodes $cmdExitCodes

Update-SessionEnvironment