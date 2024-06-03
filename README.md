# 🔒 FWCrypt - Ruby Encryption Tool 🔓

![Screenshot 2024-06-02 alle 17 16 36](https://github.com/mgxy0/FWCrypt/assets/127632468/793a4259-9493-411e-9c8f-cda967161153)

FWCrypt is a simple utility to encrypt and decrypt files using Ruby's OpenSSL library.

## Features 🛠️

- 📇 **Encrypt/Decrypt**: Encrypt and decrypt your files of any type with AES-256-CBC.
- 🔑 **Security**: The cryptographic key is derived by combining Fibonacci and Woodall numbers with the user's password. This complex key material is further processed with PBKDF2 to generate a secure key. PBKDF2 Iterations: Using 20,000 iterations in PBKDF2 significantly increases the time needed to perform brute force attacks, improving key security.
- ✅ **Compatibility**: Uses only standard Ruby libraries.
- 💻 **Cross-Platform Compatibility**: Works on macOS, Linux, and Windows.
- 🔧 **Simple Installation**: Quickly set up and run the tool with minimal dependencies.

## Installation 📦

### Linux 🐧 :
```sh
sudo apt-get update
sudo apt-get install ruby-full
sudo apt-get install libssl-dev
gem install base64
```
### MacOS  :
```sh
brew install ruby
brew install openssl
gem install base64
```
### Windows 🪟 :
1. Download and install Ruby using RubyInstaller from [rubyinstaller.org](https://rubyinstaller.org/).
2. Ensure you select the option to add Ruby to the PATH during installation: select "Add Ruby executables to your PATH".
3. After installation, open a new command prompt window and install the necessary gems:
   ```sh
   gem install openssl
   gem install base64
   ```
### Universal ⛓️ [Linux, MacOS, Windows]
- Import with git :
  ```sh
  git clone https://github.com/mgxy0/FWCrypt.git
  cd FWCrypt
  ```

## Usage ⚙️

1. **Encrypt a file**:
   ```sh
   ruby main.rb
   ```
   - Choose `c` to encrypt. 
   - Enter the path of the file to encrypt. 
   - Enter a strong password. 
   - The crypted files is named "CryptedFW-file.fwc" in the same path.

2. **Decrypt a file**:
   ```sh
   ruby main.rb
   ```
   - Choose `d` to decrypt. 
   - Enter the path of the encrypted file with `.fwc` extension. 
   - Enter the password. 
   - The decrypted file is in the same path.

## Requirements 🗃️

   - Ruby 🔻
   - base64 lib 
   - openssl lib

## License 📄

GNU GPLv3 🐃

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2024 - mgxy0 / mark1n0
