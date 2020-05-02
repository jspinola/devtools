function Connect-ServicePrincipal {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [object]
        $EnvironmentData
    )

    # Login with Service principal
    az login --service-principal --username $EnvironmentData.AppId --password $EnvironmentData.AppPassword --tenant $EnvironmentData.TenantId
    az account set --subscription $EnvironmentData.SubscriptionId
}