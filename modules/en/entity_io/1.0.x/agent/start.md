<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO (entity_io) — agent index

Exports and imports Drupal **content entities as JSON files**. Export recursively serializes an
entity's fields plus referenced entities (files/images embedded as base64); import re-creates or
updates entities from that JSON, mapping source UUIDs to local entities and showing a diff before
overwrite. Package **Entity IO**. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version
1.0.18 (dir `1.0.x`).

- **Depends on** (core): `media`, `user`, `node`, `taxonomy`, `block`, `comment`.
- **`configure`** route: `entity_io.node_fields` (`/admin/config/entity-io/node/fields`).
- **No new plugin type.** No config schema shipped (config objects are written at runtime).

## What it actually is

- A collection of **forms, controllers, services and Drush commands** — not a plugin type and not
  a migrate integration. The core work is done by static service classes.
- Supported entity types: `node`, `taxonomy_term`, `user`, `media`, `block_content`, `comment`,
  `paragraph`, plus `file` (embedded during export).
- Two custom DB tables (`entity_io.install`): `entity_io_storage` (source-UUID → local-entity map)
  and `entity_io_log` (import/export operation log).

## Services (`entity_io.services.yml`)

- `entity_io.export` → `Service\EntityIoExport` — deep, static export of an entity to a PHP array
  (`::export`, `::exportEntity`, `::getFieldValue`, `::getSelectedFields`, JSON compress/decompress).
- `entity_io.exporter` → `Service\EntityIoExporter` — `::toJson()` renders the array to a JSON/gz/br
  file in the configured storage; exposes static `$json`, `$fileName`, `$publicUrl`.
- `entity_io.entity_importer` → `Service\EntityImporter` — `import()` re-creates/updates entities.
- `entity_io.storage` → `Service\JsonStorageService` — the `entity_io_storage` UUID map.
- `entity_io.logger` → `Service\EntityIoLogger` — writes `entity_io_log`.
- `entity_io.json_compressor` → `Service\JsonCompressor`; `entity_io.download_response_factory` →
  `Service\DownloadResponseFactory`.

## Solution docs

- **Export: forms, routes, controllers, services** → [api/export.md](api/export.md)
- **Import: form, service, diff, revisions** → [api/import.md](api/import.md)
- **Configuration objects, permissions, field-selection forms, storage** → [config/settings.md](config/settings.md)
- **Drush commands** → [api/drush.md](api/drush.md)
- **Submodules (queue, webhooks, push, purge) overview** → [submodules/overview.md](submodules/overview.md)

## Permissions (`entity_io.permissions.yml`)

`entityio import json`, `export node json`, `export taxonomy json`, `export user json`,
`export block json`, `export media json`, `export batch json`. Note: the comment export form route
requires `administer export comment json`, a permission **not defined** in this file (so that one
route is effectively unreachable); config forms and several routes use core
`administer site configuration`. Full route↔permission table in [api/export.md](api/export.md).

## Submodules

`entity_io_queue`, `entity_io_webhooks`, `entity_io_push`, `entity_io_purge` — each documented in
its own nested tree under `modules/en/entity_io/modules/<submodule>/1.0.x/`.
