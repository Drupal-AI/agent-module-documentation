<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Encryption provides zero-configuration at-rest encryption for sensitive credentials via the Key module: it adds an "Easy Encrypted" key provider and, on install, auto-generates a libsodium key pair, so API keys and passwords are stored as ciphertext you can safely export.

---

On install the module generates and activates a libsodium sealed-box key pair and records the active encryption key id in `easy_encryption.keys` config; each key pair is stored as two Key entities (`easy_encrypted__<id>__public_key`, used to encrypt, and `…__private_key`, used to decrypt). It registers an `easy_encrypted` Key provider that encrypts a key's value before storing it and keeps the encryption key id alongside the ciphertext, so encrypted config is exportable and version-controllable. A `key_presave` hook transparently upgrades **new** Key entities that use insecure providers (`config`, `state` by default, configurable via `settings.php`) to `easy_encrypted`, so credentials created by recipes or automation are never written in plaintext; `easy_encrypted` is also offered as the default provider on the key add form. The default private key is stored in a `.easy_encryption` directory next to the web root (0600, PHP-wrapped) and falls back to Drupal State; a status-report requirement runs a self-test and warns if the private key sits in the database. Public APIs are designed around encryption keys and key ids (interface `EncryptorInterface` with `encrypt`/`decrypt`/`selfTest`, plus key generator/activator/rotator/pruner/usage-tracker/registry and a key-transfer service), and the crypto backend is swappable. Drush commands rotate the active key (`easy-encryption:rotate`) and migrate the private key to the filesystem (`easy-encryption:migrate-private-key`). It requires the Key module and `paragonie/sodium_compat`, and an uninstall validator plus `key_access` hook protect active/in-use key material. The optional **Easy Encryption Admin** submodule adds a UI for importing/exporting keys (key transfer) and migrating the private key.

---

- Encrypt an API key or password at rest by creating a Key with the "Easy Encrypted" provider.
- Store sensitive credentials as ciphertext that is safe to export to YAML and commit.
- Automatically secure credentials created by recipes/automation (config/state auto-upgraded).
- Get working encryption with zero configuration immediately after install.
- Decrypt a credential in code via the Key module's normal `getKeyValue()`.
- Rotate the active encryption key with `drush easy-encryption:rotate`.
- Re-encrypt all Easy Encrypted keys to a new key with `--reencrypt`.
- Preview a key rotation without changing anything using `--dry-run`.
- Move the private key from the database to the filesystem with `easy-encryption:migrate-private-key`.
- Run an encryption self-test from the Status report page.
- Support encrypt-only environments (public key present, private key withheld).
- Transfer an encryption key to another site/environment via the Admin UI import/export.
- Keep the private key outside the web root and out of version control by default.
- Change the private key storage directory via `$settings['easy_encryption']['private_key_directory']`.
- Configure which insecure providers get auto-upgraded via `settings.php`.
- Prevent accidental uninstall while encrypted keys still exist (uninstall validator).
- Protect the active key pair's Key entities from deletion (key_access hook).
- Swap the cryptography backend by overriding the EncryptorInterface service.
- Set up encryption idempotently in recipes via the `ensureEasyEncryptionSetup` config action.
- Track which Key entities reference an encryption key (usage tracker) before rotating/pruning.
- Store AI/VDB provider credentials securely (the module's original motivation).
- Encrypt database or SMTP passwords referenced through Key entities.
- Prune unused key pairs during maintenance.
- Verify the active key pair can both encrypt and decrypt in the current environment.
- Give teams a portable, exportable encrypted-credential workflow across environments.
