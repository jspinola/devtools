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

    $result = az sql server firewall-rule list -g $ResourceGroup -s $DatabaseServer --query [].'name' -o tsv

    if ($result.Contains($RuleName)) {
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

    az sql server firewall-rule create -g $ResourceGroup -s $DatabaseServer -n $RuleName --start-ip-address $Ip --end-ip-address $Ip
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

    az sql server firewall-rule update -g $ResourceGroup -s $DatabaseServer -n $RuleName --start-ip-address $Ip --end-ip-address $Ip
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

    az sql server firewal-rule delete -n $RuleName -g $ResourceGroup -s $DatabaseServer
}