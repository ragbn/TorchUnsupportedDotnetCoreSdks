       <# #IMPORTANT: Pre-Requisite dotnet-core-uninstall tool

        # Read supported dotnet core versions from config file
        $JSON = Get-Content -Raw -Path \config.json | ConvertFrom-Json
        $res = $JSON | Select-Object -Property Version 
        
        # Get all the dotnet core sdks installed in current machine
        $version = dotnet --list-sdks
        
        $version | ForEach-Object {
        # Hardcoded array index value. Need to update.
        # Skip supported versions 
        if(($_.Split("{ }")[0] -like $res[1].Version) -or ($_.Split("{ }")[0] -like $res[0].Version)){
            Write-Host ("Keeping dotnet sdk " + $_.Split("{ }")[0]) -ForegroundColor Green
        }
        # Unistall unsupported version
        else {
            Write-Host ("Uninstalling dotnet sdk" + $_.Split("{ }")[0]) -ForegroundColor Red
            dotnet-core-uninstall remove --sdk $_.Split("{ }")[0] --force --yes
        }#>








        # New Approch 
        $JSON = Get-Content -Raw -Path config.json | ConvertFrom-Json     
        $res = $JSON | Select-Object -Property Version 
 
        $version = dotnet --list-sdks 
        $Regex = '(\d+\.)(\d+\.)(\d)';
        $version =[System.Collections.ArrayList] [Regex]::Matches($version, $Regex) | Select-Object -Property Value;
    
       <# $b =  $version.Value | ? {$Prog=$_; $res.Version | where {$Prog -Like $_ } }
       
        $c = $b -join "|"
     
        $a = $version.Value | Where-Object {$_ -notmatch "\b(?:$c)\b"}
        $a#>
       $s = GetVersionsToRemove $version.Value $res.Version
      # $s 
       $l = $s -join ","
       $l
       function GetVersionsToRemove($installed, $retained)
       {
        # $installed
        $b =  $installed | ? {$Prog=$_; $retained | where {$Prog -Like $_ } }
        $c = $b -join "|"
        $a = $installed | Where-Object {$_ -notmatch "\b(?:$c)\b"}
        return $a
       }
       
       
       
       
       
       
       
       
       
       
       
       
       
       
     <#   <#  [System.Collections.ArrayList] $version.Value
        $version.Value | ForEach-Object {
            $temp = $_
            $res.Version | ForEach-Object{
             
              if($temp -like $_)
              {
                  Write-Host $temp
                  $a.Remove($temp)
                  $temp
              }
            }
            
        }
        [array]$a = 

        $version.Value#>
        #$version.Value | % {if ()}
        #$version.Value | % {$r=@()}{$t=$_; $res.Version | % {if ($t -like $_){$r+=$t}}}{$r}
        #$version.Value | Where {$_ -notlike $res.Version}
        #$res.Version | % {$r=@()}{$t=$_; $res.Version | % {if ($t -like $_){$r+=$t}}}{$r}

        #$tabres =  $res.Version | where {$r -notcontains $_}
        #$version.Value | ? {$Prog=$_; $res.Version | where {$Prog -Like $_ } }
       # $version.Value | Where-Object test -like '2.1.*, 3.1.*'
       

        #$array = @("2.1.1","3.1.3")
        #$ro = $version.Value | Where-Object -FilterScript { $_ -in $array}#$res.Version }
        #$ro
        #$version.Split("{ }")[0]
        #$res[0].Version
        #$version.Value | ForEach-Object {
          #$_.Split("{ }")[0].Trim()
         # $res
         #if ($_ -like $res.Version
          #if ($res.Version -contains $_.Split("{ }")[0]) {
           # Write-Host "`$array2 contains the `$array1 string [$_]"
         # }
        #}#>

      



#}

