<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Sanitize (advanced_sanitize) — agent index

A config-file-driven **database anonymizer**. You author a YAML definition file, point the module at
it, and it rewrites the listed **entity fields** and **raw table columns** in place with FakerPHP
fakes, constants, or SQL expressions. Package **Development**. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.2.2.

Despite the info.yml line "Plugins to extend drush sql sanitize command", it does **not** hook into
Drush core `sql:sanitize` and defines **no plugin type**. It ships a standalone service, a settings
form, and its own Drush command.

- **Install, configure, the YAML definition format, running it, events** →
  [config/settings.md](config/settings.md)

## Dependencies

- Composer: **`fakerphp/faker` `^1.9.1`** (autoloaded PHP library, not a Drupal asset library).
- No Drupal module dependencies.

## What it provides

- **Service** `advanced_sanitize.service` → `Drupal\advanced_sanitize\AdvancedSanitizeService`
  (`src/AdvancedSanitizeService.php`). Reads config, builds a Batch, rewrites data. Interface
  `AdvancedSanitizeInterface` holds `const LIMIT = 100` (default per-batch size).
- **Settings form** `SanitizeSettingsForm` (`src/Form/`) at route
  `advanced_sanitize.sanitize_settings` → **`/admin/config/development/sanitize-settings`**
  (menu under *Configuration → Development*). Route permission
  **`administer advanced_sanitize configuration`** (`restrict access: true`). Has a **Sanitize**
  submit action that runs the process synchronously.
- **Permission** `administer advanced_sanitize configuration`
  (`advanced_sanitize.permissions.yml`).
- **Config object** `advanced_sanitize.settings`: `config_path`, `batch_sql_limit`,
  `batch_entity_limit` (schema in `config/schema/advanced_sanitize.edit.yml`).
- **Drush command** `advanced_sanitize:sanitize` (alias **`adsan`**) →
  `Drupal\advanced_sanitize\Commands\AdvancedSanitizeCommands` (`drush.services.yml`).
- **7 events** in `Drupal\advanced_sanitize\Event\AdvancedSanitizeEvents`:
  `STARTED_SANITIZE`, `PREPROCESS_DEFINITION`, `PRE_SANITIZE`, `POST_SANITIZE`,
  `PRE_SANITIZE_REVISION`, `POST_SANITIZE_REVISION`, `FINISHED_SANITIZE` (event classes in
  `src/Event/`). The started/preprocess events pass the definition array **by reference** so
  subscribers can alter it.

## How it works (from source)

- `retrieveConfig()` loads `DRUPAL_ROOT . '/' . config_path` (YAML), validates each record, and
  returns the survivors. `checkEntityRecord()` drops field mappings whose `field_id` is not a real
  field or whose `data_provider` is not in `['faker','constant','sql']`; `checkSqlRecord()` drops
  records missing `column_mapping` or `unique_column`.
- `setBatchBuilder()` splits work into Batch operations: `processBatchDrupal()` for entity records
  (`entity_id`, optional `bundle_id` other than `default`; query `accessCheck(FALSE)`) and
  `processBatchSql()` for table records (`table_name`, `unique_column`, optional `where`).
- `processWithDrupal()` rewrites fields via `faker`/`constant` and saves the entity;
  `updateRow()` rewrites columns via `faker`/`constant`/`expression` with a single `UPDATE`.
- Revisionable entities: `sanitizeRevisions()` copies the sanitized field values onto every
  revision. `finishBatch()` calls `drupal_flush_all_caches()`.

See [config/settings.md](config/settings.md) for the full definition-file schema, provider options,
and operating instructions.
