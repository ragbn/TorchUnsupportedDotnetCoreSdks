function RemoveEndOfLifeSDKs($version){
  $installed_sdks = ExtractVersionNumber $version
  $supported_sdks = GetSupportedVersionList
  $unsupported_sdks = GetVersionsToRemove $installed_sdks $supported_sdks
  write-host ("Removing end of life dotnet core versions " + $unsupported_sdks + ". This will take some time.") -ForegroundColor Red
  dotnet-core-uninstall remove --sdk $unsupported_sdks --force --yes
}

function RemoveEndOfLifeRuntimes($versions){
  $installed_runtimes = ExtractVersionNumber $versions
  $supported_runtimes = GetSupportedVersionList
  $unsupported_runtimes = GetVersionsToRemove $installed_runtimes  $supported_runtimes 
  dotnet-core-uninstall remove --runtime $unsupported_runtimes --force --yes
}

function GetVersionsToRemove($installed, $retained){
  $b =  $installed | ? {$Prog=$_; $retained | where {$Prog -Like $_ } }
  $c = $b -join "|"
  $unsupported_package_versions = $installed | Where-Object {$_ -notmatch "\b(?:$c)\b"}
  return $unsupported_package_versions
}

function ExtractVersionNumber($results) {
  $regex = '(\d+\.)(\d+\.)(\d+)';
  $version =[System.Collections.ArrayList] [Regex]::Matches($results, $Regex) | Select-Object -Property Value;
  return $version.Value
}

function GetSupportedVersionList {
$JSON = Get-Content -Raw -Path config.json | ConvertFrom-Json     
$res = $JSON | Select-Object -Property Version 
return $res.Version      
}

$eol_sdk_versions = dotnet --list-sdks 
RemoveEndOfLifeSDKs $eol_sdk_versions 

      # REMOVING SDK WILL AUTOMATICALLY REMOVE CORRESPONDING RUNTIME, USE IT IF YOU WOULD LIKE TO REMOVE SPECIFIC RUNTIME EXPLICITY
      # -----------------------------------------------
      # $eol_runtime_versions = dotnet --list-runtimes
      # RemoveEndOfLifeRuntimes  $eol_runtime_versions