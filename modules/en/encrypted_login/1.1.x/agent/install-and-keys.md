<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, RSA keys, endpoint, libraries

## Install / uninstall / update (`encrypted_login.install`)

- `hook_schema()` returns `[]` — the module defines no database tables (a legacy
  `encrypted_login_keys` table is gone).
- `encrypted_login_install()` generates an RSA key pair with
  `openssl_pkey_new(['private_key_bits' => 2048, 'private_key_type' => OPENSSL_KEYTYPE_RSA,
  'digest_alg' => 'sha256'])`, exports the private key (`openssl_pkey_export`) and reads the public
  key (`openssl_pkey_get_details`), then stores both in the **State API**:
  `encrypted_login.rsa_private_key` and `encrypted_login.rsa_public_key`. Failures throw and are
  logged to the `encrypted_login` channel. The pair is created once at install and is not rotated
  by the module.
- `encrypted_login_uninstall()` deletes both state keys.
- `encrypted_login_update_8001()` drops the obsolete `encrypted_login_keys` table if present.

## Public-key endpoint

- Route `encrypted_login.get_aes_key` (`encrypted_login.routing.yml`):
  `path: /encrypted_login/getPublicKey`, `_controller:
  \Drupal\encrypted_login\Controller\EncryptedLoginController::getPublicKey`,
  `_permission: 'access content'`.
- `EncryptedLoginController` (`src/Controller/EncryptedLoginController.php`) extends
  `ControllerBase`, injects `state` via `create()`. `getPublicKey()` returns
  `new JsonResponse(['public_key' => $public_key])`, or `['error' => 'RSA public key not found.']`
  with HTTP 500 when the state value is missing.

## Library (`encrypted_login.libraries.yml`)

Library `encrypted_login/encrypted_login` loads `js/encrypted_login.js` plus two CDN scripts —
`crypto-js 4.1.1` and `jsencrypt 2.3.1` from `cdnjs.cloudflare.com` — and depends on `core/jquery`.
It is attached only to the login form (see [login-flow.md](login-flow.md)).

## Operating notes

- Enable with `drush en encrypted_login` (or the UI); the install hook provisions the keys. No
  configuration follows — there is no settings form, permission, or config object.
- Requires the PHP OpenSSL extension server-side and a browser with the Web Crypto API client-side.
- To regenerate the RSA key pair, uninstall and reinstall the module (or clear/reset the two state
  keys), which invalidates any in-flight login page that already fetched the old public key.
