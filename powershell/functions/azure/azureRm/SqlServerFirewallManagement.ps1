function Set-FirewallRule {
    [CmdletBinding()]
    param(
        [parameter (Mandatory=$true, position = 0)]
        [String]$RuleName,
        [parameter (Mandatory=$true, position = 1)]
        [String]$DatabaseServer,
        [parameter (Mandatory=$true, position = 2)]
        [String]$ResourceGroup,
        [parameter (Mandatory=$true, position = 3)]
        [String]$Ip
    )

    $result = Get-AzureSqlDatabaseServerFirewallRule -RuleName $RuleName -ServerName $DatabaseServer

    if ($result) {
        Update-FirewallRule -RuleName $RuleName -DatabaseServer $DatabaseServer -ResourceGroup $ResourceGroup -Ip $Ip
    }
    else {
        New-FirewallRule -RuleName $RuleName -DatabaseServer $DatabaseServer -ResourceGroup $ResourceGroup -Ip $Ip
    }
}

function New-FirewallRule {
    [CmdletBinding()]
    param(
        [parameter (Mandatory=$true, position = 0)]
        [String]$RuleName,
        [parameter (Mandatory=$true, position = 1)]
        [String]$DatabaseServer,
        [parameter (Mandatory=$true, position = 2)]
        [String]$ResourceGroup,
        [parameter (Mandatory=$true, position = 3)]
        [String]$Ip
    )

    New-AzureSqlDatabaseServerFirewallRule -StartIPAddress $Ip -EndIPAddress $Ip -RuleName $RuleName -ServerName $DatabaseServer
}

function Update-FirewallRule {
    [CmdletBinding()]
    param(
        [parameter (Mandatory=$true, position = 0)]
        [String]$RuleName,
        [parameter (Mandatory=$true, position = 1)]
        [String]$DatabaseServer,
        [parameter (Mandatory=$true, position = 2)]
        [String]$ResourceGroup,
        [parameter (Mandatory=$true, position = 3)]
        [String]$Ip
    )

    Set-AzureSqlDatabaseServerFirewallRule -StartIPAddress $ip -EndIPAddress $ip -RuleName $RuleName -ServerName $DatabaseServer
}

function Remove-FirewallRule {
    [CmdletBinding()]
    param(
        [parameter (Mandatory=$true, position = 0)]
        [String]$RuleName,
        [parameter (Mandatory=$true, position = 1)]
        [String]$DatabaseServer,
        [parameter (Mandatory=$true, position = 2)]
        [String]$ResourceGroup
    )

    Remove-AzureSqlDatabaseServerFirewallRule -RuleName $RuleName -ServerName $DatabaseServer
}