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
  checksum      = 'e885c57e6a4025711a58fe834030004b9b70289116ad9f86063419b078cca60f'
  checksumType  = 'sha256'
  checksum64    = '8fbe798e1ddb07f108e94b545d102ce5fcd5e4af64839a0c82f5f2fbea57e2c2'
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