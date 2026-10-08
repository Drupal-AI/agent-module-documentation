<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Import (entity_import) — agent index

Admin UI framework that builds **core Migrate** migrations from configuration to import content entities
from **CSV** uploads. Each importer + bundle becomes a derived migration `entity_import:<importer>:<bundle>`.
Package `Migration`. Depends on core **`migrate`** + `league/csv ^9.27`. Core `^10 || ^11`. Version 8.x-1.0-alpha8.
Ships submodule **`entity_import_plus`** (extra process plugins built on `migrate_plus`).

- **Install, config entities, routes, permissions, config objects/schema, operating flow** →
  [config/settings.md](config/settings.md)
- **Source plugins (CSV upload, base, limit iterator) and how source config is stored** →
  [plugins/sources.md](plugins/sources.md)
- **Migrate process plugins this module adds (explode, extract, callback, migrate lookup, …)** →
  [plugins/processes.md](plugins/processes.md)
- **Architecture: services, config entities, migration deriver, events, param converter** →
  [api/architecture.md](api/architecture.md)

## What it actually is

- Three config entity types (all `admin_permission = "administer entity import"`):
  - `entity_importer` (config_prefix `type`) — `src/Entity/EntityImporter.php`. Holds source plugin +
    entity type/bundles + migration dependencies; assembles a migrate definition on the fly.
  - `entity_importer_field_mapping` (config_prefix `field_mapping`) — maps a CSV source name to a field
    destination and a chain of process plugins.
  - Per-importer options object `entity_import.options.<id>` stores the **unique identifiers** (migration IDs).
- One migrate **source** plugin: `entity_import_csv` (`EntityImportSourceCSV`), plus abstract bases.
- Ten migrate **process** plugins (`entity_import_*`) — see plugins/processes.md.
- Migrate deriver `EntityImporterMigrateDeriver` turns each importer/bundle into a discoverable migration.
- Services: `entity_import.source.manager`, `entity_import.process.manager`, `entity_import.entity_properties`,
  a POST_IMPORT subscriber (`EntityImportSubscriber`, cleans up uploaded files), and a `migration` param converter.

## Routes (all `_permission: administer entity import`)

- `entity_import.importer.pages` — `/admin/content/importer-pages` (list of exposed importers).
- `entity_import.importer.page.import_form` — `/admin/content/entity-importer/{entity_importer}` (upload + run).
- `.status_form` `/…/{entity_importer}/status`, `.action_form` `/…/action` (rollback), `.log_form` `/…/log`,
  `.log_delete_form` `/…/log/{migration}/delete`, `entity_import.download_template` `/…/download-template`.
- Importer CRUD under `/admin/config/system/entity-importer` (config entity route provider); configure link
  `entity.entity_importer.collection`.

## Notes

- Unused permissions `manage entity import page`, `manage entity import mapping`, `entity import content` are
  declared in `entity_import.permissions.yml` but referenced nowhere — everything is gated by
  `administer entity import`.
- `update_8101`–`8103` (`entity_import.install`) migrate legacy config keys (`display_page`→`expose_importer`,
  `source`→`migration_source.source`, `entity`→`migration_entity.entity`, and options rename).
