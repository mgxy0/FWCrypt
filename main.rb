require 'gtk3'
require 'base64'
require 'openssl'
require_relative 'encryption'
require_relative 'utils'

class EncryptionApp
  def initialize
    @builder = Gtk::Builder.new
    @builder.add_from_string(UI_STRING)
    @window = @builder.get_object('main_window')
    @file_chooser_button = @builder.get_object('file_chooser_button')
    @password_entry = @builder.get_object('password_entry')
    @output_message = @builder.get_object('output_message')
    @image = @builder.get_object('image')

    # Imposta l'icona del programma
    set_window_icon(@window, 'icon.png')

    @builder.connect_signals { |handler| method(handler) }

    @window.signal_connect('destroy') { Gtk.main_quit }
    @window.show_all
  end

  def set_window_icon(window, icon_path)
    if File.exist?(icon_path)
      pixbuf = GdkPixbuf::Pixbuf.new(file: icon_path)
      window.set_icon(pixbuf)
    else
      puts "Icona non trovata: #{icon_path}"
    end
  end

  def on_encrypt_button_clicked
    input_path = @file_chooser_button.filename
    password = @password_entry.text.strip

    unless File.exist?(input_path)
      @output_message.text = 'Error: The file to encrypt does not exist'
      return
    end

    iv = generate_iv
    data = read_file(input_path)
    original_filename = File.basename(input_path)
    metadata = "#{original_filename}|"

    combined_data = metadata + Base64.strict_encode64(data)

    encrypted_data = encrypt(combined_data, password, iv)

    output_dir = File.dirname(input_path)
    output_filename = 'CryptedFW-file.fwc'
    output_path_enc = File.join(output_dir, output_filename)
    write_file(output_path_enc, Base64.strict_encode64(iv + encrypted_data))

    @output_message.text = "Encrypted file saved at #{output_path_enc}"
  end

  def on_decrypt_button_clicked
    input_path = @file_chooser_button.filename
    password = @password_entry.text.strip

    unless input_path.end_with?('.fwc')
      @output_message.text = 'Error: The file to decrypt must have a .fwc extension'
      return
    end

    unless File.exist?(input_path)
      @output_message.text = 'Error: The encrypted file does not exist'
      return
    end

    encrypted_data_with_iv = Base64.strict_decode64(read_file(input_path))
    iv = encrypted_data_with_iv[0...16]
    encrypted_data = encrypted_data_with_iv[16..-1]

    decrypted_data = decrypt(encrypted_data, password, iv)

    metadata_end_index = decrypted_data.index('|')
    original_filename = decrypted_data[0...metadata_end_index]
    file_data = Base64.strict_decode64(decrypted_data[(metadata_end_index + 1)..-1])

    output_path_dec = File.join(File.dirname(input_path), original_filename)

    write_file(output_path_dec, file_data)

    @output_message.text = "Decrypted file saved at #{output_path_dec}"
  end

  def on_clear_button_clicked
    @file_chooser_button.unselect_all
    @password_entry.text = ''
    @output_message.text = ''
  end

  def generate_iv
    OpenSSL::Cipher::AES.new(256, :CBC).random_iv
  end

  def read_file(file_path)
    File.read(file_path)
  end

  def encrypt(data, password, iv)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = OpenSSL::PKCS5.pbkdf2_hmac(password, 'salt', 2000, cipher.key_len, 'sha256')
    cipher.iv = iv
    cipher.update(data) + cipher.final
  end

  def decrypt(data, password, iv)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.decrypt
    cipher.key = OpenSSL::PKCS5.pbkdf2_hmac(password, 'salt', 2000, cipher.key_len, 'sha256')
    cipher.iv = iv
    cipher.update(data) + cipher.final
  end

  def write_file(file_path, data)
    File.write(file_path, data)
  end
end

UI_STRING = <<-UI
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkWindow" id="main_window">
    <property name="title">FWCrypt</property>
    <property name="default_width">900</property>
    <property name="default_height">500</property>
    <child>
      <object class="GtkBox">
        <property name="orientation">vertical</property>
        <property name="margin">20</property>
        <child>
          <object class="GtkLabel">
            <property name="label">FWCrypt</property>
            <attributes>
              <attribute name="scale" value="2"/>
              <attribute name="weight" value="bold"/>
            </attributes>
          </object>
        </child>
        <child>
          <object class="GtkBox">
            <property name="orientation">horizontal</property>
            <property name="spacing">10</property>
            <child>
              <object class="GtkImage" id="image">
                <property name="file">fwc.png</property>
                <property name="margin_end">10</property>
              </object>
            </child>
            <child>
              <object class="GtkLabel">
                <property name="label">
                  FWCrypt is a simple utility to encrypt and decrypt files using Ruby's OpenSSL library.

                  Features 🛠️
                  
                  - Encrypt/Decrypt: Encrypt and decrypt your files of any type with AES-256-CBC.
                  - Security: The cryptographic key is derived by combining Fibonacci and Woodall numbers with the user's password.
                  - Compatibility: Uses only standard Ruby libraries.
                  - Cross-Platform Compatibility: Works on macOS, Linux, and Windows.
                  - Simple Installation: Quickly set up and run the tool with minimal dependencies.
                </property>
                <attributes>
                  <attribute name="scale" value="1.1"/>
                </attributes>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkBox">
            <property name="orientation">horizontal</property>
            <property name="margin_top">10</property>
            <child>
              <object class="GtkLabel">
                <property name="label">Enter the path of the file:</property>
              </object>
            </child>
            <child>
              <object class="GtkFileChooserButton" id="file_chooser_button">
                <property name="title">Select File</property>
                <property name="margin_start">10</property>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkLabel">
            <property name="label">Enter a password:</property>
          </object>
        </child>
        <child>
          <object class="GtkEntry" id="password_entry">
            <property name="visibility">false</property>
          </object>
        </child>
        <child>
          <object class="GtkBox">
            <property name="orientation">horizontal</property>
            <property name="margin_top">10</property>
            <property name="spacing">10</property>
            <child>
              <object class="GtkButton">
                <property name="label">Encrypt</property>
                <signal name="clicked" handler="on_encrypt_button_clicked"/>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label">Decrypt</property>
                <signal name="clicked" handler="on_decrypt_button_clicked"/>
              </object>
            </child>
            <child>
              <object class="GtkButton">
                <property name="label">Clear</property>
                <signal name="clicked" handler="on_clear_button_clicked"/>
              </object>
            </child>
          </object>
        </child>
        <child>
          <object class="GtkLabel" id="output_message">
            <property name="label"></property>
            <property name="margin_top">10</property>
          </object>
        </child>
        <child>
          <object class="GtkLabel" id="license_label">
            <property name="label">created by mgxy0 - GNU GPLv3 🐃</property>
            <attributes>
              <attribute name="scale" value="0.8"/>
              <attribute name="weight" value="light"/>
            </attributes>
            <property name="margin_top">20</property>
            <property name="halign">center</property>
          </object>
        </child>
      </object>
    </child>
  </object>
</interface>
UI

app = EncryptionApp.new
Gtk.main
