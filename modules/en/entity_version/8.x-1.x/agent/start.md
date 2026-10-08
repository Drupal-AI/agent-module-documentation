<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Version (entity_version) — agent index

Provides an **`entity_version` field type** that stores a structured **major.minor.patch** version
number (three unsigned-int columns) on content entities, plus a widget, a formatter, a per-bundle
"main field" config entity, and an installer service. Core requirement `^10 || ^11`. PHP `>=8.1`.
License GPL-2.0-or-later. Version 8.x-1.5. No non-core dependencies.

- **The field type, widget, formatter, and the `increase()`/`decrease()`/`reset()` API** →
  [fields/field-type.md](fields/field-type.md)
- **The settings config entity, the settings form, and the installer service** →
  [config/settings.md](config/settings.md)

## What it provides (from source)

- **Field type** `EntityVersionItem` (id `entity_version`, `src/Plugin/Field/FieldType/EntityVersionItem.php`),
  columns `major`/`minor`/`patch` (`int`, unsigned); default `0.0.0`; `isEmpty()` true if any part is
  empty; methods `increase()`, `decrease()` (floored at 0), `reset()` per category.
- **Widget** `EntityVersionWidget` (id `entity_version`) — three `#type => number` inputs in a details
  element.
- **Formatter** `EntityVersionFormatter` (id `entity_version`, label "Version") — joins parts down to a
  `minimum_category` setting (`major`/`minor`/`patch`), rendered as `#markup` (integers only).
- **Config entity** `entity_version_settings` (`EntityVersionSettings`, config prefix
  `entity_version.settings`) mapping `{entity_type}.{bundle}` → the "main" `target_field`; storage
  handler `EntityVersionSettingsStorage` rebuilds routes + entity-type cache on save.
- **Settings form** `EntityVersionSettingsForm` at `/admin/config/entity-version/settings`
  (route `entity_version.settings`, permission **`administer entity version`**).
- **Service** `entity_version.entity_version_installer` (`EntityVersionInstaller`) — programmatically
  creates the field storage + per-bundle field.
- **Permission**: `administer entity version`. **Config schema**: yes. **Drush**: none.
  **Hooks**: `hook_uninstall` (deletes all settings config); update `entity_version_update_8101`.

## Routes

- `entity_version.index` → `/admin/config/entity-version` (`access administration pages`).
- `entity_version.settings` → `/admin/config/entity-version/settings` (`administer entity version`).

## Sub-modules (own doc trees)

- `entity_version_history` → [modules/entity_version_history/8.x-1.x](../../modules/entity_version_history/8.x-1.x/agent/start.md) — per-entity "History" tab of distinct versions across revisions.
- `entity_version_workflows` → [modules/entity_version_workflows/8.x-1.x](../../modules/entity_version_workflows/8.x-1.x/agent/start.md) — bump/reset versions on Content Moderation transitions.
- `entity_version_workflows_example` → [modules/entity_version_workflows_example/8.x-1.x](../../modules/entity_version_workflows_example/8.x-1.x/agent/start.md) — demo content type + workflow.
