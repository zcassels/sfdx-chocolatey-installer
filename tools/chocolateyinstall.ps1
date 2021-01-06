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
  softwareName  = 'Salesforce CLI*'
  checksum      = '5539CC2B23CE2126E5563B8C1A3A258D0ED3F2BCFCC20A0AA587A3CA7CDF1A73'
  checksumType  = 'sha256'
  checksum64    = '0956CE890A6672DB5444A48C1462F76CC7DC2459DDF42EB6EA50292F0238AF25'
  checksumType64= 'sha256'
  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs 

$appPath = "$env:ProgramFiles\Salesforce CLI"
$statementsToRun = "/C `"$appPath\bin\sfdx.cmd`" update"
$cmdExitCodes = @(0)
Start-ChocolateyProcessAsAdmin -Statements "$statementsToRun" -ExeToRun "cmd" -validExitCodes $cmdExitCodes

Update-SessionEnvironment