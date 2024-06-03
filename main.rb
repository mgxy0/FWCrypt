require_relative 'encryption'
require_relative 'utils'
require 'base64'

def main
  puts "Do you want to (e)ncrypt or (d)ecrypt a file?"
  choice = gets.strip.downcase

  case choice
  when 'e'
    salt = generate_iv
    key = generate_key(salt)
    iv = generate_iv

    puts "Enter the path of the file to encrypt:"
    input_path = gets.strip
    input_path = File.expand_path(input_path)

    if !File.exist?(input_path)
      puts "Error: The file to encrypt does not exist"
      puts "Checked path: #{input_path}" # Debug message
      return
    end

    puts "Enter the directory to save the encrypted file:"
    output_dir = gets.strip
    output_dir = File.expand_path(output_dir)

    if !Dir.exist?(output_dir)
      puts "Error: The directory to save the encrypted file does not exist"
      puts "Checked directory: #{output_dir}" # Debug message
      return
    end

    data = read_file(input_path)
    original_filename = File.basename(input_path)
    metadata = "#{original_filename}|"

    combined_data = metadata + Base64.strict_encode64(data)

    encrypted_data = encrypt(combined_data, key, iv)

    output_path_enc = File.join(output_dir, "#{original_filename}.fwc")
    write_file(output_path_enc, Base64.strict_encode64(salt + iv + encrypted_data))

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

    encrypted_data_with_iv = Base64.strict_decode64(read_file(input_path_enc))
    salt = encrypted_data_with_iv[0...16]
    iv = encrypted_data_with_iv[16...32]
    encrypted_data = encrypted_data_with_iv[32..-1]
    key = generate_key(salt)

    decrypted_data = decrypt(encrypted_data, key, iv)

    metadata_end_index = decrypted_data.index('|')
    metadata = decrypted_data[0...metadata_end_index]
    file_data = Base64.strict_decode64(decrypted_data[(metadata_end_index + 1)..-1])

    output_path_dec = File.join(File.dirname(input_path_enc), metadata)

    write_file(output_path_dec, file_data)

    puts "Decrypted file saved at #{output_path_dec}"

  else
    puts "Invalid choice. Please enter 'e' to encrypt or 'd' to decrypt."
  end
end

main
