# 🔒A little guide for FWCrypt🔓

## Install 📦
	
git clone https://github.com/mgxy0/FWCrypt.git
cd FWCrypt
ruby main.rb

### Encrypt files 🔸

e :
1. Enter the path of the file you want to encrypt.
2. Enter the directory where you want to save the encrypted file.
3. The program will generate an encryption key using the combination of Fibonacci and Woodall, and encrypt the file using AES-256-CBC.
4. The encrypted file will be saved in the specified directory with the .fwc extension.

### Decrypt files 🔹

d:
1. Enter the path of the encrypted file (must have .fwc extension).
2. The program will generate the same key using the combination of Fibonacci and Woodall and will decipher the file.
3. The deciphered file will be saved in the same directory as the encrypted file with the original name.


## Example of Use ✍🏻

### Here’s a step-by-step example of how to use the program:

- Launch the Program 🚀:
```sh
ruby main.rb
```

- Choose to encrypt 🔸:

```sh
Do you want to (e)ncrypt or (d)ecrypt to file?
e
```

Enter the directory of the file to encrypt:
```sh
Enter the path of the file to encrypt:
/path/to/your/file.txt
```

Enter the Destination Directory for Cypher Files:
```sh
Enter the directory to save the encrypted file:
/path/to/save/encrypted/file
```

Saved Cipher File:
```sh
Encrypted file saved at /path/to/save/encrypted/file/file.txt.fwc
```

- Choose to Decrypt 🔹:

```sh
Do you want to (e)ncrypt or (d)ecrypt to file?
d
```

Enter the path of the encrypted file:
```sh
Enter the path of the encrypted file (.fwc):
/path/to/save/encrypted/file/file.txt.fwc
```

Saved Decifrate File:
```sh
Decrypted file saved at /path/to/save/encrypted/file/file.txt
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### 2024 mgxy0 / mark1n0
