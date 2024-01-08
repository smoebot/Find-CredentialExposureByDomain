function Find-CredentialExposureByDomain{
<#
    .SYNOPSIS
        Search Recorded Future for exposed credentials related to a specific domain
    .DESCRIPTION
        Search Recorded Future for exposed credentials related to a specific domain
        Returns list of login/username values and when available, corresponding domain used
    .PARAMETER Domain
        [Mandatory]
        The domain name to search for
    .NOTES
        Author: Joel Ashman
        v0.1 - (2024-01-03) Initial version
    .EXAMPLE
        Find-CredentialExposureByDomain -Domain example.com
    #>

    #requires -version 5
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Domain
    )

    $ApiToken = "API Token goes here" # Not a secure way to store this - should investigate another option
    $RecordedFutureCredDomainUrl = "https://api.recordedfuture.com/identity/credentials/search"
    $Header = @{"X-RFToken" = $ApiToken} # Authorisation header for RF API
    $Params = @{ # Build the table to hold the request body data (case sensitive)
        'domains' = @($Domain)
    }
    $Body = $Params | ConvertTo-Json # Convert the table to JSON for the API to accept it
    # POST request to the API
    try{
        (Invoke-restmethod -Method Post -Headers $Header -Uri $RecordedFutureCredDomainUrl -Body $Body -ContentType application/json).identities
    }
    catch{
        if($Error.Errors -eq $null){Write-Warning "Error: $($Error[0].ErrorDetails.message)"}
        else{Write-Warning "Error: $($Error.Errors.Message)"}
    }
}
