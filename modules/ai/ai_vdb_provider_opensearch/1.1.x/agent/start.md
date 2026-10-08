<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenSearch VDB Provider (ai_vdb_provider_opensearch) — agent index

An **AI Vector-DB provider plugin** that lets the AI module's **AI Search** submodule use an
**OpenSearch** cluster (via its **k-NN** engine) to store and query embeddings. Package
*AI Vector Database Providers (Experimental)*; `lifecycle: experimental`. Core `^10.2 || ^11`.
License GPL-2.0-or-later. Version 1.1.0-alpha2 (dir `1.1.x`).

Depends on `ai:ai`, `ai:ai_search`, `key:key`, `search_api_opensearch:search_api_opensearch`
(and, transitively, the `opensearch-project/opensearch-php` client that Search API OpenSearch
pulls in). It does **not** implement its own HTTP client or auth — it borrows Search API
OpenSearch's connector plugins and query `FilterBuilder`.

- **Config form, config object, schema, routes, engine choice, connectors/Key** →
  [config/settings.md](config/settings.md)
- **The `opensearch` VdbProvider plugin — every method, index/mapping shape, filters** →
  [plugins/vdb_provider.md](plugins/vdb_provider.md)

## What it actually provides (from source)

- **One plugin**: `OpenSearchVdbProvider` (`src/Plugin/VdbProvider/OpenSearchVdbProvider.php`),
  attribute `#[AiVdbProvider(id: 'opensearch', label: 'OpenSearch Vector DB')]`, extends
  `Drupal\ai\Base\AiVdbProviderClientBase`, implements `DependentPluginInterface`. It does **not**
  define a plugin type — it implements the AI module's `AiVdbProvider` type.
- **One config form**: `OpenSearchConfigForm` (`src/Form/OpenSearchConfigForm.php`), route
  `ai_vdb_provider_opensearch.settings_form` at `/admin/config/ai/vdb_providers/opensearch`,
  permission **`administer ai providers`**, menu link under `ai.admin_vdb_providers`.
- **One config object**: `ai_vdb_provider_opensearch.settings` — keys `connector`,
  `connector_config` (typed by the chosen connector plugin), `vdb_config.engine`. Schema in
  `config/schema/ai_vdb_provider_opensearch.schema.yml`. **No `config/install` defaults.**
- **No** permissions of its own, **no** Drush, **no** hooks, **no** entities. One functional test
  (`tests/src/Functional/OpenSearchVdbProviderTest.php`).

## Key facts an agent needs

- **Collections = OpenSearch indices.** Index names are derived by `formatIndexName()`:
  `strtolower(database_name . '_' . collection_name)`, non-`[a-z0-9_]` replaced with `_`, and
  prefixed `idx` if it would start with `_`.
- **Vector field** is always named `vector`, mapped as `knn_vector` with method `hnsw`, engine from
  `vdb_config.engine` (`faiss` default / `lucene` / `nmslib`), `space_type` from the metric
  (`l2` / `cosinesimil` / `innerproduct`), params `ef_construction: 128`, `m: 16`.
- **The client** is obtained from `getConnector($config['connector'], $config['connector_config'])->getClient()`
  — a Search API OpenSearch connector; endpoint, TLS and auth (Key) are that project's concern.
- `querySearch()` and `getVdbIds()` **throw `BadMethodCallException('Not implemented')`** — only
  vector (k-NN) search is supported, not scalar/metadata-only query.
- Filters for `vectorSearch()` come from `prepareFilters()` → Search API OpenSearch `FilterBuilder`
  (structured OpenSearch DSL, field ids validated against the index), scoped by
  `$filters['term']['index_id'] = $query->getIndex()->id()`.
