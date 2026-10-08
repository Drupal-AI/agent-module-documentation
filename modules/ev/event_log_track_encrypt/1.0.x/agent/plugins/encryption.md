<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encryption plugins, key type & encrypt-on-write hook

## EncryptionMethod plugin: `openssl_public_encrypt`

`src/Plugin/EncryptionMethod/OpenSslPublicEncryptMethod.php`, `@EncryptionMethod(id =
"openssl_public_encrypt", key_type = {"public_pem"})`, extends Encrypt's `EncryptionMethodBase`.

- Constants: `CIPHER_ALGO = 'AES256'`, `ENVELOPE_SEPARATOR = ','`.
- `encrypt($text, $key)`: generates a 32-byte IV (`openssl_random_pseudo_bytes(32)`) and calls
  `openssl_seal($text, $sealed, $ekeys, [$key], 'AES256', $iv)`. Returns a three-part,
  comma-separated envelope of base64 values: `base64(sealed) , base64(ekeys[0]) , base64(iv)`.
  Returns the literal `'encrypt error'` if sealing fails.
- `decrypt($text, $key)`: **returns `$text` unchanged** — you cannot decrypt with a public key.
  Server-side decryption is intentionally impossible; use the Drush commands with the private key.
- `checkDependencies()`: errors if the `openssl` PHP extension is not loaded.

This is the method referenced by the shipped Encrypt profile `event_log_track_encryption`. Design
is modeled on the `encrypt_rsa` module's `PublicOpenSslSealEncryptionMethod` (per README).

## KeyType plugin: `public_pem`

- `src/Plugin/KeyType/PemPublicFormatKeyType.php`, `@KeyType(id = "public_pem", group =
  "encryption", key_value = { "plugin" = "textarea_field" })`, extends `PemFormatKeyTypeBase`.
  `getKeyDetails()` uses `openssl_get_publickey()` + `openssl_pkey_get_details()`.
- Base `src/Plugin/KeyType/PemFormatKeyTypeBase.php` (abstract, implements
  `KeyPluginFormInterface`): adds a **Key size** select (128/256/1024/2048/other, default 1024;
  the shipped Key sets 2048). `validateKeyValue()` reads the pasted PEM's actual bit length and
  errors if it does not match the selected key size. `generateKeyValue()` **throws** a
  `KeyException` — creating PEM keys in the UI is forbidden; you must generate them with the
  `openssl` CLI and paste the public key in.

## Encrypt-on-write hook

`hook_event_log_track_alter(&$log)` (`event_log_track_encrypt.module`):

```
$types = config('event_log_track.encrypt.settings')->get('event_types_to_encrypt');
if (!empty($types[$log['type']])) {
  $profile = EncryptionProfile::load('event_log_track_encryption');
  $enc = \Drupal::service('encryption')->encrypt($log['description'], $profile);
  $log['description'] = EncryptTags::TAG_START . $enc . EncryptTags::TAG_END;
}
```

- Only the `description` field is altered; every other ELT column (type, path, user, ip,
  timestamp, ref_char…) stays in plaintext for triage.
- The ciphertext is wrapped in `@@crypt@@` / `@@endcrypt@@` (`Tags\EncryptTags::TAG_START` /
  `TAG_END`). These markers are how the Drush commands locate encrypted segments.

## Related docs

- Config / profile / Key entity setup → [../config/settings.md](../config/settings.md)
- Decrypting the output → [../drush/decrypt-commands.md](../drush/decrypt-commands.md)
