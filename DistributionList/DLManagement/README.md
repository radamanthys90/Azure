
# Creation or Deletion of a Distribution List in Exchange Online

DESCRIPTION
This PowerShell script automates the creation or deletion of Distribution Lists (DL) in Exchange Online.
The details of the DLs are imported from a CSV file.

REQUIREMENTS
- PowerShell 5.1 or later
- ExchangeOnlineManagement module installed
- Valid credentials for accessing Exchange Online
- Input CSV file containing the details of DLs to be created or deleted (specified by $csvPath)

USAGE
1. Configure the variables in the script file according to specific needs, including $credential and $csvPath.
2. Ensure that the ExchangeOnlineManagement module is installed and up to date.
3. Create an input CSV file with a column named 'Action' (Create/Delete) and 'Alias' for the DL alias.
4. Run the script using PowerShell.

BEHAVIOR
The script will connect to Exchange Online and create or delete the DLs specified in the CSV file.

NOTES
- It is recommended to run this script in a development or testing environment before using it in production.
- Ensure that the credentials used have the necessary permissions to manage DLs in Exchange Online.
- The script can be further customized based on specific needs.
