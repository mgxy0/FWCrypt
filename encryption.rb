require 'openssl'
require 'securerandom'
require 'base64'

class FWCrypt
  def initialize
    @cipher = OpenSSL::Cipher.new('aes-256-cbc')
  end

  def fibonacci(n)
    (0..n).each_with_object([0, 1]) { |_, fib| fib << fib[-2] + fib[-1] }
  end

  def woodall(n)
    (1..n).map { |k| k * (2**k) - 1 }
  end

  def generate_key(salt)
    fib = fibonacci(16).join
    woodall = woodall(16).join
    data = fib + woodall + salt
    OpenSSL::PKCS5.pbkdf2_hmac_sha1(data, salt, 100_000, 32)
  end

  def encrypt(file_path)
    salt = SecureRandom.hex(16)
    key = generate_key(salt)
    iv = @cipher.random_iv
    @cipher.encrypt
    @cipher.key = key
    @cipher.iv = iv

    data = File.read(file_path)
    encrypted = @cipher.update(data) + @cipher.final
    hmac = OpenSSL::HMAC.digest('sha256', key, encrypted)
    File.write(file_path + '.enc', Base64.encode64(iv + encrypted + hmac))
    puts "File encrypted and saved as #{file_path}.enc"
  end

  def decrypt(file_path)
    encrypted_data = Base64.decode64(File.read(file_path))
    iv = encrypted_data[0..15]
    hmac = encrypted_data[-32..-1]
    encrypted = encrypted_data[16...-32]
    salt = SecureRandom.hex(16)
    key = generate_key(salt)

    raise "HMAC verification failed" unless hmac == OpenSSL::HMAC.digest('sha256', key, encrypted)

    @cipher.decrypt
    @cipher.key = key
    @cipher.iv = iv
    decrypted = @cipher.update(encrypted) + @cipher.final
    File.write(file_path.gsub('.enc', ''), decrypted)
    puts "File decrypted and saved as #{file_path.gsub('.enc', '')}"
  end
end

if __FILE__ == $0
  fwcrypt = FWCrypt.new
  action = ARGV[0]
  file_path = ARGV[1]

  if action == 'encrypt'
    fwcrypt.encrypt(file_path)
  elsif action == 'decrypt'
    fwcrypt.decrypt(file_path)
  else
    puts "Usage: ruby fwcrypt.rb [encrypt|decrypt] [file_path]"
  end
end
