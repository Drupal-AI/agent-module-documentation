<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# KeyType plugins and config schema

Two Key-module `KeyType` plugins let admins register PEM RSA keys as Key entities, in
`src/Plugin/KeyType/`. Both extend the Key Asymmetric module's base types and inherit key-size
handling from the shared abstract base `PemFormatKeyTypeBase`.

## Plugins

- `PemPublicFormatKeyType` — `@KeyType(id = "pem_public", label = "PEM Public key", group = "encryption",
  key_value = { "plugin" = "textarea_field" })`, extends
  `Drupal\key_asymmetric\Plugin\KeyType\AsymmetricPublicKeyType`. Used by `public_rsa` and
  `public_openssl_seal`.
- `PemPrivateFormatKeyType` — `@KeyType(id = "pem_private", label = "PEM Private key", group = "encryption",
  key_value = { "plugin" = "textarea_field" })`, extends `AsymmetricPrivateKeyType`. Used by `private_rsa`
  and `private_openssl_seal`.
- Both class bodies are empty; behavior comes from the `key_asymmetric` parents plus the base below.

## PemFormatKeyTypeBase (abstract)

`abstract class PemFormatKeyTypeBase extends KeyTypeBase implements KeyPluginFormInterface`:
- `defaultConfiguration()`: `['key_size' => 2048]`.
- `buildConfigurationForm()`: a `key_size` select with options `2048`, `4096`, and `Other`; an
  `#states`-controlled `key_size_other_value` textfield collects a custom size when `Other` is chosen.
- `validateConfigurationForm()`: if `Other` was selected, moves `key_size_other_value` into `key_size`,
  unsets the helper field, and casts `key_size` to `(int)`.
- `submitConfigurationForm()`: `$this->setConfiguration($form_state->getValues())`.
- `generateKeyValue()`: **throws** `KeyException` — key generation is intentionally forbidden; generate
  keys with the `openssl` CLI instead (see README).
- `validateKeyValue()`: fetches key details via the abstract `getKeyDetails($key_value)`; errors if
  details/`bits` are missing, or if the declared `key_size` does not equal the key's actual `bits`
  ("The selected key size does not match the actual size of the key.").
- `abstract protected getKeyDetails($key_value)`: expected to return `openssl_pkey_get_details()`-shaped
  data (implemented by the `key_asymmetric` parent classes for public/private keys).

## Config schema

`config/schema/encrypt_rsa.schema.yml` defines two Key-type config schemas (both `type: key.type.encryption`):
- `key.type.pem_public` — label `Public .pem key type settings`, no extra mapping.
- `key.type.pem_private` — label `Private .pem key type settings`, adds a `passphrase` string mapping
  (`Key Passphrase`).

The module ships no `config/install/` defaults; all Key entities and Encryption Profiles are created by
the admin (or by tests under `tests/modules/`). `provides_config_schema: true`.
