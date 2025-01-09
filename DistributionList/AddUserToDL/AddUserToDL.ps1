param (
    [Parameter(Mandatory = $true)]
    [string]$CredentialPath,

    [Parameter(Mandatory = $true)]
    [string]$DLAlias,

    [Parameter(Mandatory = $true)]
    [string]$CSVPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputCSVPath
)

# Import credentials
$credential = Import-Clixml -Path $CredentialPath

# Connect to Exchange Online
Connect-ExchangeOnline -Credential $credential

# Import users from the CSV file
$users = Import-Csv -Path $CSVPath

# Iterate through each user and add them to the DL
foreach ($user in $users) {
    try {
        if ($user.UPN) {
            # Add the user to the DL using the UPN
            Add-DistributionGroupMember -Identity $DLAlias -Member $user.UPN -ErrorAction Stop
            Write-Host "Added $($user.UPN) to the DL using UPN." -ForegroundColor Green
        }
        elseif ($user.sAMAccountName) {
            # Get the email address using the sAMAccountName
            $email = (Get-User -Identity $user.sAMAccountName -ErrorAction Stop).PrimarySmtpAddress
            # Add the user to the DL using the email address
            Add-DistributionGroupMember -Identity $DLAlias -Member $email -ErrorAction Stop
            Write-Host "Added $($user.sAMAccountName) to the DL using sAMAccountName." -ForegroundColor Green
        }
        else {
            Write-Host "The user does not have either UPN or sAMAccountName: $($user | ConvertTo-Json)." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error adding the user: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Retrieve the updated list of DL members
$dlMembers = Get-DistributionGroupMember -Identity $DLAlias

# Export the updated list of members to a CSV file
$dlMembers | Select-Object DisplayName, PrimarySmtpAddress | Export-Csv -Path $OutputCSVPath -NoTypeInformation

Write-Host "Updated list of DL members exported to $OutputCSVPath."
