require_relative 'encryption'
require_relative 'utils'
require 'base64'

def main
  puts "Vuoi (c)riptare o (d)ecriptare un file?"
  scelta = gets.strip.downcase

  case scelta
  when 'c'
    key = generate_key
    iv = generate_iv

    puts "Inserisci il percorso del file da crittografare:"
    input_path = gets.strip

    puts "Inserisci la directory in cui salvare il file crittografato:"
    output_dir = gets.strip

    data = read_file(input_path)
    original_filename = File.basename(input_path)
    metadata = "#{original_filename}|"

    combined_data = metadata + Base64.strict_encode64(data)

    encrypted_data = encrypt(combined_data, key, iv)

    output_path_enc = File.join(output_dir, "#{original_filename}.fwc")
    write_file(output_path_enc, Base64.strict_encode64(iv + encrypted_data))

    puts "File crittografato salvato in #{output_path_enc}"

  when 'd'
    puts "Inserisci il percorso del file crittografato (.fwc):"
    input_path_enc = gets.strip

    unless input_path_enc.end_with?('.fwc')
      puts "Errore: Il file da decrittare deve avere estensione .fwc"
      return
    end

    key = generate_key

    encrypted_data_with_iv = Base64.strict_decode64(read_file(input_path_enc))
    iv = encrypted_data_with_iv[0...16]
    encrypted_data = encrypted_data_with_iv[16..-1]

    decrypted_data = decrypt(encrypted_data, key, iv)

    metadata_end_index = decrypted_data.index('|')
    metadata = decrypted_data[0...metadata_end_index]
    file_data = Base64.strict_decode64(decrypted_data[(metadata_end_index + 1)..-1])

    output_path_dec = File.join(File.dirname(input_path_enc), metadata)

    write_file(output_path_dec, file_data)

    puts "File decrittografato salvato in #{output_path_dec}"

  else
    puts "Scelta non valida. Per favore inserisci 'c' per crittare o 'd' per decrittare."
  end
end

main
