<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate source plugin `custom_sql_query`

Class `Drupal\custom_sql_migrate_source_plugin\Plugin\migrate\source\CustomSQLQuery`
(`src/Plugin/migrate/source/CustomSQLQuery.php`), annotated
`@MigrateSource(id = "custom_sql_query", source_module = "custom_sql_migrate_source_plugin")`,
extending core's `Drupal\migrate\Plugin\migrate\source\SqlBase`.

## Install / enable

1. Requires core `migrate` plus contrib `migrate_plus` and `migrate_tools`
   (`drupal:migrate`, `migrate_plus:migrate_plus`, `migrate_tools:migrate_tools`).
2. `composer require drupal/custom_sql_migrate_source_plugin` then `drush en custom_sql_migrate_source_plugin -y`.
3. Define the source database in `settings.php` as a named connection, e.g. key `mg_legacy`:
   ```php
   $databases['mg_legacy']['default'] = [
     'database' => 'mg_legacy', 'username' => 'xxx', 'password' => 'xxx',
     'host' => 'localhost', 'port' => '3306', 'driver' => 'mysql',
     'prefix' => '', 'collation' => 'utf8mb4_general_ci',
   ];
   ```

## Config keys (migration YAML, under `source:`)

- `plugin: custom_sql_query` — selects this source (required).
- `key:` — the `settings.php` database connection name to query (consumed by `SqlBase::getDatabase()`;
  defaults to `migrate` if omitted, plus optional `target`). This is how you point the query at the
  legacy/source database rather than the Drupal DB.
- `keys:` — list of unique source-key column names. `getIds()` iterates it: a scalar entry becomes
  `{name: {type: 'string'}}`; an array entry is passed through verbatim (so you can specify a custom
  type/definition per key).
- `sql_query:` — the full SQL SELECT string. Required; there is no default and no validation — an
  empty/missing value yields an error at run time.
- `sql_count_query:` — optional SELECT returning a single count value; used by `doCount()` for the
  total-rows figure. If absent, the plugin counts by fully iterating the main query.

## How it runs (method by method)

- `getQueryString()` (private) → returns `configuration['sql_query']`. `__toString()` returns the
  same string.
- `getQueryResults()` (private) → `getDatabase()->query(configuration['sql_query'], [], ['fetch' => \PDO::FETCH_ASSOC])`,
  returning a `StatementInterface`. The SQL string is passed through as-is; the query targets the
  connection selected by `key`.
- `initializeIterator()` → `new \IteratorIterator($this->getQueryResults())` — Migrate iterates this
  to produce rows.
- `fields()` → runs the query, `fetchAssoc()`s one row, and returns `[colName => colName, …]` so
  every selected column is advertised as an available source field.
- `getIds()` → builds the source-ID definition from `keys` (see above).
- `doCount()` → `getDatabase()->query(configuration['sql_count_query'])->fetchField()` when a count
  query is set, else `iterator_count($this->initializeIterator())`.
- `query()` → **throws `\Exception('This method should not be called.')`** — the standard `SqlBase`
  query-builder path is deliberately disabled because the raw string replaces it.

## Behavior notes

- Every column named in the `SELECT` is available on the migrate `Row` for process plugins and as a
  destination field source. Alias computed columns (e.g. `CONCAT('/', slug) AS slug`) to expose them.
- Because the field list is derived from the first row (`fields()` calls `fetchAssoc()`), the source
  must return at least one row for field discovery in the migrate UI.
- Maintainer caveat: after editing `sql_query`, re-install the custom migration module holding the
  config so Drupal re-imports it: `drush pmu <module_name> -y && drush en <module_name> -y`.
- Run/manage with `migrate_tools`: `drush migrate:status`, `drush migrate:import <id>`,
  `drush migrate:rollback <id>`.

## Full example migration

```yaml
id: resources
label: Resources
migration_group: mmg8_legacy_migrations
migration_dependencies:
  required:
    - mmg8_legacy_migrations_article_type
source:
  plugin: custom_sql_query
  key: mg_legacy
  keys:
    - id
  sql_query: 'SELECT resources.id,
      CONCAT(''/'', resources.slug) AS slug,
      resources.title, resources.description, resources.file,
      resources.published, resources.category_id, resources.created_at,
      resources.updated_at, resources.locked, resources.subtitle, resources.archive
    FROM resources resources'
destination:
  plugin: entity:node
  default_bundle: article
process:
  title: title
  path/pathauto:
    plugin: default_value
    default_value: 0
  path/alias: slug
```

## Trust / operating model

- The SQL is authored in the migration configuration by the developer who writes the migration and
  is executed only when an operator runs the migration under Drush or the admin migrate UI. The
  `key` selects among the named database connections declared in `settings.php`. This is standard
  Migrate source behavior — treat writing correct, well-formed queries as a developer responsibility.
