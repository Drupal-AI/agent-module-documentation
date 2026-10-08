<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Database (audit_database) — agent index

Analyzes database size, table sizes, primary keys, and potentially problematic tables.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `database` — `DatabaseAnalyzer` (`src/Plugin/AuditAnalyzer/DatabaseAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `database_size` (Database Size), `table_sizes` (Table Sizes), `primary_keys` (Primary Keys), `cache_backend` (Cache Backend), `cache_config` (Cache Configuration), `logging` (Logging Configuration), `fragmentation` (Table Fragmentation), `deleted_tables` (Deleted Field Tables), `table_inventory` (Table Inventory).

## Configuration

- Config object `audit_database.settings` (schema `config/schema/audit_database.schema.yml`, defaults `config/install/audit_database.settings.yml`). Keys: `table_size_threshold` (100), `database_size_threshold` (1000), `ignore_cache_backend_warnings` (false), `ignore_dblog_warnings` (false).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Database` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run database` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters database`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
