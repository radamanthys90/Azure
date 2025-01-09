param (
    [Parameter(Mandatory = $true)]
    [pscredential]$Credential,

    [Parameter(Mandatory = $true)]
    [string]$CSVPath
)

# Connect to Exchange Online
Connect-ExchangeOnline -Credential $Credential

# Import the DL details from the CSV file
$dlDetails = Import-Csv -Path $CSVPath

# Iterate through each DL in the CSV file and create or delete the DL
foreach ($dl in $dlDetails) {
    try {
        if ($dl.Action -eq "Create") {
            # Create the DL
            New-DistributionGroup -Alias $dl.Alias -Name $dl.Name -PrimarySmtpAddress $dl.PrimarySmtpAddress -ErrorAction Stop
            Write-Host "Created DL with Alias: $($dl.Alias)." -ForegroundColor Green
        }
        elseif ($dl.Action -eq "Delete") {
            # Delete the DL
            Remove-DistributionGroup -Identity $dl.Alias -Confirm:$false -ErrorAction Stop
            Write-Host "Deleted DL with Alias: $($dl.Alias)." -ForegroundColor Green
        }
        else {
            Write-Host "Unrecognized action for Alias: $($dl.Alias): $($dl.Action)." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error executing action for DL with Alias: $($dl.Alias): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Operation completed."
