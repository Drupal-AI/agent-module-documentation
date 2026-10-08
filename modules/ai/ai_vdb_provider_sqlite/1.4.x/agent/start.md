<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SQLite VDB Provider (ai_vdb_provider_sqlite) — agent index

Registers **SQLite (sqlite-vec) as a vector-database provider** for the AI module's AI Search. Embeddings
are stored in a local SQLite file using `vec0` virtual tables; filterable attributes live in
`{collection}__{field}` relation tables. Experimental. Version dir **1.4.x** (installed 1.4.0),
core `^10.2 || ^11`.

## Dependencies
- `ai:ai` (composer `drupal/ai:^1.4`) and `key:key` (info.yml).
- Runtime: AI Search (`ai_search`) + Search API — the module's hooks/backends reference
  `Drupal\ai_search\...` and `search_api`.
- Native: PHP `sqlite3` extension + the sqlite-vec `vec0.so` extension file (checked in
  `ai_vdb_provider_sqlite.install`).

## What it provides
- Plugin: `SQLiteProvider` (`#[AiVdbProvider(id: 'sqlite')]`, extends `AiVdbProviderClientBase`) —
  `src/Plugin/VdbProvider/SQLiteProvider.php`.
- Service: `ai_vdb_provider_sqlite.client` → `SQLiteVectorClient` (raw SQLite3 SQL builder) —
  `src/SQLiteVectorClient.php`.
- Config form + route: `ai_vdb_provider_sqlite.settings_form` at
  `/admin/config/ai/vdb_providers/sqlite`, permission `administer ai providers`
  (`src/Form/SQLiteConfigForm.php`, `*.routing.yml`). Menu link under `ai.admin_vdb_providers`.
- Config object: `ai_vdb_provider_sqlite.settings` (`db_path`, `ext_file`) with schema in
  `config/schema/`.
- Hooks (`ai_vdb_provider_sqlite.module`): `hook_file_download` (denies download under `db_path`),
  `hook_search_api_index_update` (syncs relation tables for Filterable attributes),
  `hook_requirements` (`*.install`).
- Exceptions: typed `src/Exception/*Exception.php` per operation.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, requirements, settings form, config keys.
- [plugins/vdb-provider.md](plugins/vdb-provider.md) — the `sqlite` provider plugin: collections,
  index/delete, vector & query search, filter building.
- [api/client.md](api/client.md) — `SQLiteVectorClient` SQL builder, schema layout, escaping helpers.
