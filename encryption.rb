require 'openssl'
require_relative 'utils'

def encrypt(data, password, iv)
  salt = generate_iv
  key = generate_key(password, salt)
  password_hash = generate_password_hash(password, salt)
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.encrypt
  cipher.key = key
  cipher.iv = iv
  encrypted = cipher.update(data) + cipher.final
  hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
  salt + password_hash + hmac + encrypted
end

def decrypt(data, password, iv)
  salt = data[0...16]
  stored_password_hash = data[16...48]
  hmac = data[48...80]
  encrypted = data[80..-1]
  key = generate_key(password, salt)
  password_hash = generate_password_hash(password, salt)
  
  raise "Password validation failed" unless stored_password_hash == password_hash
  
  valid_hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
  
  raise "HMAC validation failed" unless hmac == valid_hmac
  
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.decrypt
  cipher.key = key
  cipher.iv = iv
  decrypted = cipher.update(encrypted) + cipher.final
  decrypted
end
