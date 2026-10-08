<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MariaDB VDB Provider (ai_vdb_provider_mariadb) — agent index

Registers **MariaDB's native `VECTOR` type** (MariaDB 11.7+) as a vector-database provider (plugin id
**`mariadb`**, label *"MariaDB vector DB"*) for the AI module's **AI Search** submodule. Stores embeddings in
a MariaDB table — Drupal's own DB by default, or a separate instance via `settings.php`. Package
*AI Vector Database Providers*. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.1
(version-dir `1.0.x`). PHP `>=8.1`, `ext-mysqli`.

Dependency (info.yml): `ai:ai` only. `ai_search` is optional at runtime — `AiSearchShims.php` provides stub
interfaces so the plugin loads without it (see [api/client.md](api/client.md)).

- **Install, connection model, config object/schema, the settings page & routes** →
  [config/settings.md](config/settings.md)
- **The provider plugin, the MariaDB client, indexing, filters, similarity search** →
  [api/client.md](api/client.md)
- **Rate-limit throttling, the Drush test commands, hooks** →
  [api/operations.md](api/operations.md)

## What it actually is

- VDB provider plugin `MariaDBProvider` (`src/Plugin/VdbProvider/MariaDBProvider.php`), `#[AiVdbProvider]`,
  extends `Drupal\ai\Base\AiVdbProviderClientBase`.
- Client service **`ai_vdb_provider_mariadb.client`** = `MariaDBVectorClient` (`src/MariaDBVectorClient.php`)
  — builds and runs all `mysqli` table/index/insert/search SQL.
- Event subscriber `EmbeddingRateLimitSubscriber` (service `…embedding_rate_limit_subscriber`, args
  `@logger.factory`) — throttles `embeddings`+`ai_search` AI calls.
- Hook class `AiVdbProviderMariadbHooks` (autowired) — `help`, `form_search_api_server_form_alter`,
  `page_top`, `search_api_index_update` (via `#[LegacyHook]` shims in the `.module`).
- Drush commands `MariaDBTestCommands` (service `…commands`) — `ai-vdb:test-rate-limits`,
  `ai-vdb:test-batch-indexing`.
- Info controller `MariaDBConfigController` at route **`ai_vdb_provider_mariadb.settings`** →
  `/admin/config/ai/vdb_providers/mariadb`, permission **`administer site configuration`** (menu under
  `ai.admin_vdb_providers`). It only displays status/instructions — no form.
- Config object **`ai_vdb_provider_mariadb.settings`** (`use_drupal_database`, `host`, `port`, `username`,
  `password`, `database`) + a schema extension for the AI Search backend's rate-limit settings.
  `hook_requirements()` checks the MariaDB version supports `VECTOR`. **No permissions.yml, no submodules.**

## Mechanism (from source)

- `getConnectionData()` — if a `host` is set (config or `$this->configuration`) it uses external creds
  (host/user/password/port/database, all required); otherwise it reads Drupal's own DB connection options and
  requires a mysql/mysqli driver. `getConnection()` opens a `mysqli` handle (charset `utf8mb4`).
- `createCollection()` — `CREATE TABLE <collection> (id, content, drupal_entity_id, drupal_long_id,
  server_id, index_id, embedding VECTOR(n) NOT NULL, VECTOR INDEX(embedding) DISTANCE=cosine|euclidean,
  INDEX idx_index_id)`. Multi-value fields get a `<collection>__<field>` relation table (FK → collection.id
  ON DELETE CASCADE); single-value fields become columns (`updateFields()` / `addFieldIfNotExists()`).
- `indexItems()` — builds embeddings via the AI Search `EmbeddingStrategyInterface`, throttled + retried with
  exponential backoff, then `insertIntoCollection()` per chunk.
- Search — `vectorSearch()` selects `VEC_DISTANCE_COSINE|EUCLIDEAN(embedding, VEC_FromText('[…]')) AS
  distance … ORDER BY distance LIMIT/OFFSET`; `prepareFilters()` builds a WHERE clause that **always**
  includes `index_id = '<index>'` (multiple indexes share one collection table) plus the Search API
  conditions.
- This is a database backend (mysqli over TCP/socket), not an HTTP API client — there is no external REST
  endpoint.

## Notes

- MariaDB **11.7+** is required for `VECTOR`; `hook_requirements()` errors otherwise. 11.8 LTS recommended.
- External vector DBs cannot join Drupal's transaction, so a failed entity save won't roll back vectors
  written to them (the info page warns about this).
- Rate-limit **debug logging** writes two log entries per chunk — status report and the info page both warn
  to disable it in production.
