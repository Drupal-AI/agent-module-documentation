<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_url.encrypt_decrypt service

```php
$svc = \Drupal::service('commerce_url.encrypt_decrypt');
$token = $svc->EncryptDecryptData($order_id, \Drupal\commerce_url\EncryptDecrypt::ENCRYPT);
$order_id = $svc->EncryptDecryptData($token, \Drupal\commerce_url\EncryptDecrypt::DECRYPT);
```

- Cipher: AES-256-CBC via `openssl_encrypt` / `openssl_decrypt`, then base64.
- Key/IV are constant strings in `src/EncryptDecrypt.php` — identical on every site, so tokens are portable/decryptable by anyone with the source. Treat as obscurity, not secrecy.
- The path processor (`CommercePathProcessor`) only triggers when path segment 1 is `checkout` and segment 2 is non-numeric (inbound) or numeric (outbound).
