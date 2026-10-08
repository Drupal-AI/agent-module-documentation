<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Postgres VDB Provider (ai_vdb_provider_postgres) — agent index

Registers a **Postgres + pgvector** vector-database provider for the **AI** module, so AI Search
(`search_api_ai_search`) and anything using the `ai.vdb_provider` abstraction can store and
similarity-search embeddings in a PostgreSQL database instead of a dedicated vector service. The
plugin `postgres` (`PostgresProvider`, an `AiVdbProvider` implementation) is a thin adapter over the
`ai_vdb_provider_postgres.client` service (`PostgresPgvectorClient`), which owns the `pg_*` SQL: it
creates a per-server table (`id, content, drupal_entity_id, drupal_long_id, server_id, index_id,
embedding vector(N)`), adds columns / `<collection>__<field>` relation tables for indexed fields,
and runs vector search via pgvector operators (`<=>`, `<->`, `<#>`).

Two configuration layers: a **global connection** on this module's settings form
(`/admin/config/ai/vdb_providers/postgres`, permission `administer ai providers`), and **per-Search
API server** settings (database, collection, similarity metric, index strategy) on the AI Search
backend. The DB password is stored as a **Key entity** (`key` module, `key_select`) — the plaintext
never reaches this module's config.

- Depends on: `ai:ai`, `key:key`. Composer: `drupal/ai ^1.1@beta`, `ext-pgsql` (the pgsql PHP
  extension is required; the client uses procedural `pg_*`).
- Core: `^10.2 || ^11`. Package: `AI Vector Database Providers (Experimental)`.
  `lifecycle: experimental`, release **1.0.0-alpha3** — treat the API as unsettled.
- Has a settings form / `configure` route (`ai_vdb_provider_postgres.settings_form`). **No**
  permissions of its own, **no** drush, **no** libraries. Ships config schema. Defines **no** plugin
  type (it *provides* a plugin of ai's `AiVdbProvider` type).
- pgvector must already be installed on the Postgres server — the module does not install the
  extension; the settings-form connection test is where a missing extension surfaces.

## What you'd do → where

- **Set the Postgres host/credentials, pick the password Key, configure per-server database /
  collection / metric / index strategy** → [configure/settings.md](configure/settings.md)
- **Understand the `postgres` plugin, the table/relation data model, index strategies and
  similarity metrics** → [plugins/vdb-provider.md](plugins/vdb-provider.md)
- **Call `PostgresPgvectorClient` from code, or understand the services, the index hook and
  routing** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Plugin: `postgres` — `Drupal\ai_vdb_provider_postgres\Plugin\VdbProvider\PostgresProvider`
  (`#[AiVdbProvider]`), via manager `ai.vdb_provider`.
- Services: `ai_vdb_provider_postgres.client` (`PostgresPgvectorClient`),
  `ai_vdb_provider_postgres.vector_index_config_subscriber` (`VectorIndexConfigSubscriber`,
  `event_subscriber` on `ConfigEvents::SAVE`).
- Route: `ai_vdb_provider_postgres.settings_form` (`/admin/config/ai/vdb_providers/postgres`,
  `_permission: 'administer ai providers'`). Menu link `ai_vdb_provider_postgres.settings_menu`
  (parent `ai.admin_vdb_providers`). Form `PostgresConfigForm` (id `ai_vdb_provider_postgres_settings`).
- Config object `ai_vdb_provider_postgres.settings`: keys `host`, `port`, `username`, `password`
  (a Key id), `default_database`.
- Enum: `Drupal\ai_vdb_provider_postgres\Enum\VectorIndexStrategy` (`none`, `hnsw`, `ivfflat`).
- Hook: `hook_search_api_index_update()` (reconciles field columns/relation tables). Helper
  `ai_vdb_provider_postgres_is_field_multiple()`.
- Per-server config path: `search_api.server.<id>.backend_config.database_settings`
  (`database_name`, `collection`, `metric`, `vector_index_strategy`); active only when
  `backend_config.database === 'postgres'`.
- Exceptions: `src/Exception/*` (e.g. `DatabaseConnectionException`, `CreateCollectionException`,
  `QuerySearchException`, `VectorSearchException`, `VectorIndexException`, `EscapeStringException`).
