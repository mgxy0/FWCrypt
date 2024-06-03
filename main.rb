require 'io/console'
require_relative 'encryption'
require_relative 'utils'
require 'base64'

def prompt_password(prompt)
  print prompt
  STDIN.noecho(&:gets).strip
end

def main
  puts "Do you want to (e)ncrypt or (d)ecrypt a file?"
  choice = gets.strip.downcase

  case choice
  when 'e'
    puts "Enter the path of the file to encrypt:"
    input_path = gets.strip
    input_path = File.expand_path(input_path)

    if !File.exist?(input_path)
      puts "Error: The file to encrypt does not exist"
      puts "Checked path: #{input_path}" # Debug message
      return
    end

    password = prompt_password("Enter a password for encryption: ")
    puts

    iv = generate_iv
    data = read_file(input_path)
    original_filename = File.basename(input_path)
    metadata = "#{original_filename}|"

    combined_data = metadata + Base64.strict_encode64(data)

    encrypted_data = encrypt(combined_data, password, iv)

    output_dir = File.dirname(input_path)
    output_filename = "CryptedFW-file.fwc"
    output_path_enc = File.join(output_dir, output_filename)
    write_file(output_path_enc, Base64.strict_encode64(iv + encrypted_data))

    puts "Encrypted file saved at #{output_path_enc}"

  when 'd'
    puts "Enter the path of the encrypted file (.fwc):"
    input_path_enc = gets.strip
    input_path_enc = File.expand_path(input_path_enc)

    unless input_path_enc.end_with?('.fwc')
      puts "Error: The file to decrypt must have a .fwc extension"
      return
    end

    if !File.exist?(input_path_enc)
      puts "Error: The encrypted file does not exist"
      puts "Checked path: #{input_path_enc}" # Debug message
      return
    end

    password = prompt_password("Enter the password for decryption: ")
    puts

    encrypted_data_with_iv = Base64.strict_decode64(read_file(input_path_enc))
    iv = encrypted_data_with_iv[0...16]
    encrypted_data = encrypted_data_with_iv[16..-1]

    decrypted_data = decrypt(encrypted_data, password, iv)

    metadata_end_index = decrypted_data.index('|')
    original_filename = decrypted_data[0...metadata_end_index]
    file_data = Base64.strict_decode64(decrypted_data[(metadata_end_index + 1)..-1])

    output_path_dec = File.join(File.dirname(input_path_enc), original_filename)

    write_file(output_path_dec, file_data)

    puts "Decrypted file saved at #{output_path_dec}"

  else
    puts "Invalid choice. Please enter 'e' to encrypt or 'd' to decrypt."
  end
end

main
