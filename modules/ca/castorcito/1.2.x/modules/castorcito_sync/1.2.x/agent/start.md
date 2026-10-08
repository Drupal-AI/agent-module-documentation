<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito sync (castorcito_sync) — agent index

Sub-module of **[Castorcito](../../../../1.2.x/agent/start.md)**. Exports/imports Castorcito
component configuration as a tarball. Package `Castorcito`, version 1.2.1-beta5,
core `^10.2 || ^11`, GPL-2.0-or-later.

## Dependencies

- `castorcito:castorcito`
- `drupal:config` (core)

## What it provides

- **Routes** (`castorcito_sync.routing.yml`):
  - `castorcito_sync.export` — `/admin/castorcito/export`, form
    `CastorcitoSyncExportForm`, permission `export configuration`.
  - `castorcito_sync.export_download` — `/admin/castorcito/export-download`, controller
    `CastorcitoSyncController::downloadExport`, permission `export configuration`.
  - `castorcito_sync.import` — `/admin/castorcito/import`, form
    `CastorcitoSyncImportForm`, permission `castorcito_sync import configuration`.
- **Permissions** (`castorcito_sync.permissions.yml`, both `restrict access: true`):
  `castorcito_sync export configuration`, `castorcito_sync import configuration`.
  (Note: the export routes use the *core* `export configuration` permission, not the module's
  own export permission.)
- **Links**: menu + local task tabs (`.links.menu.yml`, `.links.task.yml`).

No entities, plugins, services, config schema, or Drush of its own.

## How it works → [config/sync.md](config/sync.md)

Export packages selected/all `castorcito_component` + `castorcito_category` config (recursing into
container children) into `config.tar.gz`; import reads a tarball and recreates config entities.
