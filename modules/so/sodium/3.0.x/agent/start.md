<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sodium (sodium) — agent index

A single Libsodium/Halite **encryption method plugin** for the Encrypt module. No config form, no
permissions, no config schema, no Drush, no hooks beyond `hook_requirements()`.

- **Install requirements, key creation, encryption profile setup, testing** →
  [configure/setup.md](configure/setup.md)
- **The plugin contract, encrypt/decrypt behaviour, error handling** →
  [plugins/encryption-method.md](plugins/encryption-method.md)

Key facts:
- Plugin: `#[EncryptionMethod(id: "sodium", title: "Sodium", key_type: ["encryption"])]` on
  `SodiumEncryptionMethod extends EncryptionMethodBase`. `key_type: ["encryption"]` means only
  Key entities of type **Encryption** are offered in the profile form.
- Hard requirements: PHP **>= 8.3**, the **libsodium PHP extension**, `paragonie/halite ^5.1`,
  `drupal/encrypt ^3.2`, `drupal/key ^1.0`. `hook_requirements('install')` aborts installation if
  the Halite class `\ParagonIE\Halite\Symmetric\Crypto` is missing.
- **Key must be exactly 32 bytes** (`SODIUM_CRYPTO_STREAM_KEYBYTES`). `checkDependencies()`
  returns an error for any other length — a 256-bit key, not a passphrase.
- `encrypt()` → `Crypto::encrypt(new HiddenString($text), new EncryptionKey(new HiddenString($key)), TRUE)`.
  The final `TRUE` requests **raw binary** output; store it in a binary-safe column or base64 it
  yourself before putting it somewhere text-only.
- Halite's `InvalidKey` and `HaliteAlert` are caught and rethrown as the Encrypt module's
  `EncryptException`, so callers only need to handle that one type.
- All secret-bearing parameters are annotated `#[\SensitiveParameter]`, and plaintext/keys are
  wrapped in `HiddenString`, so they are redacted from stack traces and dumps.
- Encryption is **authenticated** (Halite's symmetric crypto) — tampered ciphertext fails to
  decrypt rather than returning garbage.
- Nothing here is configured in this module: keys live in `key.key.*` (Key module) and profiles in
  `encrypt.profile.*` (Encrypt module).
