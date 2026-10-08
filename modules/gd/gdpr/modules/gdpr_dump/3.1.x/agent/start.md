<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GDPR Dump — agent index

Adds a Drush command that exports the DB as SQL with configured columns anonymized and
configured tables emptied. Requires `gdpr` + `anonymizer` (+ Drush).

- **The `gdpr:sql:dump` command and its options** → [drush/commands.md](drush/commands.md)
- **The settings form and the `gdpr_dump.table_map` config (mapping / empty_tables)** →
  [configure/table-map.md](configure/table-map.md)

Key facts:
- `configure` route `gdpr_dump.settings` → `/admin/config/gdpr/dump-settings`
  (permission `administer site configuration`).
- Config object `gdpr_dump.table_map`:
  `mapping[<table>][<column>] = <anonymizer_plugin_id>` and `empty_tables[<table>] = 1`.
- Column values are run through Anonymizer plugins (e.g. `email_anonymizer`) at dump time.
- Services: `gdpr_dump.sql_dump` (`GdprSqlDump`), `gdpr_dump.sanitize` (`GdprSanitize`),
  `gdpr_dump.database_manager`; MySQL/PgSQL/SQLite dump backends.
- No permissions of its own; provides no plugin types.
