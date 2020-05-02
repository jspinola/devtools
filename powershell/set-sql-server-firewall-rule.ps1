Param(
    [Parameter(Mandatory)]
    [ValidateSet("dev", "tst", "prd")]
    [string]
    $Environment,
    [Parameter(Mandatory)]
    [string]
    $Project,
    [Parameter(Mandatory = $false)]
    [string]
    $IpAddress,
    [Parameter(Mandatory = $false)]
    [string]
    $RuleName = $null,
    [Parameter(Mandatory = $false)]
    [ValidateSet("az-cli", "azureRM")]
    [string]
    $AzFlavor = "az-cli",
    [Parameter(Mandatory = $false)]
    [string]
    $FirewallDataFileSuffix = "sqlFirewallData",
    [Parameter(Mandatory = $false)]
    [string]
    $DataFolder = "data\$Project"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Load functions
$functionsPath = "$scriptDir\functions"
Get-ChildItem "$functionsPath\*.ps1" | ForEach-Object{.$_}
Get-ChildItem "$functionsPath\azure\$AzFlavor\*.ps1" | ForEach-Object{.$_}

# Load data
$dataScriptPath = "$scriptDir\$DataFolder\$Project.$FirewallDataFileSuffix.$Environment.psd1" # i.e. contoso.sqlFirewallData.dev.psd1
$sqlServersData = Import-PowershellDataFile $dataScriptPath

if (!$IpAddress) {
    $IpAddress = Get-MyIpAddress
    Write-Host "No IP address provided. Using local ip: $IpAddress"
}

if (!$RuleName) {
    $RuleName = Get-CurrentUserName
    Write-Host "No rule name provided. Using current user name: $RuleName" 
}

foreach ($s in $sqlServersData.Servers) {
    Write-Host "Setting firewall rule $RuleName for sql server $($s.SqlServer) on RG $($s.RG)"
    Set-FirewallRule -DatabaseServer $s.SqlServer -ResourceGroup $s.RG -RuleName $RuleName -Ip $IpAddress
}