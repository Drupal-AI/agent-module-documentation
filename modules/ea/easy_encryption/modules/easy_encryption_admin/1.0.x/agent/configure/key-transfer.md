<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key transfer & private-key migration (the admin UI)

All pages are gated by the `administer easy encryption keys` permission and are admin routes.

## Routes

| Route | Path | What |
|---|---|---|
| `easy_encryption_admin.keys` | `/admin/config/system/easy-encryption/keys` | Keys list (the `configure` route) — controller `EncryptionKeysController::list` |
| `easy_encryption_admin.keys_export` | `/admin/config/system/easy-encryption/keys/{encryption_key_id}/export` | Export a key (`::export`, streamed download) |
| `easy_encryption_admin.keys_import` | `/admin/config/system/easy-encryption/keys/import` | Import form `ImportEncryptionKeyForm` |
| `easy_encryption_admin.migrate_private_key` | `/admin/config/system/easy-encryption/migrate-private-key` | `PrivateKeyStorageMigratorForm` (custom access: only when migration is needed) |

Menu link under `system.admin_config_system`; "Import encryption key" action link on the keys page.

## Keys list

`EncryptionKeysController::list()` shows each known encryption key id (from
`KeyRegistryInterface::listKnownKeyIds()`) with a **usage count** (from
`KeyUsageTrackerInterface::getKeyUsageMapping()`) and an **Export** operation. If the private key is
in the database it shows a warning linking to the migrate page.

## Export / import (key transfer)

- **Export** streams a portable package for one encryption key id (uses the base module's
  `KeyTransferInterface::exportKey()`), so you can move it to another site/environment.
- **Import** (`ImportEncryptionKeyForm`) accepts that package (`KeyTransferInterface::importKey()`)
  and can optionally activate the imported key.

Typical flow: export the key id on the source site → import the package on the target site
(optionally activate) → deploy config containing the encrypted Key entities; the target can now
decrypt them.

## Migrate private key

`PrivateKeyStorageMigratorForm` moves the active private key from database/State to the filesystem
(same operation as `drush easy-encryption:migrate-private-key`). The route's custom access check
(`PrivateKeyStorageMigratorAccessCheck`) only allows it when migration is actually needed.
