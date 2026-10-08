<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Encryption Admin adds a UI for Easy Encryption: list encryption keys, export/import them (key transfer) between sites, and migrate the private key from the database to the filesystem.

---

This optional submodule of Easy Encryption exposes the module's key-transfer and private-key-migration features in the admin UI, so those tasks are no longer Drush-only. It provides a keys listing page (`/admin/config/system/easy-encryption/keys`) that shows each known encryption key id with a usage count and Export operations, an import form, and a private-key migration form. Export streams a portable key package (via the base module's `KeyTransferInterface`) so you can move an encryption key to another environment or site; import accepts that package and optionally activates the imported key. The migrate page moves the active private key from database/State storage to the filesystem (guarded by a custom access check that only allows it when migration is actually needed). All routes are gated by a single permission, `administer easy encryption keys` (marked restrict access), and the module adds a menu link under System configuration plus an "Import encryption key" action link. It depends on the Easy Encryption base module and defines its `configure` route as the keys list. It has no configuration/settings of its own beyond these operations.

---

- Move an encryption key to another environment via the UI instead of Drush.
- Export an encryption key as a portable package for backup or transfer.
- Import an encryption key package on a target site and optionally activate it.
- View all known encryption key ids and how many Key entities use each.
- Migrate the private key from the database to the filesystem in the UI.
- Give a security admin a single page to manage Easy Encryption keys.
- Restrict key management to trusted users via `administer easy encryption keys`.
- Set up a new environment by importing the encryption key that decrypts your config.
- Support encrypt-only → decrypt workflows by transferring keys between sites.
- Reach the keys UI from the System configuration menu.
- Add a key via the "Import encryption key" action link on the keys page.
- Recover from an insecure private-key-in-database warning by migrating it.
- Audit which encryption keys are still in use before pruning or rotating.
- Provide non-CLI operators a way to perform key transfer.
- Keep key transfer operations permission-gated and access-controlled.
- Export the active key before rotating so you can restore if needed.
- Distribute a shared encryption key to multiple sites in a fleet.
- Complement Drush `ee:rotate` / `ee:migrate-private-key` with a UI equivalent.
- Confirm the private key location and fix it from the browser.
- Onboard a teammate to key management without shell access.
