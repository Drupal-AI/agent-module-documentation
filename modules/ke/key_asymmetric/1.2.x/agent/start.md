<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asymmetric Keys — agent index

Extends the **Key** module with two `KeyType` plugins for public/private key material, validated
by **phpseclib**. No configure route (`configure: null`), no permissions of its own (Key provides
the admin UI/permissions), no Drush. Requires `key` + the `phpseclib/phpseclib` library.

| KeyType id | Label | Stores |
|---|---|---|
| `asymmetric_private` | Private key | Any private key; metadata extracted on validation |
| `asymmetric_public` | Public key/certificate | Public key or X.509 cert; has a `private_key` reference setting |

- **The two key types: creating Key entities, settings/metadata, validation, `private_key` ref** →
  [plugins/key-types.md](plugins/key-types.md)
- **`key_asymmetric.key_pair` service (`getKeyProperties`), filtering keys, extending the types** →
  [api/keypair.md](api/keypair.md)

Key facts:
- Keys are stored as core Key module `key` config entities with `key_type: asymmetric_private` /
  `asymmetric_public`. Metadata (format, algo, key_size, hash_algo, fingerprint, cert subject/…)
  lives in the key's `key_type_settings`.
- Validation uses phpseclib; a **Skip key validation** checkbox stores the value without metadata;
  a **passphrase** (never stored) validates password-protected private keys.
- The module never reformats values and cannot generate keys (`generateKeyValue()` throws).
