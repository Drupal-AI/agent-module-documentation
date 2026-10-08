<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Url Hash rewrites Drupal Commerce checkout URLs so the numeric order ID is replaced by an encrypted token instead of the raw sequential integer.
---
The module registers an inbound/outbound path processor (`commerce_url.path_processor`) that intercepts any path beginning with `/checkout/`. On outbound URL generation it encrypts the order-ID segment; on inbound requests it decrypts the token back to the numeric ID before routing. Encryption is done by the `commerce_url.encrypt_decrypt` service (`EncryptDecrypt::EncryptDecryptData()`) using PHP `openssl_encrypt`/`openssl_decrypt` with AES-256-CBC.

Operationally you only enable the module — there is no configuration form, route, or permission. The service can also be reused from custom code to encrypt/decrypt any string. Security note: the cipher key and IV are hard-coded constants in the source, so the token is obfuscation (it hides the sequential order number from casual users) rather than a real access-control boundary; do not rely on it to protect orders — keep Commerce's own order access permissions in place.
---
- Hide the sequential Commerce order ID from checkout URLs.
- Prevent casual guessing/enumeration of neighbouring order numbers.
- Enable the module to activate URL hashing automatically (no config).
- Let the path processor encrypt the order segment on outbound links.
- Let the path processor decrypt the token on inbound checkout requests.
- Reuse `commerce_url.encrypt_decrypt` service in custom code to encrypt a value.
- Reuse the same service to decrypt a previously encrypted token.
- Wrap order IDs sent in emails or exports with the encrypted token.
- Keep multi-step checkout working (the step segment is preserved).
- Combine with Commerce order-access permissions for real protection.
- Audit the hard-coded key/IV before treating the token as secret.
- Test that `/checkout/{token}/{step}` resolves to the right order.
- Provide obscured links to customers without exposing counts.
- Roll the encryption into custom URL builders via the service.
- Disable the module to revert to plain numeric checkout URLs.