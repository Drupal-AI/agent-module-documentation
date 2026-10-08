<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Encryption — agent index

Zero-config at-rest encryption for credentials, built on the **Key** module. Adds an
`easy_encrypted` Key provider and auto-generates a libsodium key pair on install. Requires `key` +
`paragonie/sodium_compat`. No `configure` route of its own (see the Admin submodule). Config schema +
Drush; **no permissions in the base module** (they live in `easy_encryption_admin`).

- **The `easy_encrypted` provider, auto-upgrade of insecure providers, `easy_encryption.keys`
  config, settings.php options** → [configure/keys-and-providers.md](configure/keys-and-providers.md)
- **Public API: `EncryptorInterface` + key management services (generator/activator/rotator/
  pruner/usage/registry/transfer)** → [api/encryptor-and-services.md](api/encryptor-and-services.md)
- **Drush: `easy-encryption:rotate`, `easy-encryption:migrate-private-key`** →
  [drush/commands.md](drush/commands.md)
- **Extension points (tagged services, swapping the encryptor, ConfigAction)** →
  [extend/extension-points.md](extend/extension-points.md)

Key facts: active key id is in `easy_encryption.keys` (`active_encryption_key_id` +
`encryption_keys[]`). Each key pair = two Key entities `easy_encrypted__<id>__public_key` (config
provider, encrypt) and `easy_encrypted__<id>__private_key` (file provider, decrypt). Creating a Key
with an insecure provider (`config`/`state`) auto-upgrades it to `easy_encrypted`. Submodule
`easy_encryption_admin` adds the key-transfer UI.
