Encrypt RSA adds RSA (asymmetric) encryption method plugins to the Encrypt module, using phpseclib and OpenSSL with Key-managed PEM key pairs.

---

Encrypt RSA plugs into the Encrypt framework and contributes four `EncryptionMethod` plugins — `public_rsa` and `private_rsa` (backed by the phpseclib library) and `public_openssl_seal` and `private_openssl_seal` (backed by the PHP `openssl` extension). Because raw RSA can only encrypt small payloads, the OpenSSL Seal methods use envelope encryption: a random symmetric key encrypts the data (AES256) and RSA encrypts that key. Keys are supplied as PEM public/private key entities through the Key and Key Asymmetric modules via two `KeyType` plugins (`pem_public`, `pem_private`); the module deliberately refuses to generate key material itself and expects you to create the key pair with the `openssl` CLI. The `public_*` methods encrypt only (they cannot decrypt), which supports the recommended pattern of uploading only a public key to Drupal and keeping the private key in the separate environment that decrypts. It has no admin form, routes, permissions, or Drush commands — configuration happens entirely on the Key and Encrypt module screens.

---

- Add an RSA encryption method to the Encrypt module.
- Encrypt data with a public key using phpseclib (`public_rsa`, encrypt-only).
- Encrypt and decrypt with a private key using phpseclib (`private_rsa`).
- Encrypt data with a public key via `openssl_seal` envelope encryption (`public_openssl_seal`).
- Encrypt and decrypt with a private key via `openssl_seal`/`openssl_open` (`private_openssl_seal`).
- Encrypt payloads larger than the RSA modulus by using the OpenSSL Seal (envelope) methods.
- Wrap a random AES256 symmetric key with RSA for hybrid encryption.
- Upload only a public key to Drupal and keep the private key in a separate decrypting environment.
- Register a PEM public key as a `pem_public` Key entity for encrypt-only workflows.
- Register a PEM private key as a `pem_private` Key entity when in-Drupal decryption is required.
- Choose a 2048-bit or 4096-bit RSA key size (or a custom size) on the Key type form.
- Validate that a pasted key's actual bit length matches the declared key size.
- Build an Encryption Profile that references an RSA method plus the matching Key entity.
- Encrypt field values or other data through any Encrypt-consuming feature (encrypted fields, Webform, custom code).
- Send data to a third party who holds the private key, encrypting on your site with their public key.
- Keep the ability to decrypt confined to a hardened environment while the public site can only encrypt.
- Use a passphrase-protected private key with the Private OpenSSL Seal method.
- Rely on established crypto libraries (phpseclib, OpenSSL) instead of hand-rolled cryptography.
- Reject certificates as key input for the phpseclib RSA methods.
- Run the phpseclib RSA methods without the `openssl` extension, or the OpenSSL Seal methods without phpseclib.
- Store PEM key material through any Key provider (file, config, environment).
- Integrate RSA encryption without writing any custom encryption code.
