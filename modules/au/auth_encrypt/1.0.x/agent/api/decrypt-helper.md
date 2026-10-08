<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auth Encrypt — mechanism, key lifecycle, and the decrypt service

Everything the module does lives in `auth_encrypt.module`, `js/auth_encrypt.js`, and
`src/Utility/AuthEncryptHelper.php`. No config objects, no routes, no permissions.

## Install / enable

- `drush en auth_encrypt`. No settings to configure — it self-attaches to the core auth forms.
- Requires the PHP `openssl` extension; `auth_encrypt_requirements()` (runtime phase) flags a
  `REQUIREMENT_ERROR` on the status report if it is missing.
- CryptoJS loads from `https://cdn.jsdelivr.net/npm/crypto-js@4.2.0/crypto-js.min.js` by default.
  To self-host, drop the file at `/libraries/crypto-js/crypto-js.min.js`;
  `auth_encrypt_library_info_alter()` detects `DRUPAL_ROOT/libraries/crypto-js` and rewrites the
  `crypto-js` library to use the local path.

## Where it hooks in (`auth_encrypt.module`)

- `hook_page_attachments_alter()` — attaches libraries `auth_encrypt/auth_encrypt` and
  `auth_encrypt/crypto-js` only when the current route is `user.login`, `user.register`, or
  `entity.user.edit_form`.
- `hook_form_alter()` — for `user_login_form`, `user_register_form`, `user_form`: adds a hidden
  field `auth_encrypt_key` (`#value` = the per-form key, `#attributes` `autocomplete=off`,
  `disabled`), bumps `name` `#maxlength` to 128 on login/register (ciphertext is longer than a
  username), and **prepends** `auth_encrypt_decrypt_form_fields` to `$form['#validate']` so
  decryption runs before core's auth validators.

## The per-form / per-session key (`auth_encrypt_get_form_key($form_id)`)

- `key_id = 'auth_encrypt_' . $form_id . '_' . session_id`.
- Looks up `keyValueExpirable('auth_encrypt')`; if absent, generates
  `bin2hex(openssl_random_pseudo_bytes(16))` (32 hex chars) and stores it with a **300-second**
  expiry (`setWithExpire`). So the key is stable for a given form+session for 5 minutes.
- This raw key is what goes into the hidden field. Both client and server then compute
  `passkey = SHA-256(rawKey)` and use *that* as the AES passphrase (JS: `CryptoJS.SHA256(rawKey)`;
  PHP: `hash('sha256', $encryption_key)`).

## Client side (`js/auth_encrypt.js`, `Drupal.behaviors.auth_encrypt`)

- On form submit, reads the hidden `auth_encrypt_key`, computes `SHA256(rawKey)`, and encrypts with
  `CryptoJS.AES.encrypt(value, passkey).toString()` (returns the OpenSSL `Salted__` base64 envelope).
- Login (`handleLoginSubmit`): encrypts `#edit-pass` and `#edit-name`, and flips the username input
  `type` to `password` so the ciphertext is masked in the field.
- Register/user-edit (`handleRegisterSubmit`): validates new vs. confirm password match client-side,
  then encrypts `#edit-current-pass`, `#edit-pass-pass1`, and `#edit-pass-pass2`.
- `clearErrorFields()` blanks the username field if it carries the `error` class on reload.

## Server-side validation & decrypt (`auth_encrypt_decrypt_form_fields`)

1. Reads submitted `auth_encrypt_key`; errors ("Form session expired…") if empty.
2. Recomputes the expected key with `auth_encrypt_get_form_key($form_id)` and compares
   (`!==`); on mismatch logs a `warning` on channel `auth_encrypt` (form id, uid, IP, UA, 8-char
   key previews) and sets a form error.
3. `passkey = hash('sha256', $encryption_key)`. Fields decrypted: `pass`, `current_pass`, and
   additionally `name` for `user_login_form`.
4. For each present field, calls `\Drupal::service('auth_encrypt.helper')->cryptoJsAesDecrypt($passkey, $value)`;
   on success replaces the form value with plaintext, on FALSE logs an `error` and **leaves the
   value unchanged** (plaintext fallback path).

## The decrypt service (`AuthEncryptHelper::cryptoJsAesDecrypt`)

Decrypts the CryptoJS/OpenSSL `Salted__` AES envelope. Constants: cipher `aes-256-cbc`, hash
`md5`, and byte layout `KEY_SIZE=8`, `IV_SIZE=4` words (× 4 bytes → 32-byte key + 16-byte IV),
`SALT_LENGTH=8`, `PREFIX_LENGTH=8`.

- Validates the base64 (`base64_decode(..., TRUE)`) and that the plaintext begins with `Salted__`;
  returns FALSE otherwise (this is what makes a non-encrypted submission fall through untouched).
- Extracts the 8-byte salt (bytes 8–15), then `deriveKeyAndIv($passphrase, $salt)` runs OpenSSL's
  legacy **EVP_BytesToKey** derivation: iteratively `block = md5(block . password . salt)` until it
  has 48 bytes, splitting into a 32-byte key and 16-byte IV.
- `openssl_decrypt(ciphertext, 'aes-256-cbc', key, OPENSSL_RAW_DATA, iv)`; FALSE on failure.

### Reusing it from custom code

```php
$plain = \Drupal::service('auth_encrypt.helper')
  ->cryptoJsAesDecrypt(hash('sha256', $rawKey), $cryptoJsCiphertext);
// $plain is the decrypted string, or FALSE.
```

It only *decrypts* CryptoJS `Salted__` AES payloads; there is no encrypt counterpart in PHP
(encryption is done in the browser).
