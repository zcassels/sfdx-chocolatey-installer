$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= $env:ChocolateyPackageName
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-x86.exe'
$url64      = 'https://developer.salesforce.com/media/salesforce-cli/sfdx/channels/stable/sfdx-x64.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  url64bit      = $url64
  softwareName  = 'Salesforce CLI*'
  checksum      = '16ABFD04063EB6038B667F48E000EC31732BD7E5D1E2E1A7FC86760AED818A7B'
  checksumType  = 'sha256'
  checksum64    = '92E4A3FE83819B614C618B0629DFC448A18271542C4F490B8508E1402F2331DD'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

$appPath = "$env:ProgramFiles\sfdx"
$statementsToRun = "/C `"$appPath\bin\sfdx.cmd`" update"
$cmdExitCodes = @(0)
Start-ChocolateyProcessAsAdmin -Statements "$statementsToRun" -ExeToRun "cmd" -validExitCodes $cmdExitCodes

Update-SessionEnvironment