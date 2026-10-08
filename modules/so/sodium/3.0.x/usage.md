<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sodium adds a Libsodium-backed encryption method to the Encrypt module, so any encryption profile can use authenticated symmetric encryption via ParagonIE's Halite library instead of older OpenSSL/mcrypt-era methods.

---

The module is one plugin. `SodiumEncryptionMethod` is declared with the modern PHP attribute `#[EncryptionMethod(id: "sodium", title: "Sodium", key_type: ["encryption"])]`, so it shows up as a choice when you create an encryption profile at `/admin/config/system/encryption/profiles/add` and only accepts Key entities whose type is *Encryption*. `encrypt()` wraps the plaintext and the key in `HiddenString` objects (Halite's guard against accidental logging or var_dump exposure), builds an `EncryptionKey`, and calls `ParagonIE\Halite\Symmetric\Crypto::encrypt(..., TRUE)` — the trailing TRUE selects raw binary output rather than hex. `decrypt()` mirrors that. Both convert Halite's `InvalidKey`/`HaliteAlert` exceptions into the Encrypt module's `EncryptException`, and every parameter carrying secret material is marked `#[\SensitiveParameter]` so PHP redacts it from stack traces. `checkDependencies()` enforces two things at runtime: the Halite class must exist, and the key must be **exactly** `SODIUM_CRYPTO_STREAM_KEYBYTES` (32) bytes — a 256-bit key. `hook_requirements()` blocks installation outright when Halite is missing. There is no configuration form, no config schema, no permissions and no Drush; everything is driven through the Key and Encrypt modules' own UIs. Composer pulls `paragonie/halite ^5.1`, `drupal/key ^1.0` and `drupal/encrypt ^3.2`, and requires PHP >= 8.3 plus the libsodium PHP extension.

---

- Encrypt field values at rest with an authenticated modern cipher.
- Give the Encrypt module a Libsodium method instead of legacy OpenSSL options.
- Protect personal data (PII) stored in Drupal fields for GDPR purposes.
- Encrypt API credentials or tokens stored in configuration.
- Encrypt webform submission values containing sensitive answers.
- Store health or financial data in Drupal with authenticated encryption.
- Satisfy an audit requirement for a named, current cipher suite.
- Use a file-based 256-bit key kept outside the docroot.
- Use an environment-variable key provider so no key touches the database.
- Rotate encryption keys by creating a new Key entity and profile.
- Test an encryption profile end to end from the Encrypt profiles UI.
- Ensure secrets never appear in stack traces via `#[\SensitiveParameter]`.
- Fail fast at install time when the Halite library is not present.
- Reject wrongly sized keys before data is written rather than after.
- Encrypt values used by any contrib module that integrates with Encrypt.
- Pair with the Field Encryption module to encrypt specific entity fields.
- Move from mcrypt-era encryption to a maintained library.
- Keep encryption logic out of custom code by using a shared profile.
- Verify key size expectations (32 bytes) programmatically in deployment checks.
- Provide authenticated encryption so tampering with ciphertext is detected.
