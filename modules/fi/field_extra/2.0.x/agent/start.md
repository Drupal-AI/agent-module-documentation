<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field extra (field_extra) — agent index

**Authors can mark selected field values private; the values are hidden from non-owners and enforced server-side.**

- **Version:** 2.0.x · **Core:** ^9 || ^10 || ^11 · **Package:** Field
- **Configure:** `field_extra.private_settings` → `/admin/config/content/private-settings` (`field extra manage private field settings`)
- **List:** `field_extra.private_fields` → `/admin/config/content/private-settings/fields`
- **Permissions:** `field extra manage private field settings`, `field extra access private fields` (+ per-entity-type variants via `FieldExtraPermissions::permissions`)
- **Service:** `field_extra.manager` (`isPrivate()`, `add()`, `delete()` on table `field_extra_value`)
- **Enforcement:** `field_extra_entity_field_access()` → `AccessResult::forbidden()` on `view` for private, non-owner, non-bypass
- **Extend:** `hook_field_extra_private_alter()`; Drush `FieldExtraCommands`

**Security:** Access is enforced server-side in `hook_entity_field_access` (view forbidden for non-owners without bypass), not merely hidden in the UI. Admin routes are permission-gated. Owner check uses `EntityOwnerInterface::getOwnerId()`.

See [configure/private-fields.md](configure/private-fields.md).
