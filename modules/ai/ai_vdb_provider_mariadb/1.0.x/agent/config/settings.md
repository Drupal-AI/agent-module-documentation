<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the MariaDB VDB provider

## Install & enable

```bash
composer require drupal/ai_vdb_provider_mariadb
drush en ai_vdb_provider_mariadb -y
```

Requires PHP 8.1+, the **`mysqli`** extension, and **MariaDB 11.7+** (11.8 LTS recommended) for the `VECTOR`
type. Only Drupal dependency is `ai`. `hook_requirements()` (`.install`) reports an **error** on
`/admin/reports/status` if the running MariaDB is older than 11.7, and a **warning** if rate-limit debug
logging is left enabled on the server.

## Connection model — two modes

`MariaDBProvider::getConnectionData()`:

1. **Default (recommended): reuse Drupal's database.** With no `host` configured, it reads
   `\Drupal::database()->getConnectionOptions()` and requires a `mysql`/`mysqli` driver. Vector writes then
   share Drupal's transaction (roll back with entity changes) and no extra config is needed.
2. **External MariaDB instance.** Set connection details in **`settings.php`** as a config override (not via
   any form — there is no credential form), e.g.:

   ```php
   $config['ai_vdb_provider_mariadb.settings'] = [
     'host' => getenv('VECTOR_DB_HOST'),
     'port' => getenv('VECTOR_DB_PORT') ?: 3306,
     'username' => getenv('VECTOR_DB_USER'),
     'password' => getenv('VECTOR_DB_PASS'),
     'database' => getenv('VECTOR_DB_NAME'),
   ];
   ```

   `host`, `username`, `password` and `database` are all required in this mode
   (`DatabaseNotConfiguredException` otherwise). An external DB cannot join Drupal's transaction, so a failed
   entity save will not roll back vectors written to it (the info page warns about this).

Keeping the credentials in `settings.php` (or environment variables read there) keeps them out of exported
configuration.

## Config object & schema

Config object **`ai_vdb_provider_mariadb.settings`** (install defaults: `use_drupal_database: true`, all
connection keys empty). Schema `config/schema/…schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `use_drupal_database` | boolean | Marker that the module is ready using Drupal's DB. |
| `host` / `port` / `username` / `password` / `database` | string/int | External MariaDB connection (set in `settings.php`). |

The schema file also **extends** `plugin.plugin_configuration.search_api_backend.search_api_ai_search` to add
this module's `database_settings` (collection, metric, `rate_limit_rpm`, `rate_limit_tpm`,
`rate_limit_avg_tokens`, `rate_limit_debug`) — those live on the Search API server, not this config object.

## The admin info page

Route `ai_vdb_provider_mariadb.settings` → **`/admin/config/ai/vdb_providers/mariadb`**, controller
`MariaDBConfigController::content`, permission **`administer site configuration`** (menu:
*AI → VDB Providers → MariaDB Configuration*). It is **read-only** — shows the current DB host/name/user, the
MariaDB version / vector-support check, external-DB `settings.php` examples, usage steps, and a debug-logging
warning. No settings are saved here.

## Wire up Search API (where the real config lives)

1. `/admin/config/search/search-api` → **Add server** → backend **AI Search**.
2. Select **MariaDB vector DB** as the VDB provider. The `form_search_api_server_form_alter` hook pre-fills
   the database name (Drupal's DB) and a default collection/table name `ai_vdb_vectors`.
3. Set the embedding engine + **dimensions**, similarity **metric**, and the **rate-limit** fields (RPM /
   TPM / avg tokens / debug) exposed by `buildSettingsForm()`.
4. Add an **Index**; `hook_search_api_index_update()` creates the collection table (needs dimensions set) and
   ALTERs it to add field columns / relation tables. Then index content.

## Operational notes

- Leave the server `database_name` empty to use Drupal's active connection.
- Rate-limit **debug logging** writes two log entries per chunk per item — disable in production
  (`/admin/reports/status` and the info page both warn).
- Provides Drush commands (`ai-vdb:test-rate-limits`, `ai-vdb:test-batch-indexing`) — see
  [../api/operations.md](../api/operations.md).
