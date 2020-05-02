function Connect-ServicePrincipal {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [object]
        $EnvironmentData
    )

    # Login with service principal
    $password = ConvertTo-SecureString $EnvironmentData.AppPassword -AsPlainText -Force
    $pscredential = New-Object System.Management.Automation.PSCredential($EnvironmentData.AppId, $password)
    Connect-AzureRMAccount -ServicePrincipal -Credential $pscredential -TenantId $EnvironmentData.TenantId

    # Select subscription
    Select-AzureRmSubscription -SubscriptionId $EnvironmentData.SubscriptionId
}