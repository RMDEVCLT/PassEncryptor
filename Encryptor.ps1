$key = [byte[]]::new(32)
$ran = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$ran.GetBytes($key)

# Export the new key to a file:
Export-Clixml -InputObject $key -Path "c:\temp\myKey.key"

# Import the key (it should be obtained from a Vault preferably)
$key = Import-CliXml "c:\temp\myKey.key"

$myPassWord = 'MyPassHere'
ConvertTo-SecureString $myPassWord -AsPlainText -Force | ConvertFrom-SecureString -Key $key | Set-Content "c:\temp\myPassword.txt"

<##
# Get the encrypted password
$encryptedPassword = Get-Content "c:\temp\myPassword.txt" -Raw
# Import the key (it should be obtained from a Vault preferably)
$key = Import-CliXml "c:\temp\myKey.key"

$secureString = ConvertTo-SecureString $encryptedPassword -Key $key
[System.Net.NetworkCredential]::new('', $secureString).Password

##>>

