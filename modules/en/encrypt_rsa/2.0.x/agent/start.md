<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encrypt RSA (encrypt_rsa) — agent index

Provides **RSA (asymmetric) encryption method plugins for the Encrypt module**. Package `Encryption`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version-dir 2.0.x (installed release 2.0.0-beta1;
`security_advisory_coverage: not-covered`).

Dependencies (`encrypt_rsa.info.yml`): **`encrypt:encrypt`** and **`key_asymmetric:key_asymmetric`**.
Composer `require` (`composer.json`): `ext-openssl`, `phpseclib/phpseclib:^3`, `drupal/key_asymmetric:^1.2`
(`drupal/encrypt` is `require-dev`).

## What it actually is

- **Four `EncryptionMethod` plugins** (Encrypt's plugin type), in
  `src/Plugin/EncryptionMethod/`:
  - `public_rsa` — encrypt-only via phpseclib (`can_decrypt = FALSE`), key type `pem_public`.
  - `private_rsa` — encrypt + decrypt via phpseclib, key type `pem_private`.
  - `public_openssl_seal` — encrypt-only via `openssl_seal()` (AES256 envelope), key type `pem_public`.
  - `private_openssl_seal` — encrypt + decrypt via `openssl_seal()`/`openssl_open()`, key type `pem_private`.
  - Full mechanism, envelope format, decrypt behavior → [plugins/encryption-methods.md](plugins/encryption-methods.md)
- **Two `KeyType` plugins** (Key module's plugin type) + one abstract base, in `src/Plugin/KeyType/`:
  `pem_public` (`PemPublicFormatKeyType` extends `key_asymmetric` `AsymmetricPublicKeyType`) and
  `pem_private` (`PemPrivateFormatKeyType` extends `AsymmetricPrivateKeyType`), sharing key-size
  config from `PemFormatKeyTypeBase`. Config schema in `config/schema/encrypt_rsa.schema.yml`.
  Details → [plugins/key-types.md](plugins/key-types.md)
- **No** admin form/route, `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.install`,
  Drush commands, or config/install defaults. Only `hook_help()` in `encrypt_rsa.module`.

## How you operate it

- Generate an RSA key pair with the `openssl` CLI (the module refuses to generate keys — see key-types doc).
- Register the PEM key as a Key entity (`/admin/config/system/keys`) using `PEM Public key` or
  `PEM Private key` type.
- Create an Encryption Profile (`/admin/config/system/encryption/profiles`) that pairs one RSA method
  with the matching Key entity. Consume the profile via any Encrypt-based feature.
- Recommended pattern: upload only the **public** key and use a `public_*` method (encrypt-only);
  keep the private key in the separate environment that decrypts.
