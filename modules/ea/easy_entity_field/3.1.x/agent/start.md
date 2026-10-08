<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Entity Base Field (easy_entity_field) — agent index

**Adds base/bundle fields to a content entity type's base table through a Field UI-style admin interface — no code.**

- **Version:** 3.1.x (3.1.2)
- **Core:** ^11.2
- **Requires:** field_ui
- **Configure:** `easy_entity_field.settings_form` → `/admin/config/development/easy-entity-field`
- **Generated routes** (per enabled entity type, via `Routing\RouteSubscriber`): `entity.<type>.base_field[.add|.storage|.edit|.delete]`
- **Key services:** `easy_entity_field.settings`, `easy_entity_field.entity_update` (applies schema via definition update manager), `plugin.manager.easy_entity_field`
- **Config entity:** `easy_entity_field`; uninstall validator blocks removal while managed fields exist.

**Security:** Field creation/alteration is a schema/privilege-sensitive operation and is **admin-only**. Global route uses `administer easy entity field` (`restrict access: TRUE`); the generated per-type routes require dynamic `administer <entity_type> base fields` permissions, also `restrict access: TRUE` (`EasyEntityFieldPermissions::fieldPermissions`). No anonymous, low-privilege, or public mutating endpoints. See [configure/base-fields.md](configure/base-fields.md). No security findings.
