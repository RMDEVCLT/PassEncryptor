using System;
using System.IO;
using System.Runtime.InteropServices;
using System.Security;

class PasswordDecryptor
{
    public static string DecryptPassword(string encryptedPasswordFilePath, string keyFilePath)
    {
        // Get the encrypted password
        string encryptedPassword = File.ReadAllText(encryptedPasswordFilePath);

        // Import the key
        byte[] keyBytes = File.ReadAllBytes(keyFilePath);
        IntPtr keyPtr = Marshal.AllocHGlobal(keyBytes.Length);
        Marshal.Copy(keyBytes, 0, keyPtr, keyBytes.Length);

        // Create a secure string from the encrypted password and key
        SecureString secureString = ConvertToSecureString(encryptedPassword, keyPtr, keyBytes.Length);

        // Get the password from the secure string
        IntPtr passwordPtr = Marshal.SecureStringToGlobalAllocUnicode(secureString);
        string password = Marshal.PtrToStringUni(passwordPtr);

        // Clean up memory
        Marshal.ZeroFreeGlobalAllocUnicode(passwordPtr);
        Marshal.FreeHGlobal(keyPtr);

        return password;
    }

    private static SecureString ConvertToSecureString(string encryptedPassword, IntPtr keyPtr, int keySize)
    {
        byte[] encryptedBytes = Convert.FromBase64String(encryptedPassword);
        byte[] decryptedBytes = new byte[encryptedBytes.Length];

        for (int i = 0; i < encryptedBytes.Length; i++)
        {
            decryptedBytes[i] = (byte)(encryptedBytes[i] ^ Marshal.ReadByte(keyPtr + (i % keySize)));
        }

        SecureString secureString = new SecureString();
        foreach (char c in System.Text.Encoding.Unicode.GetChars(decryptedBytes))
        {
            secureString.AppendChar(c);
        }

        return secureString;
    }
}

class Program
{
    static void Main(string[] args)
    {
        string decryptedPassword = PasswordDecryptor.DecryptPassword(@"c:\temp\myPassword.txt", @"c:\temp\myKey.key");
        Console.WriteLine(decryptedPassword);
    }
}
