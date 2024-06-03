def fibonacci(n)
  return n if n < 2
  a, b = 0, 1
  (n-1).times { a, b = b, a + b }
  b
end

def woodall(n)
  n * (2 ** n) - 1
end

def generate_key
  key = []
  (1..16).each do |i|
    key << (fibonacci(i) & 0xFF)
    key << (woodall(i) & 0xFF)
  end
  key.pack("C*").ljust(32, "\0") # Ensure the key is 32 bytes
end

def generate_iv
  OpenSSL::Random.random_bytes(16) # 16 bytes for AES-256-CBC IV
end

def read_file(path)
  File.binread(path)
end

def write_file(path, data)
  File.binwrite(path, data)
end
