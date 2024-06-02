# 🔒 FWCrypt - Ruby Encryption Tool 🔓

![Screenshot 2024-06-02 alle 17 16 36](https://github.com/mgxy0/FWCrypt/assets/127632468/793a4259-9493-411e-9c8f-cda967161153)

FWCrypt is a simple utility to encrypt and decrypt files using Ruby's OpenSSL library.

## Features 🛠️

- 📇 **Encrypt/Decrypt**: Encrypt and decrypt your files of any type with AES-256-CBC.
- 🔑 **Security**: Generate a secure encryption based on Fibonacci and Woodall numbers.
- ✅ **Compatibility**: Uses only standard Ruby libraries.
- 💻 **Cross-Platform Compatibility**: Works on macOS, Linux, and Windows.
- 🔧 **Simple Installation**: Quickly set up and run the tool with minimal dependencies.

## Installation 📦

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/ruby-encryption-tool.git
   ```
2. Enter the project directory:
   ```sh
   cd ruby-encryption-tool
   ```
3. Install the necessary gems:
   ```sh
   gem install base64
   ```

## Usage ⚙️

1. **Encrypt a file**:
   ```sh
   ruby main.rb
   ```
   - Choose `c` to encrypt.
   - Enter the path of the file to encrypt.
   - Enter the directory to save the encrypted file.

2. **Decrypt a file**:
   ```sh
   ruby main.rb
   ```
   - Choose `d` to decrypt.
   - Enter the path of the encrypted file with `.fwc` extension.

## Requirements 🗃️

   - Ruby
   - base64 lib
   - openssl lib

### MacOS  :

```sh
brew install ruby
brew install openssl
gem install base64
```

### Linux 🐧 :

```sh
sudo apt-get update
sudo apt-get install ruby-full
sudo apt-get install libssl-dev
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

## License 📄

GNU GPLv3 🐃

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2024 - mgxy0 / mark1n0
