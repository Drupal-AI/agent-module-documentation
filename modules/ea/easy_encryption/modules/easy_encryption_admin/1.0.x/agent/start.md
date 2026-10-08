<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Encryption Admin — agent index

Optional submodule of Easy Encryption. Adds a UI for **key transfer** (list / export / import) and
**private-key migration**. Requires `easy_encryption`. `configure` route = `easy_encryption_admin.keys`.
Defines one permission; no config schema, no Drush, no plugins.

- **The routes, the keys list, import/export, migrate private key** →
  [configure/key-transfer.md](configure/key-transfer.md)
- **Permission `administer easy encryption keys`** → [permissions/permissions.md](permissions/permissions.md)

Key facts: keys list at `/admin/config/system/easy-encryption/keys`
(route `easy_encryption_admin.keys`); import form `easy_encryption_admin.keys_import`; export
`easy_encryption_admin.keys_export`; private-key migration `easy_encryption_admin.migrate_private_key`.
All gated by permission `administer easy encryption keys` (restrict access). Built on the base
module's `KeyTransferInterface` and `PrivateKeyStorageMigrator`.
