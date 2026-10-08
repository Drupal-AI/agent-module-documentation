<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom SQL Migrate Source Plugin (custom_sql_migrate_source_plugin) — agent index

A Migrate **source plugin** that runs a hand-written SQL string (from the migration YAML) and
returns every selected column as a migrate row. For importing from bespoke/legacy schemas.
Package `Custom`. Version **8.x-1.5**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

- **The plugin, its config keys, how it runs, and a full migration example** →
  [plugins/custom_sql_query.md](plugins/custom_sql_query.md)

## What it actually is

- One class: `CustomSQLQuery` (id **`custom_sql_query`**, `source_module = custom_sql_migrate_source_plugin`),
  in `src/Plugin/migrate/source/CustomSQLQuery.php`, **extends `Drupal\migrate\Plugin\migrate\source\SqlBase`**.
- No routes, no permissions, no services, no hooks, no forms, no `config/` (no schema, no install
  config), no Drush commands, no submodules. It only adds the one migrate source plugin.

## Dependencies (from `.info.yml`)

- `drupal:migrate` (core Migrate), `migrate_plus:migrate_plus`, `migrate_tools:migrate_tools`.

## Mechanism (from source)

- Reads the query from migration config: `getQueryString()` returns `configuration['sql_query']`.
- `getQueryResults()` runs `getDatabase()->query(configuration['sql_query'], [], ['fetch' => PDO::FETCH_ASSOC])`;
  `getDatabase()` (inherited from `SqlBase`) resolves the connection from the migration's `key`
  (and `target`), i.e. a database defined in `settings.php`.
- `initializeIterator()` wraps the statement in an `\IteratorIterator`; `fields()` derives field
  names from the first fetched row's keys; `getIds()` builds source IDs from `configuration['keys']`.
- `doCount()` runs `configuration['sql_count_query']` if set, else counts the iterator.
- `query()` (the usual `SqlBase` query-builder method) intentionally **throws** — this source does
  not use the query builder; the raw SQL string is authoritative.

## Config keys (in the migration YAML `source:`)

- `plugin: custom_sql_query` (required), `key:` (source DB connection name), `keys:` (list of unique
  source key columns), `sql_query:` (the SELECT string, required), `sql_count_query:` (optional).

## Operating notes

- Migrations run under Drush / the admin migrate UI. Editing `sql_query` requires re-installing the
  custom migration module for the change to register (`drush pmu <module> -y && drush en <module> -y`).
