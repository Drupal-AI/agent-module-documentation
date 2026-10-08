<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Inherit (entity_inherit) — agent index

**Entities inherit field values from a configured 'parent' entity; parent edits propagate to children (and new parents fill empty child fields) on every save.**

- **Version:** 5.0.x — `php: 8.x`
- **Core:** ^10 || ^11
- **Configure route:** `entity_inherit.admin_settings_form` → `/admin/config/entity_inherit` (permission `access administration pages`)
- **Service:** `entity_inherit` (`EntityInherit`); plugin manager `plugin.manager.entity_inherit` (`EntityInheritPlugin` type).
- **Trigger:** `hook_entity_presave()` → `EntityInherit::hookPresave()`; propagation via `EntityInheritQueue` batch/no-batch processors; anti-infinite-loop utility per save.
- **Propagation:** runs in the presave path and saves related child/parent entities directly (see README "Note about permissions"). Restrict which fields are parent fields and who can edit parent entities. Admin route uses the `access administration pages` permission.

See [configure/inheritance.md](configure/inheritance.md).