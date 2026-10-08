<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate: Skip On 404 — agent index

Adds one migrate **process plugin**, `skip_on_404`, that skips a file/row when the source
file is missing (instead of failing the migration), plus an automatic patch to core's D7
file migrations. **No** config, routes, permissions, config schema, or Drush.

- **Use the `skip_on_404` process plugin (methods, source, external vs local, auto-alter)** →
  [api/skip-on-404.md](api/skip-on-404.md)

Key facts:
- Plugin id `skip_on_404` (class `Drupal\migrate_skip_on_404\Plugin\migrate\process\SkipOn404`).
- `method: row` → throws `MigrateSkipRowException` (skip the whole record, message logged);
  `method: process` → `stopPipeline()` (skip only this property).
- Existence check: external URLs via `http_client` `HEAD` (a `RequestException` = missing);
  local paths via `file_exists()`.
- `hook_migration_plugins_alter()` auto-adds it to `d7_file`, `d7_file_private`,
  `upgrade_d7_file`, `upgrade_d7_file_private` on the `source_full_path` chain — no config needed.
