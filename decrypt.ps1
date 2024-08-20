<#
#wrote this in the event I write a CSharp version of the code.
# Step 1: Load the DLL into the PowerShell session
Add-Type -Path "C:\Path\To\Your\PasswordDecryptor.dll"

# Step 2: Call the DecryptPassword method from PowerShell
$decryptedPassword = [PasswordDecryptor]::DecryptPassword("C:\temp\myPassword.txt", "C:\temp\myKey.key")

# Step 3: Output the decrypted password
Write-Output $decryptedPassword
==================================
#>
# Use the code below
# Get the encrypted password
$encryptedPassword = Get-Content "c:\temp\myPassword.txt" -Raw
# Import the key (it should be obtained from a Vault preferably)
$key = Import-CliXml "c:\temp\myKey.key"

$secureString = ConvertTo-SecureString $encryptedPassword -Key $key
[System.Net.NetworkCredential]::new('', $secureString).Password

