require 'openssl'
require_relative 'utils'

def encrypt(data, key, iv)
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.encrypt
  cipher.key = key
  cipher.iv = iv
  encrypted = cipher.update(data) + cipher.final
  encrypted
end

def decrypt(data, key, iv)
  cipher = OpenSSL::Cipher.new('AES-256-CBC')
  cipher.decrypt
  cipher.key = key
  cipher.iv = iv
  decrypted = cipher.update(data) + cipher.final
  decrypted
end
