# Connect to Exchange Online
Connect-ExchangeOnline -Credential $credential

# Specify the alias of the shared mailbox
$sharedMailboxAlias = "sharedmailbox@company.com"  # Replace with your shared mailbox alias

# Specify the path to the input CSV file
$csvPath = "$env:USERPROFILE\Path\To\Your\CSV\Users.csv"

# Import users from the CSV file
$users = Import-Csv -Path $csvPath

# Iterate through each user and add them to the shared mailbox
foreach ($user in $users) {
    try {
        if ($user.UPN) {
            # Add the user to the shared mailbox using the UPN
            Add-MailboxPermission -Identity $sharedMailboxAlias -User $user.UPN -AccessRights FullAccess -ErrorAction Stop
            Write-Host "Added $($user.UPN) to the shared mailbox using UPN." -ForegroundColor Green
        }
        elseif ($user.sAMAccountName) {
            # Get the email address using sAMAccountName
            $email = (Get-User -Identity $user.sAMAccountName -ErrorAction Stop).PrimarySmtpAddress
            # Add the user to the shared mailbox using the email address
            Add-MailboxPermission -Identity $sharedMailboxAlias -User $email -AccessRights FullAccess -ErrorAction Stop
            Write-Host "Added $($user.sAMAccountName) to the shared mailbox using sAMAccountName." -ForegroundColor Green
        }
        else {
            Write-Host "The user has neither UPN nor sAMAccountName: $($user | ConvertTo-Json)." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Error adding the user: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Retrieve the updated list of members of the shared mailbox
$sharedMailboxMembers = Get-MailboxPermission -Identity $sharedMailboxAlias | Where-Object { $_.User -notlike "NT AUTHORITY\SELF" }

# Specify the path to the output CSV file
$outputCsvPath = "$env:USERPROFILE\Path\To\Your\CSV\updated_sharedmailbox_members.csv"

# Export the updated list of members to a CSV file
$sharedMailboxMembers | Select-Object User, AccessRights | Export-Csv -Path $outputCsvPath -NoTypeInformation

Write-Host "Updated list of shared mailbox members exported to $outputCsvPath."
