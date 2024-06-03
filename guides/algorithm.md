# Algoritmo per la combinazione di Fibonacci e Woodall 

## Generazione delle Sequenze:
  
  1. Genera una sequenza di numeri di Fibonacci fino alla lunghezza desiderata.
  2. Genera una sequenza di numeri di Woodall fino alla lunghezza desiderata.
  3. Combina i numeri di Fibonacci e Woodall utilizzando operazioni aritmetiche e bitwise per ottenere un risultato unico e complesso.
  4. Utilizza un algoritmo di hash (ad es. SHA-256) per trasformare la combinazione in una chiave di lunghezza fissa.
  5. Usa una funzione di derivazione della chiave come PBKDF2 con un sale per rendere più difficile la generazione della chiave.

## Dettagli dell'Algoritmo

  ### Generazione delle Sequenze di Fibonacci e Woodall:
  Sequenza di Fibonacci:
        La sequenza di Fibonacci è una serie di numeri in cui ogni numero è la somma dei due numeri precedenti.
        La formula per generare i numeri di Fibonacci è:
            ```sh
            F(n) = F(n-1) + F(n-2)
            con F(0) = 0 e F(1) = 1.
            ```
  Sequenza di Woodall:
        La sequenza di Woodall è una serie di numeri calcolati come:
            ```sh
            W(n) = n * 2^n - 1
            ```
  ### Combinazione delle Sequenze:
  Per combinare le due sequenze in modo da ottenere una chiave crittografica complessa, esegui i seguenti passaggi per ogni indice ii nelle sequenze:
        Calcola:
            ```sh
            C(i) = (F(i) XOR W(i)) % 256
            ```
        Dove XOR rappresenta l'operazione bitwise XOR, che confronta i bit di due numeri e restituisce 1 se i bit sono diversi, altrimenti 0.
  ### Hashing della Chiave:
  Per garantire che la chiave combinata sia di lunghezza fissa e per aumentarne la sicurezza, utilizziamo l'algoritmo di hashing SHA-256. Questo algoritmo converte la sequenza combinata in una stringa di byte di 32 byte.
        La formula per hashare la chiave combinata è:
            ```sh
            hashed_key = SHA-256(combined_sequence)
            ```
  ### Derivazione della Chiave con PBKDF2:
        Per rendere la chiave derivata ancora più sicura e resistente agli attacchi di forza bruta, utilizziamo PBKDF2 (Password-Based Key Derivation Function 2). Questa funzione utilizza un sale e un numero di iterazioni per generare la chiave finale.
        La formula per derivare la chiave finale è:
            final_key = PBKDF2(hashed_key, salt, iterations=20000, key_length=32)

    
  ## Spiegazione dell'algoritmo

    Generazione delle Sequenze:
      Per ogni numero da 1 a 32, generiamo i numeri di Fibonacci e Woodall corrispondenti.

    Combinazione delle Sequenze:
      Utilizziamo l'operazione XOR (^) per combinare i numeri di Fibonacci e Woodall e prendiamo il modulo 256 per assicurarci che ogni valore sia un byte.

    Hashing della Chiave:
      Hashiamo la chiave combinata utilizzando SHA-256 per ottenere una chiave di lunghezza fissa.

    Derivazione della Chiave:
      Utilizziamo PBKDF2 con un sale per derivare la chiave finale, aumentando ulteriormente la sicurezza contro gli attacchi di forza bruta.

#### Questo algoritmo e la relativa implementazione migliorano significativamente la sicurezza del processo di crittografia utilizzando numeri di Fibonacci e Woodall in combinazione con tecniche di derivazione della chiave avanzate.


