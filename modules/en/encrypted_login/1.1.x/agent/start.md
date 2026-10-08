<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encrypted Login (encrypted_login) — agent index

Alters the core **`user_login_form`** so the password is encrypted in the browser (hybrid
**RSA-2048** key exchange + **AES-256-CBC**) before submit, and decrypts it server-side in a login
validation handler so standard Drupal authentication runs normally. Package `Security`. Depends
only on core **`user`**. Core requirement `^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

No settings form, no permissions, no config objects/schema, no plugins, no Drush, no entities.

- **Login-form alter + client-side and server-side crypto** → [login-flow.md](login-flow.md)
- **Install, RSA key generation/storage, the public-key endpoint, libraries, uninstall** →
  [install-and-keys.md](install-and-keys.md)

## What it actually is (from source)

- One `hook_form_alter()` (`encrypted_login.module`) targeting `user_login_form`: adds hidden
  fields `encrypted_aes_key` and `encrypted_password`, attaches library `encrypted_login/encrypted_login`,
  `array_unshift`es the validator `encrypted_login_validate_encrypted_credentials` to run first, and
  sets `$form['pass']['#required'] = FALSE`.
- One route: `encrypted_login.get_aes_key` → `GET /encrypted_login/getPublicKey` →
  `EncryptedLoginController::getPublicKey()` (`src/Controller/EncryptedLoginController.php`),
  `_permission: 'access content'`, returns the RSA public key as JSON.
- One JS behavior (`js/encrypted_login.js`, `Drupal.behaviors.encryptedLogin`) using crypto-js and
  jsencrypt (both loaded from cdnjs via `encrypted_login.libraries.yml`) + `core/jquery`.
- Install/uninstall/update hooks in `encrypted_login.install`; RSA key pair kept in the State API.
