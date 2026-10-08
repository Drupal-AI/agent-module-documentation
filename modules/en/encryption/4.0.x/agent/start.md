<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encryption (encryption) — agent index

Supplies a simple two-way symmetric encrypt/decrypt service using PHP's openssl
(`AES-256-CTR`). The single key lives in `$settings['encryption_key']` in settings.php
(a base64-encoded 32-byte value). No module dependencies; needs the `openssl` PHP
extension. Version 4.0.0, core `^10.1 || ^11`.

No settings page (no configure route), no permissions, no drush commands, no plugins,
no config schema. The module is one service plus a reusable trait that other code calls.

- **Encrypt/decrypt a value from custom code** → [api/service.md](api/service.md)
- **Add `encrypt()`/`decrypt()` to your own form/class via the trait** → [api/service.md](api/service.md)
- **Set the key in settings.php and read the runtime status check** → [configure/key.md](configure/key.md)

Key facts:
- Service id: `encryption` (class `Drupal\encryption\EncryptionService`, interface `Drupal\encryption\EncryptionServiceInterface`).
- Trait: `Drupal\encryption\EncryptionTrait` — methods `encrypt()`, `decrypt()`, `getEncryptionKey()`.
- Settings key: `$settings['encryption_key']` — base64 of exactly 32 raw bytes.
- Cipher: `AES-256-CTR` via `openssl_encrypt` / `openssl_decrypt`.
- Runtime check: `hook_requirements()` in `encryption.install` (requirement id `encryption`); state key `encryption.test_value`; reset with `?encryption_reset_test_string=1` on the status report.
- Composer: `ext-openssl`, `php: ">= 7"`, `drupal/core: ^10.1 || ^11`.
