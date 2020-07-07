        #IMPORTANT: Pre-Requisite dotnet-core-uninstall tools

        # Read supported dotnet core versions from config file
        $JSON = Get-Content -Raw -Path C:\Users\rananjai\Desktop\config.json | ConvertFrom-Json
        $res = $JSON | Select-Object -Property Version 
        
        # Get all the dotnet core sdks installed in current machine
        $version = dotnet --list-sdks
        $version | ForEach-Object {
        # Hardcoded array index value. Need to update.
        # Skip supported versions 
        if(($_.Split("{ }")[0] -like $res[1].Version) -or ($_.Split("{ }")[0] -like $res[0].Version))
          {
                Write-Host ("Keeping dotnet sdk " + $_.Split("{ }")[0]) -ForegroundColor Green
          }
        
        # Unistall unsupported version
        else {
            Write-Host ("Uninstalling dotnet sdk" + $_.Split("{ }")[0]) -ForegroundColor Red
            dotnet-core-uninstall remove --sdk $_.Split("{ }")[0] --force --yes
          }
        }