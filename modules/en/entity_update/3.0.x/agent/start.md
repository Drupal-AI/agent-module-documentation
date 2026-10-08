<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Update — agent index

Applies pending **entity type / field storage schema** updates, including on entity types that
already hold data (it backs the rows up, changes the schema, then recreates them).
Developer tool — back up the database first.

- **Drush: `entity:update` (upe) and `entity:check` (upec), every option** → [drush/commands.md](drush/commands.md)
- **Config (`entity_update.settings.excludes`) + admin routes** → [configure/settings.md](configure/settings.md)
- **Programmatic API: `EntityUpdate`, `EntityCheck`, the custom update manager** → [api/programmatic.md](api/programmatic.md)
- **Access: which permission gates the UI** → [permissions/permissions.md](permissions/permissions.md)

Key facts:

- `configure` route = **`entity_update.exec`** → `/admin/config/development/entity-update/exec/{action}`
  (`action` ∈ `default|basic|type|clean|rescue`).
- Only config object: **`entity_update.settings`** with a single `excludes` mapping
  (default `user: user`, `user_role: user_role`).
- Own DB table `entity_update` (serialized entity backup) created by `hook_schema()`.
- Service `entity_update.definition_update_manager` → `CustomEntityDefinitionUpdateManager`.
- No permissions of its own; everything requires core's `administer software updates`.
