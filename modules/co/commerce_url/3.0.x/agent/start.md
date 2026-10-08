<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Url Hash (commerce_url) — agent index
**Encrypts the Commerce order ID in `/checkout/*` URLs via an inbound/outbound path processor.**

- **Version:** 3.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** commerce
- **Services:** `commerce_url.path_processor` (path_processor_inbound/outbound), `commerce_url.encrypt_decrypt` (`EncryptDecrypt::EncryptDecryptData($string, 'encrypt'|'decrypt')`)
- **Routes/permissions:** none (no config form, no permission).

**Security:** No routes or endpoints. Order-ID token is symmetric encryption with a HARD-CODED key and IV (`src/EncryptDecrypt.php`), so it is obfuscation only — not an access boundary. Rely on Commerce order access permissions for real protection.

See [api/encrypt-decrypt-service.md](api/encrypt-decrypt-service.md)