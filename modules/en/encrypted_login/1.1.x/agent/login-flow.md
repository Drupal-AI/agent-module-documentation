<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login flow: form alter + client/server crypto

All logic lives in `encrypted_login.module` (form alter + validation + AES decrypt) and
`js/encrypted_login.js` (client encryption). There is no settings UI.

## Form alter — `encrypted_login_form_alter()`

Runs only when `$form_id === 'user_login_form'`. It:
- Adds two `#type => hidden` fields: `encrypted_aes_key` (id `edit-encrypted-aes-key`) and
  `encrypted_password` (id `edit-encrypted-password`).
- Attaches the library `encrypted_login/encrypted_login`.
- `array_unshift($form['#validate'], 'encrypted_login_validate_encrypted_credentials')` so the
  decrypt handler is the **first** validator (before core's name/auth/flood validators).
- Sets `$form['pass']['#required'] = FALSE` (the visible password field is emptied client-side
  before submit, so core must not reject it as empty).

## Client — `Drupal.behaviors.encryptedLogin` (`js/encrypted_login.js`)

1. `$.get('/encrypted_login/getPublicKey')` → reads `response.public_key` (RSA public key PEM).
2. Generates a random AES-256 key with the Web Crypto API
   (`crypto.subtle.generateKey({name:'AES-GCM',length:256}, true, …)`), exports the raw bytes,
   base64-encodes them (`aesKeyBase64`), and parses that into a crypto-js WordArray. (GCM is only
   used to mint random key bytes; the actual password encryption below is CBC.)
3. On login-form `submit` (intercepted via `once('encrypted-login', '.user-login-form', …)` +
   `event.preventDefault()`): reads `#edit-pass`, generates a random 16-byte IV
   (`CryptoJS.lib.WordArray.random(16)`), and AES-encrypts the password with
   `CryptoJS.AES.encrypt(Utf8.parse(password), aesKeyWordArray, {iv})`.
4. Builds `encryptedPasswordFinal = btoa(ivBase64 + "::" + encrypted.toString())` and RSA-encrypts
   `aesKeyBase64` with `new JSEncrypt().setPublicKey(publicKey).encrypt(...)`.
5. Writes the results into `#edit-encrypted-password` and `#edit-encrypted-aes-key`, clears
   `#edit-pass`, detaches its own submit handler, and re-submits the form.

## Server — `encrypted_login_validate_encrypted_credentials()`

- Reads `encrypted_aes_key` / `encrypted_password` from `$form_state`.
- `openssl_private_decrypt(base64_decode($encrypted_aes_key), $aes_key, $private_key)` where
  `$private_key = \Drupal::state()->get('encrypted_login.rsa_private_key')`. On failure it logs to
  the `encrypted_login` channel and `setError`s with a generic message.
- `base64_decode($aes_key)` → raw 32-byte AES key; guards for empty ciphertext / bad key.
- Calls `encrypted_login_decrypt_aes($encrypted_password, $raw_aes_key)`.
- On success: `$form_state->setValue('pass', $password)`, `unsetValue('encrypted_password')`,
  `clearErrors()`. Core's own login validators then verify the credential and enforce flood control.

## AES decrypt — `encrypted_login_decrypt_aes($encrypted_data, $key)`

`base64_decode` the field → split on `::` into `[ivB64, ciphertextB64]` → base64-decode both →
require `strlen($iv) === 16` → `openssl_decrypt($ciphertext, 'aes-256-cbc', $key, OPENSSL_RAW_DATA,
$iv)`. Returns the plaintext password or `FALSE` (logged) on any format/decrypt error.
