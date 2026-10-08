Adds HashiCorp Vault's Transit secrets engine (encryption-as-a-service) as an encryption method for the Encrypt module, so Drupal encrypts and decrypts data by calling Vault instead of holding the key locally.

---

Encrypt - Vault Transit connects Drupal's Encrypt framework to a HashiCorp Vault server's Transit secrets engine. When an Encryption Profile uses the "Vault Transit" method, encrypting text sends it (base64-encoded) to Vault's `/transit/encrypt/{key}` endpoint and stores the returned ciphertext; decrypting sends that ciphertext to `/transit/decrypt/{key}` and returns the plaintext. The encryption key never leaves Vault, so a compromise of the Drupal database or filesystem alone does not expose it. The module ships three plugins — an Encrypt `EncryptionMethod` (`vault_transit`), a Key module `KeyType` (`vault_transit`) and a `KeyInput` (`vault_transit_key`) — and nothing else: it has no admin form, route, permission, service, or config object of its own. The Vault server address, TLS options, and the authentication token are all provided by the separate Vault module (the token stored via the Key module), and it reuses Vault's `vault.vault_client_no_lease_storage` HTTP client. It is part of the Vault for Drupal suite and requires the Encrypt, Key, and Vault modules on Drupal 9.3, 10, or 11.

---

- Encrypt Drupal data through HashiCorp Vault's Transit engine instead of a locally stored key.
- Keep encryption key material inside Vault (encryption-as-a-service) so the Drupal server never holds it.
- Provide a "Vault Transit" option in the Encrypt module's encryption-method list.
- Create an Encryption Profile that offloads encrypt/decrypt to a named Vault transit key.
- Reference a Vault transit key by name using the module's Key module KeyType and KeyInput.
- Centralise key management in Vault while multiple Drupal sites share one Transit backend.
- Rotate the encryption key in Vault without changing Drupal configuration (same key name).
- Satisfy a compliance requirement that plaintext keys not be stored on the application server.
- Let any Encrypt-consuming module (e.g. Key, Real AES consumers, custom code) use Vault-backed encryption transparently.
- Encrypt field values or configuration handled by modules built on the Encrypt API.
- Protect API tokens or credentials at rest by encrypting them via Vault before storage.
- Reduce blast radius of a database breach because ciphertext alone cannot be decrypted without Vault access.
- Standardise on Vault as the single cryptographic authority across an organisation's Drupal estate.
- Combine with the Vault module's authentication (token/AppRole) to control which environment can decrypt.
- Audit all encrypt/decrypt operations centrally through Vault's own audit log.
- Support Drupal 9.3, 10, and 11 sites needing external, hosted encryption.
- Swap out an in-Drupal encryption method for a Vault-backed one without changing calling code.
- Enforce that decryption is only possible while the site can reach and authenticate to Vault.
- Use different Vault transit keys per Encryption Profile for per-purpose key separation.
- Integrate Drupal encryption into an existing HashiCorp Vault deployment already used elsewhere.
