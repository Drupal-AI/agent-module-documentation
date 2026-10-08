<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coffre Fort encryption & secret flow

**Encryption service** (`src/CoffreFortEncryption.php`):
- Cipher `AES-256-CTR`, `openssl_encrypt/decrypt`.
- `encrypt($data,$key)` → `serialize()` then `openssl_encrypt(...)`.
- `decrypt($string,$key)` → `openssl_decrypt(...)` then `@unserialize($data)`.
- `generateNewSecretKey()` → `json_encode([$iv, randomBytesBase64(55)])`.

**Secret flow** (`Entity/CoffreFortEntity.php`):
- Each safe stores an encrypted `secret` (the real per-safe key). `unlock($key)` decrypts it into `real_secret`; `encrypt()`/data plugins then use `real_secret` to protect private data.
- `PasswordSecretProvider`: password is never stored; on unlock it re-encrypts the secret and drops a 24h cookie `DRUPAL:CFTOKEN:<uuid>`, keyed by state value `coffre_fort.password_encryption_key` (random, generated on demand).
