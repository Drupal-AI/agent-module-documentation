Real AES adds an "Authenticated AES" encryption method plugin to the Encrypt module, providing AES-256 CBC encryption with HMAC authentication via the Defuse PHP-Encryption library.

---

On its own the Encrypt module defines the framework for encryption profiles but ships no strong, production-grade encryption method; Real AES fills that gap. It registers a single `EncryptionMethod` plugin ("Authenticated AES (Real AES)") that delegates the actual cryptography to the well-audited Defuse PHP-Encryption library, using AES-256 in CBC mode with an HMAC for authenticated encryption. **Authenticated** encryption means the ciphertext's integrity is verified before any decryption occurs, defeating a class of ciphertext-tampering attacks on CBC. It requires a 256-bit encryption key managed through the Key module (from a file, environment, or an off-site key manager such as Lockr), referenced by an Encrypt encryption profile. Once a profile using Real AES exists, any module that encrypts through Encrypt — field encryption, stored API credentials, webform data, etc. — transparently uses this method. It has no UI or configuration of its own beyond the standard Encrypt profile form and provides a `hook_requirements` check that verifies the Defuse library is installed. It is the de-facto standard encryption method for Drupal sites needing real cryptography.

---

- Provide a strong, audited encryption method for the Encrypt module.
- Encrypt sensitive field values at rest with Field Encryption + Encrypt.
- Protect stored third-party API keys and OAuth tokens.
- Encrypt webform submission data containing personal information.
- Secure health or financial data for compliance (HIPAA/PCI-adjacent) needs.
- Authenticate ciphertext integrity to block CBC tampering attacks.
- Back an encryption profile with a File-provider 256-bit key stored outside web root.
- Integrate with off-site key managers like Lockr for key custody.
- Use environment-variable keys for containerized/12-factor deployments.
- Encrypt data programmatically via an Encrypt encryption profile service.
- Decrypt previously encrypted data with integrity verification.
- Test an encryption profile end-to-end from the Encrypt profiles UI.
- Rotate keys by creating a new profile and re-encrypting data.
- Encrypt values before writing them to third-party or external storage.
- Provide encryption for the Key module's own stored secrets.
- Encrypt user-supplied secrets in a custom module using Defuse under the hood.
- Ensure a `hook_requirements` gate fails setup when the crypto library is missing.
- Standardize on AES-256 across multiple encryption profiles.
- Encrypt cached tokens or session-adjacent secrets at the application layer.
- Replace weaker/legacy encryption methods with an authenticated one.
