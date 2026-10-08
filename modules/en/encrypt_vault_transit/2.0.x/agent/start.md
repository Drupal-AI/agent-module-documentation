<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encrypt - Vault Transit (encrypt_vault_transit) — agent index

Plugs the **Encrypt** module into **HashiCorp Vault's Transit** secrets engine (encryption-as-a-service):
encrypt/decrypt happen by calling Vault, and the key stays in Vault. Package **Security**.
Core `^9.3 || ^10 || ^11`, PHP `^8.1`. License GPL-2.0-or-later. Version-dir 2.0.x (release 2.0.0).

Depends on three contrib modules: **`encrypt`** (`^3.0`), **`key`** (`^1`), **`vault`** (`^2 || ^3`).
It contributes **no** routing, permission, service, hook, `.install`, or config file — only three plugin
classes. The Vault address, TLS, and auth token all come from the **Vault** module; this module just
uses Vault's client (`vault.vault_client_no_lease_storage`).

- **The encryption method — encrypt/decrypt via Vault Transit, the Vault client, error handling** →
  [plugins/encryption-method.md](plugins/encryption-method.md)
- **The Key module KeyType + KeyInput (naming the transit key) and how it's all configured** →
  [plugins/key-integration.md](plugins/key-integration.md)

## What it actually is (from source)

- One Encrypt plugin: `VaultTransitEncryptionMethod` (id **`vault_transit`**, title *"Vault Transit"*,
  `key_type = {"vault_transit"}`), in `src/Plugin/EncryptionMethod/VaultTransitEncryptionMethod.php`,
  extending `Drupal\encrypt\Plugin\EncryptionMethod\EncryptionMethodBase`.
- One Key `KeyType`: `VaultTransitKeyType` (id **`vault_transit`**, group `encryption`, key_value plugin
  `vault_transit_key`), in `src/Plugin/KeyType/VaultTransitKeyType.php` — extends `KeyTypeBase`;
  `generateKeyValue()` returns `''`, `validateKeyValue()` is a no-op.
- One Key `KeyInput`: `VaultTransitKeyInput` (id **`vault_transit_key`**), in
  `src/Plugin/KeyInput/VaultTransitKeyInput.php` — extends `key`'s `TextFieldKeyInput`; a plain text
  field whose label/description become "Vault Transit Key" (the transit key **name**).
- No admin UI of its own: **no** `*.routing.yml`, `*.permissions.yml`, `*.services.yml`,
  `*.links.*.yml`, `*.module`, `*.install`, or `config/`. `configure` is null.

## Mechanism (one line)

`encrypt($text,$key)` → `vaultClient->write("/transit/encrypt/$key", ['name'=>$key,'plaintext'=>base64_encode($text)])`
returns `ciphertext`; `decrypt($text,$key)` → `.../transit/decrypt/$key` with `ciphertext`, returns
`base64_decode(plaintext)`. Failures throw `EncryptException`. Details in
[plugins/encryption-method.md](plugins/encryption-method.md).
