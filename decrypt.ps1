# Step 1: Load the DLL into the PowerShell session
Add-Type -Path "C:\Path\To\Your\PasswordDecryptor.dll"

# Step 2: Call the DecryptPassword method from PowerShell
$decryptedPassword = [PasswordDecryptor]::DecryptPassword("C:\temp\myPassword.txt", "C:\temp\myKey.key")

# Step 3: Output the decrypted password
Write-Output $decryptedPassword
