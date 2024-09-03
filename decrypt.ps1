
# Use the code below
# Get the encrypted password
$encryptedPassword = Get-Content "c:\temp\myPassword.txt" -Raw
# Import the key (it should be obtained from a Vault preferably)
$key = Import-CliXml "c:\temp\myKey.key"

$secureString = ConvertTo-SecureString $encryptedPassword -Key $key
[System.Net.NetworkCredential]::new('', $secureString).Password

