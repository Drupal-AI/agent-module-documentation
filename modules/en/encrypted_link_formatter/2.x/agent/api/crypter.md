<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crypter service API

Service id `encrypted_link_formatter.crypter` (class `Drupal\encrypted_link_formatter\LinkCrypter`).

```php
$crypter = \Drupal::service('encrypted_link_formatter.crypter');
$enc = $crypter->crypt('private://dir/file.pdf');   // -> "private://$$/<encoded>"
$dec = $crypter->decrypt($encodedTail);             // reverses the tail
```

Behaviour:
- Splits scheme off `scheme://path`, then encodes/encrypts only the path.
- `base64` mode: `base64_encode()` / `base64_decode()` — reversible by anyone, not secret.
- `aes-128-cbc` mode: `openssl_encrypt($path,'AES-128-CBC',$seed,OPENSSL_RAW_DATA,$iv)` where `$iv` is read from `private://iv/iv.bin`. The seed is used verbatim as the key.

The download controller expects the marker `$$/` in the request `file` query param, decrypts the tail, rebuilds `private://<path>`, invokes `hook_file_download`, then streams a `BinaryFileResponse`. Do not rely on the encoding for authorization; keep private-file access rules in `hook_file_download`.
