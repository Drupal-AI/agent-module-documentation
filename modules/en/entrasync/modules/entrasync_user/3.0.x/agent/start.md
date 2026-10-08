<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntraSync User Storage (entrasync_user) — agent index

Submodule of **entrasync**. Provides the `user` **EntraSyncStorage** plugin: turns each distilled
Microsoft Entra user into a **Drupal user account**. Package `Custom`. Version **3.0.0-beta2**
(pre-release). Core `^10 || ^11`. License GPL-2.0-or-later.

- **The user storage plugin: form fields, provisioning/update logic, role handling** →
  [plugins/user-storage.md](plugins/user-storage.md)

## Dependencies

- Requires `entrasync` (`drupal:entrasync`), which supplies the plugin type, the sync service, the
  queue worker and the Graph fetch. No config schema, permissions, or Drush of its own.

## What it provides

- One plugin: `UserStorage` (id **`user`**, label *User*, `drupal_entity_type = "user"`) in
  `modules/entrasync_user/src/Plugin/EntraSyncStorage/UserStorage.php`, extending
  `Drupal\entrasync\Plugin\StorageBase`.
- Adds the plugin sub-form on the EntraSync add/edit form: username mapping, generic field mapping,
  role selector (`modify_entrauser_roles`), active/blocked state, and the activation-email checkbox.
- `processItem()` runs from the base module's `entrasync_user_processor` queue worker to create or
  update the account.

No routes, permissions, hooks or services beyond the plugin.
