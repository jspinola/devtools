[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    [ValidateSet("dev", "tst", "prd")]
    [string]
    $Environment,
    [Parameter(Mandatory)]
    [string]
    $Project,
    [Parameter(Mandatory = $false)]
    [ValidateSet("az-cli", "azureRm")]
    [string]
    $AzFlavor = "az-cli",
    [Parameter(Mandatory = $false)]
    [string]
    $DataFileSuffix = "data",
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
$datafileName = "$Project.$DataFileSuffix.$Environment.psd1" # i.e. contoso.data.dev.psd1
$dataScriptPath = "$scriptDir\$DataFolder\$datafileName"
$environmentData = Import-PowershellDataFile $dataScriptPath

# Login with Service principal and select sunscription
Connect-ServicePrincipal -EnvironmentData $environmentData
