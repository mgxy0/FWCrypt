require 'openssl'
require 'securerandom'
require 'base64'

module Utils
  def self.fibonacci(n)
    (0..n).each_with_object([0, 1]) { |_, fib| fib << fib[-2] + fib[-1] }
  end

  def self.woodall(n)
    (1..n).map { |k| k * (2**k) - 1 }
  end

  def self.generate_key(salt)
    fib = fibonacci(16).join
    woodall = woodall(16).join
    data = fib + woodall + salt
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(data, salt, 100_000, 32)
  end

  def self.encrypt(data, key)
    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.encrypt
    iv = cipher.random_iv
    cipher.key = key
    cipher.iv = iv
    encrypted = cipher.update(data) + cipher.final
    hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
    Base64.encode64(iv + encrypted + hmac)
  end

  def self.decrypt(encrypted_data, key)
    encrypted_data = Base64.decode64(encrypted_data)
    iv = encrypted_data[0..15]
    hmac = encrypted_data[-32..-1]
    encrypted = encrypted_data[16...-32]

    raise "HMAC verification failed" unless hmac == OpenSSL::HMAC.digest('sha256', key, encrypted)

    cipher = OpenSSL::Cipher.new('aes-256-cbc')
    cipher.decrypt
    cipher.key = key
    cipher.iv = iv
    decrypted = cipher.update(encrypted) + cipher.final
  end
end
