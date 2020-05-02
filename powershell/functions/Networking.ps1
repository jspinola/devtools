function Get-MyIpAddress {
    [CmdletBinding()]

    $ip = $null

    $response = Invoke-WebRequest ifconfig.me/ip

    if ($response) {
        if ($response.StatusCode -eq "200") {
            $ip = $response.Content.Trim()
        }
        else {
            Write-Host "Could not retrieve the ip address"
            Write-Host $response
        }
    }
    else {
        Write-Host "An unexpected error occurred while trying to retrieve the ip address"
    }

    $ip
}