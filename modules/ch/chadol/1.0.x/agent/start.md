<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chado Light (chadol) — agent index

Maps tables of a **Chado** PostgreSQL schema (a standard biological/genomics data schema) to Drupal
**External Entities** via one SQL storage-client plugin — no data sync, point-and-click mapping.
Package `Tripal`. Version **1.0.0-beta4**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Dependencies

- `external_entities:external_entities` (>=3.0.0-beta4), `external_entities:xnttsql`,
  `dbxschema:dbxschema_pgsql`. Composer: `drupal/external_entities:^3.0@beta4`.
- Runtime: a PostgreSQL connection in `settings.php` `$databases` holding a Chado schema (same DB as
  Drupal, or a separate one whose credentials you add).

## What it provides (from source)

- **Storage client plugin** `xnttchado` — `src/Plugin/ExternalEntities/StorageClient/Chado.php`
  (class `Chado extends \Drupal\xnttsql\...\Database`). The whole module. Introspects a Chado schema,
  builds read SQL + field mappings + filters for an external entity type.
  → [plugins/storage-client.md](plugins/storage-client.md)
- **Config schema** `config/schema/chadol.storage_client.schema.yml` — the `chado_config` mapping
  (datatype, fields, joins) added onto the xnttsql client config. (Details in the plugin doc.)
- **Two admin forms + one JSON controller + module helper functions + 3 permissions.**
  → [config/admin-and-routes.md](config/admin-and-routes.md)

## Routes (chadol.routing.yml)

- `chadol.admin` → `/chadolight/admin` (overview, built-in type creation), form `ChadoLightAdminForm`.
- `chadol.add_content_type` → `/chadolight/admin/structure/types/add`, form
  `ChadoLightAddContentTypeForm` (stub — submit does nothing yet).
- `chadol.autocomplete` → `/chadolight/autocomplete/{dbkey}/{schema}/{type}/{params}`,
  `AutocompleteController::handleAutocomplete`, JSON.

## Permissions (chadol.permissions.yml)

`view chado content`, `edit chado content`, `administer chado`.

## No

No Drush, no cron/hooks, no update hooks, no config/install, no entities of its own, no external HTTP
API. Create/update/delete SQL is intentionally empty (read-oriented mapping).
