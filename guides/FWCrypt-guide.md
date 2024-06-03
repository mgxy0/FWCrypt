# A little guide for FWCrypt 

## Install
	
	git clone https://github.com/mgxy0/FWCrypt.git
	cd FWCrypt
	ruby main.rb

### Encrypt files

	e :
		1. Inserisci il percorso del file che desideri cifrare.
    	2. Inserisci la directory in cui desideri salvare il file cifrato.
    	3. Il programma genererà una chiave crittografica utilizzando la combinazione di Fibonacci e Woodall, e cifrerà il file utilizzando AES-256-CBC.
    	4. Il file cifrato verrà salvato nella directory specificata con estensione .fwc.

### Decrypt files

	d : 
		1. Inserisci il percorso del file cifrato (deve avere estensione .fwc).
    	2. Il programma genererà la stessa chiave utilizzando la combinazione di Fibonacci e Woodall e decifrerà il file.
    	3. Il file decifrato verrà salvato nella stessa directory del file cifrato con il nome originale.


## Esempio di Utilizzo

### Ecco un esempio passo-passo di come utilizzare il programma:

#### Avviare il Programma:
```sh
ruby main.rb
```

- Scegliere di Cifrare:
```sh
Do you want to (e)ncrypt or (d)ecrypt a file?
e
```
Inserire il Percorso del File da Cifrare:
```sh
Enter the path of the file to encrypt:
/path/to/your/file.txt
```
Inserire la Directory di Destinazione per il File Cifrato:
```sh
Enter the directory to save the encrypted file:
/path/to/save/encrypted/file
```
File Cifrato Salvato:
```sh
Encrypted file saved at /path/to/save/encrypted/file/file.txt.fwc
```

- Scegliere di Decifrare:
```sh
Do you want to (e)ncrypt or (d)ecrypt a file?
d
```
Inserire il Percorso del File Cifrato:
```sh
Enter the path of the encrypted file (.fwc):
/path/to/save/encrypted/file/file.txt.fwc
```
File Decifrato Salvato:
```sh
Decrypted file saved at /path/to/save/encrypted/file/file.txt
```

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### 2024 mgxy0 / mark1n0
