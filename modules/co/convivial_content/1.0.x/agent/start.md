<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convivial Content (convivial_content) — agent index

Default-content importer for the Convivial (Morpht) distribution. Fetches YAML datasets from a
configurable **Source URL** and creates Drupal content (terms, media, blocks, nodes, paragraphs,
menus, block placements, site settings). No entities/permissions/plugins of its own.

- **Depends on:** `convivial_core` (provides the admin section + `access convivial administration pages` permission).
- **Package:** Convivial. **Core:** `^9.5 || ^10 || ^11 || ^12`. **License:** GPL-2.0-or-later.
- **Config object:** `convivial_content.settings` (single key `source_url`); schema in `config/schema/convivial_content.schema.yml`; default in `config/install/convivial_content.settings.yml`.
- **Configure route:** `convivial_content.settings` (info.yml `configure`).

## Routes (both require `_permission: access convivial administration pages`)
- `convivial_content.settings` — `/admin/config/convivial/content/settings` → `Form\SettingsForm` (set Source URL).
- `convivial_content.import` — `/admin/config/convivial/content` → `Form\ImportSettingsForm` (choose dataset / paste YAML, Site Clean Up checkbox, Import).

## Services (`convivial_content.services.yml`)
- `convivial_content.data_source_manager` → `DataSourceManager` — fetches + parses YAML over `@http_client` (`index.yaml`, dataset files, schema files).
- `convivial_content.site_cleanup_manager` → `SiteCleanupManager` — deletes existing entities by type/bundle before reimport.
- `convivial_content.data_importer` → `DataImporter` — the import pipeline (10 constructor deps).
- `ConvivialContentHooks` — `hook_help` (attribute `#[Hook('help')]`).

## Drush
- `convivial_content:import <dataset>` (alias `convivial_content-import`, `--cleanup=1`) → `Commands\ConvivialContentCommands` (registered via `drush.services.yml`).

## Solution docs
- [agent/config/settings.md](config/settings.md) — config object, routes, permissions, install/enable.
- [agent/api/importer.md](api/importer.md) — DataImporter / DataSourceManager / SiteCleanupManager pipeline, dataset & schema YAML shape, Drush.
