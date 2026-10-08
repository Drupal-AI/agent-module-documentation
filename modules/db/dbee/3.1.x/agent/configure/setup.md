<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup, key and encryption profile

dbee is **self-configuring on install** — there is no settings form of its own; its
`configure` link goes to the **Encrypt profiles** list
(`entity.encryption_profile.collection`, `/admin/config/system/encryption/profiles`).

## What install creates (`_dbee_install_process()`)

1. **Key entity `dbee`** (`key.key.dbee`) — 256-bit / 32-byte AES key
   (`key_type: encryption`, `key_size: 256`). Storage is chosen automatically:
   - a **file** at `private://dbee.key` when `file_private_path` is set and writable
     (`key_provider: file`), otherwise
   - **config** (`key_provider: config`, base64) stored in the database.
2. **Encryption profile `dbee`** (`encrypt.profile.dbee`) — `encryption_method: real_aes`,
   `encryption_key: dbee`.
3. Widens `users_field_data.mail` and `.init` to `text` and drops the `user_field__mail`
   index (ciphertext is longer than an email and not directly matchable).
4. Batch-**encrypts all existing** emails (`dbee_update_crypt_all('encrypt')`).
5. Adds a `dbee` extra field to the `user.user.default` view display (encryption status on the
   account page).

The module's hook weight is set to `10` so it runs late for encrypt / early for decrypt.

## Managing / rotating the key and profile

Because dbee uses a normal Encrypt profile and Key, you manage them in the Encrypt/Key UIs (or
config). dbee watches those entities:

- Editing the **key** value, or changing the **profile's** method/key, makes dbee
  **re-encrypt** all stored emails. It reads the old data through a temporary `dbee_prev`
  profile/key, then re-encrypts with the new one (`hook_ENTITY_TYPE_update` for `key` /
  `encryption_profile`, and the config-import path).
- `dbee_current_key_id()` returns the key id the `dbee` profile currently uses (defaults to
  `dbee`).
- **Do not delete** the `dbee` key or profile while the module is enabled — without them the
  stored emails cannot be decrypted. dbee also guards `key`/`encryption_profile` access
  (`hook_ENTITY_TYPE_access`) for the `administer dbee` permission.

## Config import

dbee supports being enabled via config sync: if the import already provides the `dbee` key and
profile they are reused (not regenerated), otherwise they are created; emails are then
(re-)encrypted at the end of the import (`hook_config_import_steps_alter`).

## Status / verification

- **Status report** (`hook_requirements` runtime) shows whether all user emails are encrypted.
- **User account page** shows that user's encryption status (the `dbee` extra field).
- **Drush** verify commands — see [../drush/commands.md](../drush/commands.md).

## Uninstall

`dbee_uninstall()` decrypts every email back to plaintext and restores the columns, so removing
the module is lossless.
