<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_user (b24_user) — agent index

Submodule of **[b24](../../../../agent/start.md)**. Two-way sync of Drupal **users** ↔
Bitrix24 **contacts**. Depends on `b24`. Package `bitrix24`. Configure route
`b24_user.settings_form`. All routes require `administer b24 configuration` (import also
`administer users`).

## What it provides

- **Live sync** (`b24_user.module`) — `hook_user_insert/update/delete` gated by
  `b24_user_is_exported()` (checks `b24_user.settings.enabled` + role intersection with
  `exported_roles`); calls `RestManager::addContact/updateContact/deleteContact` and records/updates
  a `b24_reference` (bundle `user`, ext_type `contact`), hash-guarded on update.
- **Service `b24_user.manager`** (`src/Service/UserManager.php`) — `getValues($user, $id?)` maps
  `b24_user.mapping.contact` fields with `user` token replacement (`crm_multifield` handling);
  `processUser()` (used by batch export); `importUser($data)` creates a Drupal user from a Bitrix24
  contact (matched by email or the reference table), assigning `roles`.
- **Service `b24_user.event_subscriber`** (`src/EventSubscriber/B24UserEventSubscriber.php`) —
  listens to `b24_commerce.entity.insert`; when b24_commerce creates a `contact`, adds the
  Drupal-user↔contact reference.
- **Forms** — `SettingsForm` (`/admin/config/b24/user`: `enabled`, `exported_roles`),
  `MappingForm` (`/admin/config/b24/user/mapping`: contact field mapping via `FormHelper`),
  `UserExportBatchForm` (`/admin/config/b24/user/export_users`),
  `UserImportBatchForm` (`/admin/config/b24/user/import_users`, pauses live export during the run).
- **Config schema** (`config/schema/b24_user.schema.yml`): `b24_user.settings` (`enabled`,
  `exported_roles`), `b24_user.import` (`roles`), `b24_user.field_types`, `b24_user.mapping`.
  Install default `b24_user.settings`: `enabled: true`, `exported_roles: []`.
- **Update hooks** `b24_user_update_20001/20002` restructure the mapping/field_types config.

## Solution docs

- [sync.md](sync.md) — live sync, batch export/import, mapping & config.
