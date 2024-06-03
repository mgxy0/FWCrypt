require 'openssl'

def fibonacci(n)
  return n if n < 2
  a, b = 0, 1
  (n-1).times { a, b = b, a + b }
  b
end

def woodall(n)
  n * (2 ** n) - 1
end

def generate_complex_key(password)
  key_material = []
  (1..32).each do |i|
    fib = fibonacci(i) & 0xFF
    wood = woodall(i) & 0xFF
    combined = (fib ^ wood) % 256
    key_material << combined
  end
  combined_key = key_material.pack("C*") + password
  combined_key
end

def generate_key(password, salt)
  complex_key = generate_complex_key(password)
  OpenSSL::PKCS5.pbkdf2_hmac(complex_key, salt, 20000, 32, 'sha256')
end

def generate_iv
  OpenSSL::Random.random_bytes(16) # 16 bytes for AES-256-CBC IV
end

def generate_password_hash(password, salt)
  combined_key = generate_complex_key(password)
  OpenSSL::PKCS5.pbkdf2_hmac(combined_key, salt, 20000, 32, 'sha256')
end

def read_file(path)
  unless File.exist?(path)
    raise "File not found: #{path}"
  end
  File.binread(path)
end

def write_file(path, data)
  File.binwrite(path, data)
end
