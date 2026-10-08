<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity UI Builder (entity_ui) — agent index

Adds configurable **tabs (local tasks) to content entities** of any type. Each tab is an
`entity_tab` **config entity** whose page is rendered by a pluggable **tab content plugin**.
Depends only on core **`field_ui`**. Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version-dir `8.x-1.x` (installed release `8.x-1.13`). No `composer.json`, no Drush.

## What it actually is

- Config entity **`entity_tab`** (`src/Entity/EntityTab.php`, config prefix `entity_tab`): keys
  `id, label, path, tab_title, page_title, target_entity_type, target_bundles, content_plugin,
  content_config, weight`. Admin CRUD under `/admin/structure/entity_ui/entity_tab/*`
  (admin_permission `administer all entity tabs`).
- Plugin type **`entity_ui_tab_content`** (`entity_ui.plugin_type.yml`, manager
  `plugin.manager.entity_ui_tab_content` = `EntityTabContentManager`, annotation
  `@EntityTabContent`, dir `src/Plugin/EntityTabContent/`). Shipped plugins: `entity_view`,
  `entity_form`, `owner_assign`, and `actions_configurable:*` derivatives.
- For every "target" content entity type (content group + has `canonical` link template —
  `TargetEntityTypes`), `hook_entity_type_build()` attaches a `TabRouteProvider` route provider
  and an `entity_ui_admin` handler; a `TabRouteProvider` route + a derived local task are
  generated per tab.
- Provides **permissions**: static `administer all entity tabs`, plus dynamic per-entity-type
  admin permissions and per-tab access permissions (`EntityUiPermissions`).

## Solution docs

- **Config entity, schema, admin UI routes & permissions** →
  [config/entity-tab.md](config/entity-tab.md)
- **Tab content plugin type + the four shipped plugins + writing your own** →
  [plugins/tab-content.md](plugins/tab-content.md)
- **How tab routes, local tasks and page access are generated at runtime** →
  [routing/generated-tabs.md](routing/generated-tabs.md)
