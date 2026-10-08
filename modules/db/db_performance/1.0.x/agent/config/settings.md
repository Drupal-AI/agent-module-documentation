<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & configuration

## Config object `db_performance.settings`

Defaults in `config/install/db_performance.settings.yml`, typed in
`config/schema/db_performance.schema.yml` (`type: config_object`):

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `slow_query_threshold` | float | `0.05` | Minimum execution time (seconds) for a SELECT to be collected. Falls back to `0.05` if empty. |
| `max_stored_queries` | integer | `1000` | Row cap for `db_performance_query`; oldest by `last_seen` are trimmed past this. |
| `enable_index_suggestions` | boolean | `true` | Run `EXPLAIN` on report render and cache `CREATE INDEX` suggestions. |
| `allow_index_creation` | boolean | `false` | Show the *Create index* action and enable the create-index form. |
| `ignore_tables` | string | list below | Newline-separated table names/patterns; a query whose SQL text contains any is skipped. |

Default `ignore_tables`: `cache_`, `watchdog`, `sessions`, `queue`, `semaphore`, `key_value`,
`db_performance_query`. When config is empty the subscriber uses the same list from
`QueryCollectorSubscriber::DEFAULT_IGNORE_TABLES`. Matching is a plain substring check
(`str_contains`), so a short pattern like `cache_` also matches related tables.

## Settings form — `SettingsForm`

- `src/Form/SettingsForm.php`, extends `ConfigFormBase`, form id `db_performance_settings`.
- Route `db_performance.settings`: `/admin/config/development/db-performance`, permission
  **`administer site configuration`**. Menu link under *Configuration → Development*.
- Fields: `slow_query_threshold` (number, min 0.001, max 10, step 0.001),
  `max_stored_queries` (number, min 10, max 10000), `enable_index_suggestions` (checkbox),
  `allow_index_creation` (checkbox — described "Use with caution in production"),
  `ignore_tables` (textarea). `submitForm()` casts and saves each to `db_performance.settings`.

## Operating notes

- Enabling the module installs `db_performance_query` via `hook_schema`; collection is passive
  and needs real traffic at/above the threshold before the report has data.
- Lower the threshold on a fast/quiet site to catch more; raise it on a busy site to reduce noise
  and storage churn.
- Leave `allow_index_creation` **off** in production; export `indexes.sql` and apply DDL through
  your own review/deploy process instead.
- There are no Drush commands and no programmatic config UI beyond this form; edit the config
  object directly (`drush cset db_performance.settings <key> <value>`) if scripting.
