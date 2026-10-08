<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# b24_user — user↔contact sync, batch export/import & config

## Live export (`b24_user.module`)

- `b24_user_is_exported($user)` returns the intersection of the user's roles with
  `b24_user.settings.exported_roles`, or `[]` when `enabled` is off — the gate for all three hooks.
- `hook_user_insert` → `UserManager::getValues($user)` → `RestManager::addContact()`; on success
  `ReferenceManager::addReference($uid, 'user', $ext_id, 'contact', $hash)`.
- `hook_user_update` → loads the reference; rebuilds fields; pushes `updateContact()` **only when
  `getHash($fields) !== reference['hash']`**, then `updateHash()`.
- `hook_user_delete` → `deleteContact(reference ext_id)`.

## `UserManager` (`src/Service/UserManager.php`)

- `getValues(User $user, ?int $id = NULL)` — `array_filter(b24_user.mapping.contact)`, token-replace
  each value with `['user' => $user]`, `- Not set -` for empty required, `crm_multifield` wrapping
  (carrying the existing item id when `$id` given).
- `processUser($id, $update=FALSE)` — batch-export worker: skips users already referenced unless
  `$update`; add vs update contact accordingly; maintains the reference + hash.
- `importUser(array $data)` — batch-import worker. Finds an existing user by `mail`
  (`reset($data['EMAIL'])['VALUE']`) or by a prior `b24_reference` (join to `users`); if none and an
  email exists, `User::create(['name'=>$data['NAME'],'mail'=>…,'roles'=>$data['roles'],'status'=>1])`,
  saves, and records the reference. Contacts without an email are skipped.

## Forms & routes (permission `administer b24 configuration`)

| Route | Path | Purpose |
|-------|------|---------|
| `b24_user.settings_form` | `/admin/config/b24/user` | `SettingsForm` — `enabled`, `exported_roles` (anonymous excluded) |
| `b24_user.mapping_form` | `/admin/config/b24/user/mapping` | `MappingForm` — contact field mapping via `FormHelper::getMappingFields` |
| `b24_user.user_export_batch_form` | `/admin/config/b24/user/export_users` | `UserExportBatchForm` |
| `b24_user.user_import_batch_form` | `/admin/config/b24/user/import_users` | `UserImportBatchForm` (also `administer users`) |

- `MappingForm::submitForm` writes `b24_user.mapping` (`contact.<field>`) and stores field
  definitions in `b24_user.field_types`.
- `UserExportBatchForm` — queries active users (role-filtered unless `authenticated` is selected),
  runs `UserManager::processUser()` in a Batch (50/op).
- `UserImportBatchForm` — saves selected `roles` to `b24_user.import`, fetches `getList('contact',
  select ID/NAME/EMAIL)`, **sets `b24_user.settings.enabled = 0` for the run** and restores it in the
  finish callback, and calls `UserManager::importUser()` per contact.

## Config schema (`config/schema/b24_user.schema.yml`)

`b24_user.settings` (`enabled` int, `exported_roles` seq), `b24_user.import` (`roles` seq),
`b24_user.field_types` (`definition` seq), `b24_user.mapping` (`contact` seq of strings).
