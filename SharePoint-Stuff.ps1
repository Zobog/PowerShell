foreach ($Server in $Servers) {
    if (-not (Test-Connection -Count 2 -Quiet -ComputerName $Server)) {
        Write-Error -Message "Unable to connect to ${Server}.  Skipping..."
    }
    if ((Get-Service -Name winrm -ComputerName $Server).Status -ne 'Running') {
        Write-Error -Message "Remoting unavailable on ${Server}.  Skipping..."
    }
    $Session = New-PSSession -ComputerName $Server
    if ($Session) {
        $Response = Invoke-Command -Session $Session -ScriptBlock {
            Add-PSSnapin -Name Microsoft.SharePoint.PowerShell
            Get-SPServiceApplicationPool | ForEach-Object { @{$_.ID = $_.Name} }
            $AppPools = & C:\Windows\System32\inetsrv\appcmd.exe list wp
            foreach ($Pool in $AppPools) {
                if ($pool -match '^(.+?)\s"(?<AppPID>.+?)"\s(\(applicationPool:)*(?<Name>.+?)\)*$') {
                    New-Object -TypeName PSObject -Property @{
                        AppPID = $matches['AppPID']
                        Name   = $matches['Name']
                    }
                }
            }
        }
        $ServiceApps = $Response[0]
        $Pools = $Response | Select-Object -Skip 1

        $Processes = Get-Process -ComputerName $Server |
        Where-Object {
            @($Pools).AppPID -contains $_.Id
        }

        foreach ($Process in $Processes) {
            $ServiceApps[$Process.Id]
            '{0} MB' -f ($Process.WorkingSet64 / 1mb)
            Get-Counter -Counter "\Process($($Process.Name))\% Processor Time" -ComputerName $Server
        }
    }
}
