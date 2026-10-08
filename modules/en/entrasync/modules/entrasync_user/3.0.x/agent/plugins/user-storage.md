<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UserStorage plugin (`user`)

Source: `modules/entrasync_user/src/Plugin/EntraSyncStorage/UserStorage.php` (extends
`Drupal\entrasync\Plugin\StorageBase`). Enabled by the `entrasync_user` submodule.

Plugin definition: `@EntraSyncStoragePlugin(id="user", label="User", drupal_entity_type="user")`.
It injects `current_user` in addition to the base plugin's services (entra_sync, event_dispatcher,
password_generator, entity_type.bundle.info). `useGenericEntityMethods()` returns TRUE, so it reuses
the base generic field/label/status/revision helpers.

## Config sub-form (`buildForm()` / `submitForm()`)

Rendered inside the EntraSync add/edit form under a "Drupal user configuration" details element:

- **Username mapping** (`generic_entity_label_mapping`) — Entra property used as the username
  (default `mail`; must be unique, e.g. mail or UPN).
- **Field mapping** — base `buildGenericMappingForm()` over custom `field_*` user fields.
- **Modify roles on Entra users** (`modify_entrauser_roles`, multiselect) — roles added to imported
  accounts. The option list comes from `getUserRoles()`: anonymous/authenticated are removed, and
  **admin roles are shown only if the current user has `administer permissions`** (mirrors core's
  user role-field access). On submit, admin roles the editor could not see (`getHiddenAdminRoleIds()`)
  are merged back so a lesser-privileged editor cannot silently drop them.
- **State of user** (`generic_entity_status`) — Active (1) / Blocked (0), default 0/blocked.
- **Send activation e-mail** (`send_mail_on_activate`) — visible only when state is Active.

## Provisioning / update (`processItem(array $data, SyncEntity)`)

Runs from the base `entrasync_user_processor` queue worker per user:

1. `entra_enabled = ($data['user']['accountEnabled'] === TRUE)`. If the user is not enabled in Entra
   and not already managed (`EntraSync::getManagedEntity()`), it is skipped.
2. If `mail` is empty, the user is skipped with a warning (an account cannot be created without it).
3. Match by e-mail with `user_load_by_mail()`. If found, reuse it; otherwise `User::create()` with a
   generated password (`passwordGenerator->generate()`), `enforceIsNew()`, e-mail set, and username
   from the mapped property (falling back to mail).
4. Apply mapped fields (`processGenericEntityMapping()`) and status (`processGenericEntityStatus()` —
   forces blocked when the Entra account is disabled, else the configured default).
5. Add each configured role not already held (**additive only**; unselecting a role never strips it
   from a previously synced account, and roles are not derived from Entra data).
6. If the user is new and `send_mail_on_activate` is set, send `_user_mail_notify('register_admin_created', $user)`.
7. Dispatch `EntraEntityPreSave`, `save()`, then `EntraSync::updateManagedEntityRecord()` to upsert the
   Entra-GUID ↔ user-id mapping. Exceptions are logged and rethrown so the queue can retry.

Roles come only from the admin-set `modify_entrauser_roles` config, gated behind `administer
permissions` for admin roles — the assigned roles are not influenced by Entra property values.
