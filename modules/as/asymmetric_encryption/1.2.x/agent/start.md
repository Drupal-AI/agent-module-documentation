<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# asymmetric_encryption

Halite (libsodium) asymmetric seal/unseal service.

- Service `asymmetric_encryption.encrypt_data` = `src/Services/Encryption.php`. Methods `encrypt()` (Crypto::seal, public key) / `decrypt()` (Crypto::unseal, secret key).
- Keys generated randomly via `KeyFactory::generateEncryptionKeyPair()`; algorithm sound, no predictable IV.
- KEY STORAGE: secret key saved unencrypted to relative path `../keys/private.key` — must resolve outside web root; lock down perms.
- Latent bug: `decrypt()` uses undefined `$this->loggerFactory` on the missing-lib branch.

See [../usage.md](../usage.md).
