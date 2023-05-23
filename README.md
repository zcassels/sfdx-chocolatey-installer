## Installer/Uninstaller for Salesforce SFDX CLI

Salesforce SFDX CLI (https://developer.salesforce.com/tools/sfdxcli) is tool for developing and testing Force.com applications.

## How to Upgrade the Salesforce CLI edition.

See [creating packages](https://docs.chocolatey.org/en-us/create/create-packages) for the full set of options

1. Download the latest CLI editions from Salesforce
2. Determine the file version and associated checksum hashes for x86 and x64 editions
3. Edit chocolateyinstaller.ps1 URL and checksums
4. Run the following to [chocolatey package command](https://docs.chocolatey.org/en-us/create/commands/pack)

```Powershell

choco pack --version 7.201.6 configuration=release
```

5. Run the following script in Windows Terminal or Powershell elevated As Administrator

```Powershell
Set-Location C:\Users\{UserName}\source\repos\sfdx-chocolatey-installer\ 
choco install sfdx-cli --debug --verbose --source .
```
