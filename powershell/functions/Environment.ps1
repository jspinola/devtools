function Get-CurrentUserName {
    [CmdletBinding()]
    # $userName
    # $env:UserName
    # $env:UserDomain
    # $env:ComputerName
    $name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $userName = $name.Split("\")[1]

    return $userName
}