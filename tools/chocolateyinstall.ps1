﻿$ErrorActionPreference = 'Stop';

$packageName= 'prometheus-wmi-exporter.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/martinlindhe/wmi_exporter/releases/download/v0.11.0/wmi_exporter-0.11.0-386.msi'
$url64      = 'https://github.com/martinlindhe/wmi_exporter/releases/download/v0.11.0/wmi_exporter-0.11.0-amd64.msi'

$pp = Get-PackageParameters

$silentArgs = "/quiet /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""

if ($pp["EnabledCollectors"] -ne $null -and $pp["EnabledCollectors"] -ne '') { 
  $silentArgs += " ENABLED_COLLECTORS=$($pp["EnabledCollectors"])"
  Write-Host "Collectors: `'$($pp["EnabledCollectors"])`'"
}

if ($pp["ListenAddress"] -ne $null -and $pp["ListenAddress"] -ne '') { 
  $silentArgs += " LISTEN_ADDR=$($pp["ListenAddress"])" 
  Write-Host "Listen Address: `'$($pp["ListenAddress"])`'"
}

if ($pp["ListenPort"] -ne $null -and $pp["ListenPort"] -ne '') { 
  $silentArgs += " LISTEN_PORT=$($pp["ListenPort"])"
  Write-Host "Listen Port: `'$($pp["ListenPort"])`'"
}

if ($pp["MetricsPath"] -ne $null -and $pp["MetricsPath"] -ne '') { 
  $silentArgs += " METRICS_PATH=$($pp["MetricsPath"])"
  Write-Host "Metrics Path: `'$($pp["MetricsPath"])`'"
}

if ($pp["TextFileDir"] -ne $null -and $pp["TextFileDir"] -ne '') { 
  $silentArgs += " TEXTFILE_DIR=$($pp["TextFileDir"])"
  Write-Host "Textfile Directory: `'$($pp["TextFileDir"])`'"
}

if ($pp["ExtraFlags"] -ne $null -and $pp["ExtraFlags"] -ne '') { 
  $silentArgs += " EXTRA_FLAGS=$($pp["ExtraFlags"])"
  Write-Host "Extra flags: `'$($pp["ExtraFlags"])`'"
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64

  softwareName  = 'WMI Exporter*'

  checksum      = '546DB0EE517BD79D69B81CA9D153535A6409ADE61966BCB42314054E11233456'
  checksumType  = 'sha256'
  checksum64    = '43BBF46C90A01F54AFF336FEEC74B20DA71A609332C26D1E16E5506B688223E2'
  checksumType64= 'sha256'

  silentArgs    = $silentArgs
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
