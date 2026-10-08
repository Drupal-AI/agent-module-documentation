<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk CSV Delete (bulk_csv_delete) — agent index

A single **Drush command** that bulk-deletes **nodes** by matching a field value against a CSV
column. Package `Administration`. Core `^10 || ^11`, PHP `^8`. License GPL-2.0-or-later.
Version 1.1.0. **No dependencies** (core only), **no web UI/route/form, no permissions, no config,
no submodules.** Drush 12+ recommended.

- **The command, all options, validation, and the run flow** → [api/drush-command.md](api/drush-command.md)
- **The four services (parser / matcher / deleter / logger)** → [api/services.md](api/services.md)

## What it actually is

- One Drush command class: `BulkCsvDeleteCommands` (`src/Drush/Commands/BulkCsvDeleteCommands.php`),
  command id **`bulk-csv-delete:run`**, alias **`bcd`**. Auto-discovered from `src/Drush/Commands/`
  (no `drush.services.yml`); it pulls services via `\Drupal::service()` because auto-discovered
  commands do not get constructor injection.
- Four DI services registered in `bulk_csv_delete.services.yml`:
  - `bulk_csv_delete.csv_parser` → `CsvParserService` — `fgetcsv()` line-by-line column extraction.
  - `bulk_csv_delete.node_matcher` → `NodeMatcherService` (`@entity_field.manager`, `@database`) —
    resolves the field's storage table/column and runs direct `SELECT ... IN (...)` matching.
  - `bulk_csv_delete.batch_deleter` → `BatchDeleterService` (`@entity_type.manager`) —
    `$storage->delete()` in `array_chunk` batches, `resetCache()` between them.
  - `bulk_csv_delete.delete_logger` → `DeleteLoggerService` (`@file_system`) — timestamped log file.

## Command shape (from source)

```
drush bcd <csv_file> --content-type=<bundle> --match=<field_name>:<column>
```

Required: `--content-type` (node bundle machine name), `--match` (`field_name:column`, column is
**1-based**). Optional: `--has-header` (false), `--batch-size` (50; validated 1–500),
`--delimiter` (`,`), `--dry-run` (false), `--log-dir` (`private://bulk_csv_delete_logs`),
`--delay` (0, milliseconds between batches), `--filter` (`field_name:term_name`, taxonomy
entity-reference fields only — the term name is resolved to a single tid).

## Run flow

1. `buildConfig()` validates: content type exists, field exists on the bundle, `--match` parses to
   `field:numeric` with column ≥ 1, CSV file exists and is readable, batch size 1–500, optional
   filter field is a taxonomy_term reference resolving to exactly one term.
2. Notices (large-dataset + multilingual), field-index check (warns + prints an `ALTER TABLE` if the
   custom-field column is unindexed).
3. Open log file; parse CSV (unique, trimmed, non-empty column values).
4. Pre-flight table + CSV preview; `NodeMatcherService::findMatchingNodes()` matches via SQL.
5. Optional `filterNidsByField()` narrows the nids to those referencing the filter term.
6. **Dry run stops here** with a count. Otherwise it prints a warning, calls `$io->confirm('Proceed?', FALSE)`
   (default No), and on confirmation deletes in batches with a live progress line.
7. Summary table (deleted / not-found / errors / duration / speed) + closes the log.

## Notes

- **Nodes only.** Matching, filtering, and deletion are all hardcoded to the `node` entity type and
  its field/bundle tables. It is not a generic entity deleter despite the info.yml wording.
- Deleting a node removes **all its translations** (field tables store one row per translation).
- Deletion is irreversible; the module recommends `--dry-run` first and disabling Search API /
  Pathauto / custom `hook_entity_delete` for very large runs. See
  [api/drush-command.md](api/drush-command.md) for performance guidance.
