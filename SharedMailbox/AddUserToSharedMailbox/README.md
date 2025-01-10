# Adding Users to a Shared Mailbox in Exchange Online

**DESCRIPTION**  
This PowerShell script automates the process of adding users to a shared mailbox in Exchange Online. Users are imported from a CSV file and added to the specified shared mailbox using their User Principal Name (UPN) or sAMAccountName. Once completed, the script exports the updated list of shared mailbox members to a CSV file.

**REQUIREMENTS**
- PowerShell 5.1 or later
- ExchangeOnlineManagement module installed
- Valid credentials for accessing Exchange Online
- Input CSV file containing the users to add (specified by `$csvPath`)
- Alias of the shared mailbox in Exchange Online (specified by `$sharedMailboxAlias`)
- Output CSV file to log the updated members of the shared mailbox (specified by `$outputCsvPath`)

**USAGE**
1. Configure the variables in the script file according to specific needs, including `$credential`, `$sharedMailboxAlias`, `$csvPath`, and `$outputCsvPath`.
2. Ensure that the ExchangeOnlineManagement module is installed and up to date.
3. Create an input CSV file with a column named 'UPN' and/or 'sAMAccountName' and specify the path in the `$csvPath` variable.
4. Run the script using PowerShell.

**BEHAVIOR**  
The script will connect to Exchange Online and add each user listed in the CSV file to the specified shared mailbox. The following actions will be performed for each user:
1. Connect to Exchange Online using the provided credentials.
2. Iterate through each user in the CSV file:
   - If the user has a UPN, they will be added to the shared mailbox using the UPN.
   - If the user has an sAMAccountName, the script retrieves their email address and adds them to the shared mailbox using the email address.
   - If the user has neither a UPN nor an sAMAccountName, a warning message will be displayed.
   - If the addition fails, an error message will be shown.
3. Retrieve the updated list of shared mailbox members.
4. Export the updated list of members to a CSV file specified by `$outputCsvPath`.

**OUTPUT OPTIONS**
- The results will be logged to a CSV file specified by `$outputCsvPath`.
- The script will also display output on the console indicating the status of the operation for each user.

**NOTES**
- It is recommended to run this script in a development or testing environment before using it in production.
- Ensure that the credentials used have the necessary permissions to manage the shared mailbox in Exchange Online.
- The script can be further customized based on specific needs.

---

If you need any further adjustments or have any questions, feel free to ask!
