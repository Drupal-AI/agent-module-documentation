Encrypt provides a pluggable API for two-way (reversible) encryption in Drupal, pairing an encryption method plugin with a key (from the Key module) into reusable "encryption profiles" that other modules call to encrypt and decrypt data.

---

Encrypt does not encrypt anything on its own; it is the framework other modules build on to protect sensitive data at rest. It defines an `EncryptionMethod` plugin type (the actual cipher/algorithm) and an `encryption_profile` config entity that binds a chosen encryption method to a key managed by the required Key module — so the secret material lives in Key (env var, file, KMS, etc.) and never in the profile itself. Site builders create and manage encryption profiles at Admin → Configuration → System → Encryption profiles, where they can also test a profile round-trips correctly. Developers call the `encryption` service's `encrypt($text, $profile)` and `decrypt($text, $profile)` methods to store and retrieve protected values. Encryption methods can be marked deprecated (so old data still decrypts but new profiles can't use them) and can be restricted to particular key types or declared decrypt-incapable (for asymmetric/public-key scenarios). Drush commands let you encrypt, decrypt, and validate profiles from the CLI. It is a common dependency of modules like Real AES, Encrypted Field, Webform encrypt, and others that need reversible encryption. Because profiles are config entities they are exportable and deployable across environments.

---

- Provide reversible encryption for other modules to consume.
- Create an encryption profile binding a cipher to a Key.
- Encrypt a value programmatically with `encrypt($text, $profile)`.
- Decrypt a stored value with `decrypt($text, $profile)`.
- Keep key material in the Key module rather than in code or config.
- Encrypt sensitive field data via the Encrypted Field / Field Encrypt modules.
- Encrypt Webform submission data at rest.
- Provide AES encryption via the Real AES add-on method.
- Test that a profile encrypts/decrypts correctly from the admin UI.
- Encrypt/decrypt text from the CLI with `drush encrypt:encrypt` / `encrypt:decrypt`.
- Validate an encryption profile with `drush encrypt:validate-profile`.
- Implement a custom `EncryptionMethod` plugin for a bespoke cipher.
- Restrict an encryption method to specific key types.
- Deprecate an old cipher so existing data still decrypts but new profiles can't use it.
- Support asymmetric/public-key methods that can encrypt but not decrypt.
- Export encryption profiles as config for deployment.
- Look up profiles by encryption method or by key programmatically.
- Store API tokens or credentials encrypted in the database.
- Protect PII (personal data) stored in custom entities.
- Encrypt data before writing it to a shared/less-trusted store.
- List available encryption methods, optionally excluding deprecated ones.
- Gate encryption administration behind the `administer encrypt` permission.
- Swap the underlying key without rebuilding dependent modules.
- Provide base64-encoded output for safe transport/storage.
- Centralize encryption configuration across many modules in one place.
