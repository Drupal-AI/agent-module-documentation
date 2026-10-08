<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the run form works

`MigrateSourceUiForm` (`src/Form/MigrateSourceUiForm.php`) is the whole feature. It has no
public API/service — this documents its behavior so you know what it will and won't do.

## Which migrations are listed

The form iterates all migration definitions (via `plugin.manager.migration`) and offers only
those whose **source plugin reads an uploaded file**:

- `CSV` — from `migrate_source_csv` (`.csv`)
- `Url` — from `migrate_plus` (JSON/XML via a data parser plugin) (`.json`, `.xml`)
- `Spreadsheet` — from `migrate_spreadsheet` (spreadsheets)

Each option is labelled `"<migration_id> (supports <file_type>)"`. A migration whose source is
none of these does not appear. So the picklist depends on which of those source modules are
installed and which migrations you have authored.

## Allowed file extensions

Hard-coded allow-list: **`csv`, `json`, `xml`**. The form detects the expected extension for
the chosen migration (e.g. from the `Url` source's `data_parser_plugin`) and validates the
upload against it.

## Submit flow

1. Read `migrate_source_ui.settings:file_temp_directory`; if `null`, use `FALSE` (Drupal
   temporary scheme). Otherwise `realpath()` + `prepareDirectory(..., CREATE_DIRECTORY)`.
   (Note: core's `prepareDirectory()` takes its first arg **by reference**.)
2. `file_save_upload('source_file', $validators, $file_destination, 0, FileExists::Replace)`
   and store the resulting file URI in form state.
3. `createInstance($migration_id)`; if the migration is not Idle, reset it to Idle (with a
   warning).
4. Override the migration's **source** config so `source.path` points at the uploaded file,
   then run the import (using `StubMigrationMessage` to surface messages).

## Consequences / gotchas

- It **mutates content**: running a migration imports rows (create/update) per the migration's
  process/destination. Treat it like `drush migrate:import`.
- It only overrides the source **path/file**, not the rest of the migration — the migration
  must already be correct for that file's structure.
- No Drush is added; use core/`migrate_tools` Drush (`drush migrate:status`,
  `drush migrate:import`) for scripted runs and to inspect results afterward.
- `StubMigrationMessage` (`src/StubMigrationMessage.php`) is an internal helper for capturing
  migrate messages during the UI run; not a public API.
