<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auth Encrypt (auth_encrypt) — agent index

Encrypts the **password** (and login **username**) fields of Drupal's core auth forms in the
browser and decrypts them server-side. Package `Security`. Core `^10 || ^11`. Version
**1.0.0-beta2**. License GPL-2.0-or-later. **No config form, no permission, no dependencies**
(needs the PHP `openssl` extension + the CryptoJS JS library).

- **Full mechanism — hooks, the key lifecycle, the decrypt service, the JS, and how to reuse it** →
  [api/decrypt-helper.md](api/decrypt-helper.md)

## What it actually is (from source)

- Procedural module. No plugins, no entities, no routes of its own, no `config/`
  (`provides_config_schema` = false, despite the old stub). No Drush.
- **Targets three core forms** via `hook_form_alter` (`auth_encrypt.module`): `user_login_form`,
  `user_register_form`, `user_form`. `hook_page_attachments_alter` attaches the JS libraries only
  on routes `user.login`, `user.register`, `entity.user.edit_form`.
- **One service**: `auth_encrypt.helper` → `Drupal\auth_encrypt\Utility\AuthEncryptHelper`
  (`src/Utility/AuthEncryptHelper.php`), constructed with the `logger.channel.auth_encrypt`
  channel. Public method `cryptoJsAesDecrypt(string $passphrase, string $encryptedString)`.
- **Two libraries** (`auth_encrypt.libraries.yml`): `crypto-js` (CryptoJS 4.2.0, external from
  `cdn.jsdelivr.net`, or `/libraries/crypto-js/crypto-js.min.js` when present — swapped in by
  `hook_library_info_alter`) and `auth_encrypt` (`js/auth_encrypt.js`, depends on jQuery/once).
- **Install** (`auth_encrypt.install`): `hook_requirements` runtime check that `openssl` is loaded.

## Key flow in one line

Server makes a random per-form/per-session key (`auth_encrypt_get_form_key()`, 16 random bytes hex,
stored in `keyValueExpirable('auth_encrypt')` for 300s), embeds it as hidden field
`auth_encrypt_key`; both sides use `passkey = SHA-256(key)`; JS `CryptoJS.AES.encrypt(field, passkey)`;
server validation callback `auth_encrypt_decrypt_form_fields()` decrypts `pass`/`current_pass`
(+`name` on login) via the helper. Details + the AES envelope format in
[api/decrypt-helper.md](api/decrypt-helper.md).

## Notes

- **Graceful degradation**: if JS does not run, the raw (plaintext) value fails the `Salted__`
  format check, the helper returns FALSE, and the callback leaves the value unchanged — so login
  still works with plaintext. This is transport hardening layered on HTTPS, not a replacement for it.
