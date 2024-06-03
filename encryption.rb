require 'openssl'
require_relative 'utils'

def encrypt(data, key, iv)
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.encrypt
  cipher.key = key
  cipher.iv = iv
  encrypted = cipher.update(data) + cipher.final
  hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
  hmac + encrypted
end

def decrypt(data, key, iv)
  hmac = data[0, 32]
  encrypted = data[32..-1]
  valid_hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
  
  raise "HMAC validation failed" unless hmac == valid_hmac
  
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.decrypt
  cipher.key = key
  cipher.iv = iv
  decrypted = cipher.update(encrypted) + cipher.final
  decrypted
end
