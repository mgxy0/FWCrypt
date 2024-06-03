require_relative 'encryption'
require 'securerandom'

if ARGV.length != 2
  puts "Usage: ruby main.rb [encrypt|decrypt] [file_path]"
  exit
end

action = ARGV[0]
file_path = ARGV[1]

salt = SecureRandom.hex(16)
key = Encryption.generate_key(salt)

if action == 'encrypt'
  data = File.read(file_path)
  encrypted_data = Encryption.encrypt(data, key)
  File.write(file_path + '.enc', encrypted_data)
  puts "File encrypted and saved as #{file_path}.enc"
elsif action == 'decrypt'
  encrypted_data = File.read(file_path)
  decrypted_data = Encryption.decrypt(encrypted_data, key)
  File.write(file_path.gsub('.enc', ''), decrypted_data)
  puts "File decrypted and saved as #{file_path.gsub('.enc', '')}"
else
  puts "Unknown action: #{action}"
end
