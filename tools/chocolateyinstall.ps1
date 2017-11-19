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
  checksum      = 'C29BC7251B7ECBB02657CDC33B1EFC373C7AFFF018A05039F036008F14EDA12B'
  checksumType  = 'sha256'
  checksum64    = '9C33344AED91F6CC2CF97A64A69D99CBAD9EBBF4A28920B8160CDFCE83772326'
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