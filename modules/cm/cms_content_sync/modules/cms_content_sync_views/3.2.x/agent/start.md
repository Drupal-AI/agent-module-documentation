<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Views — agent index

Views integration for Content Sync's `cms_content_sync_entity_status` records. Adds Views
fields/filters + VBO actions so you can build sync-status listings. Requires
`dynamic_entity_reference` (DER) and `views`. No config form, permissions, Drush or plugin
types. Hard dependency of `cms_content_sync_health`.

## Views plugins (registered via `hook_views_data_alter`)
- **Fields** (`src/Plugin/views/field/`): `SyncState`, `PoolLabel`, `FlowLabel`,
  `EntityTypeLabel`, `ParentEntity`, `RenderedFlags`.
- **Filters** (`src/Plugin/views/filter/`): `SyncState`, `EntityType`, `Flags`, `Flow`, `Pool`.

## Bulk action config entities (`config/install/system.action.*`)
- `export_status_entity` — label **"Force Push"** (plugin `export_status_entity` →
  `PushStatusEntity`).
- `import_status_entity` — pull (plugin `import_status_entity` → `PullStatusEntity`).
- `reset_status_entity` — reset (plugin `reset_status_entity` → `ResetStatusEntity`).
All three have `type: cms_content_sync_entity_status`.

## DER base field
`hook_entity_base_field_info` adds a dynamic entity reference on the status entity, populated
by `entity_create/insert/update` hooks (`cms_content_sync_views.module`), so Views can join to
the referenced entity of any type.
