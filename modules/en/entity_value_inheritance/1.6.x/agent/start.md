<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Value Inheritance (entity_value_inheritance) — agent index

**Maps a source entity's field to destination entities that reference it and keeps them in sync via pluggable strategies.**

- **Version:** 1.6.x
- **Core:** ^10 || ^11
- **Dependencies:** action, entity
- **Config entity:** `inheritance` (managed at `/admin/structure/inheritance`).
- **Permission:** `administer inheritance` (gates collection, add/edit/delete and `inheritance.settings`).
- **Services:** `entity_value_inheritance.updater`, `entity_value_inheritance.helper`, `plugin.manager.entity_value_inheritance_updater`.
- **Strategies (updater plugins):** update, overwrite, override, override_role_visibility, disable.
- **Events:** InheritancePreUpdate / PostUpdate / AlterField / AlterUpdateList / SaveEntity.

**Security:** all admin routes gated by `administer inheritance`.

See [configure/inheritance.md](configure/inheritance.md) and [extend/plugins.md](extend/plugins.md).
