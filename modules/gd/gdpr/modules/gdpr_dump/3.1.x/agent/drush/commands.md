<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: `gdpr:sql:dump`

`Drupal\gdpr_dump\Commands\GdprDumpCommands` (drush command service `gdpr_dump.commands`,
tagged `drush.command`, constructed with `gdpr_dump.sql_dump` + `gdpr_dump.sanitize`).

```
drush gdpr:sql:dump [options]      # alias: gdpr-sql-dump
```

Exports the Drupal DB as SQL (via mysqldump or equivalent) but runs every column configured
in `gdpr_dump.table_map` through its Anonymizer plugin first, and empties the tables listed in
`empty_tables`. It reuses Drush's SQL option sets (`@optionset_sql`,
`@optionset_table_selection`).

Options (from the command annotation):

| Option | Meaning |
|---|---|
| `--result-file` | Save to a file (relative to Drupal root). |
| `--create-db` | Omit DROP TABLE statements (Postgres/Oracle). |
| `--data-only` | Dump data without schema-creation statements. |
| `--ordered-dump` | Order by primary key + line breaks (MySQL; slower). |
| `--gzip` | Compress the dump with gzip. |
| `--extra` | Extra args when connecting to the DB (used to list tables). |
| `--extra-dump` | Extra args for the dump command (e.g. mysqldump). |

Examples:
```
drush gdpr:sql:dump --result-file=../sanitized.sql
drush gdpr:sql:dump --gzip --result-file=../sanitized.sql.gz
drush gdpr:sql:dump --extra-dump=--no-data
```

The anonymization is driven entirely by config `gdpr_dump.table_map` (see
[../configure/table-map.md](../configure/table-map.md)); the command adds no anonymization of
its own beyond applying that map through `@anonymizer.anonymizer_factory`. MySQL, PostgreSQL
and SQLite each have a dump backend (`GdprSqlMysql` / `GdprSqlPgsql` / `GdprSqlSqlite`).
