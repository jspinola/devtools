function Import-DataFile {
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
        [string]
        $DataFileSuffix = "data",
        [Parameter(Mandatory = $false)]
        [string]
        $DataFolder = "data\$Project",
        [Parameter(Mandatory = $false)]
        [string]
        $ScriptDir
    )

    # Load data
    if (!$ScriptDir) {
        $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    }

    # Load data
    $datafileName = "$Project.$DataFileSuffix.$Environment.psd1" # i.e. contoso.data.dev.psd1
    $dataScriptPath = "$ScriptDir\$DataFolder\$datafileName"

    $data = Import-PowershellDataFile $dataScriptPath

    return $data
}