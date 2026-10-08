<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process Array (migrate_process_array) — agent index

Adds five **Migrate process plugins** for array manipulation to core's `migrate.process` plugin
type, for the moments in a migration when a source value is a list you need to filter, reshape, or
restructure. It defines no plugin type, service, route, permission, form, or config — just the plugin
classes under `src/Plugin/migrate/process/`, plus a `hook_help` stub. This is developer/CLI migration
infrastructure: the migration is authored in YAML by a developer and run under Drush; there is no
request-time or admin surface.

The plugins are `array_diff` and `array_intersect` (keep/drop members against an `exclude`/`match`
list, with optional `assoc`/`key`/`uassoc`/`ukey` methods), `array_filter` (PHP `array_filter` with an
optional custom `callable`), `deepen` (wrap each flat value in its own delta sub-array, the opposite of
flatten), and `extract_single` (core's `extract`, but applied per field value/delta rather than once
over the whole multi-value array). Each is used by its `plugin:` id inside a migration's `process:`
pipeline.

- Depends on: nothing declared in `.info.yml` (no `dependencies:`). To actually run migrations you
  need core **Migrate** (`migrate`) enabled; the plugins register into its `migrate.process` type.
- Core: `^9.3 || ^10 || ^11`. Package: `Migration`. Version: **2.0.2**.
- No settings page / `configure` route. No permissions, no services, no routes, no drush commands, no
  config schema, no submodules, no libraries. Only `hook_help` (`help.page.migrate_process_array`).
- Defines **no** plugin type of its own — it contributes plugins to core's `migrate.process` type.

## What you'd do → where

- **Filter, reshape, or restructure an array value in a migration (all five plugins, their config
  keys, YAML examples, and edge cases)** → [plugins/process.md](plugins/process.md)

## Key facts (real machine names)

- Process plugin ids (core `migrate.process` type): `array_diff`, `array_intersect`, `array_filter`,
  `deepen`, `extract_single`.
- Classes (`Drupal\migrate_process_array\Plugin\migrate\process\`): `ArrayDiff`, `ArrayIntersect`,
  `ArrayFilter`, `Deepen`, `ExtractSingle` (extends
  `Drupal\migrate\Plugin\migrate\process\Extract`).
- Config keys by plugin: `array_diff` → `exclude`, `method`, `callable`; `array_intersect` → `match`,
  `method`, `callable`; `array_filter` → `callable`; `deepen` → `key`; `extract_single` → `index`,
  `default` (inherited from core `Extract`).
- `method` values (diff/intersect): `assoc`, `key`, `uassoc` (needs `callable`), `ukey` (uses
  `callable`), else plain `array_diff`/`array_intersect`.
- Hook implemented: `hook_help` → `help.page.migrate_process_array`.
- No routes, services, permissions, forms, drush, config schema, or libraries.
