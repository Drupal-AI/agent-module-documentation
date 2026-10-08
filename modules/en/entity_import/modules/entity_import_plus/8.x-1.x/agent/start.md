<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Import Plus (entity_import_plus) — agent index

Submodule of **Entity Import** that adds three **migrate_plus**-based migrate process plugins to the parent's
field-mapping UI. Package `Migration`. Depends on `entity_import` + `migrate_plus (>=8.x-5.x)`. Core
`^10 || ^11`. Version 8.x-1.0-alpha8 (shipped inside the entity_import project).

- **The three process plugins + the stub event subscriber** → [plugins/processes.md](plugins/processes.md)

## What it actually is

- No routes, no permissions, no config schema, no config entities. One service:
  `entity_import_plus.event_subscriber` (`EventSubscriber\EntityImportPlusEventSubscriber`).
- Three `@MigrateProcessPlugin`s in `src/Plugin/migrate/process/`, each extending a migrate_plus plugin and
  implementing the parent's `EntityImportProcessInterface` (so they appear as selectable processes on an
  Entity Import field mapping):
  - `entity_import_plus_entity_lookup` (`EntityImportPlusEntityLookup` extends migrate_plus `EntityLookup`).
  - `entity_import_plus_entity_generate` (`EntityImportPlusEntityGenerate` extends migrate_plus `EntityGenerate`).
  - `entity_import_plus_str_replace` (`EntityImportPlusStrReplace` extends migrate_plus `StrReplace`).
- The subscriber listens to `EntityImportEvents::ENTITY_IMPORT_PREPARE_MIGRATION_STUB` and seeds valid stub
  config so these plugins instantiate cleanly inside Entity Import's generated migrations.

See the parent module docs for how field mappings turn into a migrate process pipeline.
