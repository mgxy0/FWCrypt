# Development Notes

## Algorithms Used:
  AES-256-CBC: Highly secure symmetric encryption algorithm, used to encrypt data. AES-256 is widely accepted as the standard for encrypting sensitive data.
  PBKDF2 with SHA-256: Password-based key derivation function, used to generate secure keys by combining a salt and multiple hashing iterations. PBKDF2 makes it difficult for attackers to perform brute force attacks.
  Fibonacci and Woodall: Mathematical sequences used to generate a unique key material. Combining these sequences adds an additional layer of complexity to key generation.

## Code Structure:
  Modularity: The code is divided into modules (utils.rb, encryption.rb, main.rb) for better organization and maintenance. Each module has a specific responsibility, making it easy to update and expand the program.
  Use of Salting: Each derived key uses a randomly generated unique salt, protecting against attacks based on precomputed tables.

## Key Derivation:
  Key Complexity: The cryptographic key is derived by combining Fibonacci and Woodall numbers with the user's password. This complex key material is further processed with PBKDF2 to generate a secure key.
  PBKDF2 Iterations: Using 20,000 iterations in PBKDF2 significantly increases the time needed to perform brute force attacks, improving key security.

## HMAC:
  Data Integrity: The use of HMAC (Hash-based Message Authentication Code) guarantees that the encrypted data has not been altered. HMAC is checked during decryption to ensure data integrity.

## Development Best Practices:
  Secure Code: Follow secure development best practices, such as avoiding hardcoding keys and protecting passwords in memory.
  Input Validation: Validate all user input to avoid attacks such as injection.
  Security Log: Implement a logging system to monitor program activities, useful for detecting and responding to security incidents.

### Conclusion
  The described encryption program offers a high level of security due to the use of advanced algorithms and security techniques. 
  However, overall security depends on the correct implementation and responsible use of the program. 
