# The `postgres` VDB provider plugin (plugins)

This module does **not define a plugin type**. It ships one plugin — an implementation of the
**ai** module's `AiVdbProvider` type — so that AI Search (`search_api_ai_search`) and anything using
`ai.vdb_provider` can store/query embeddings in Postgres+pgvector without knowing the backend.

## Plugin

- Id: **`postgres`**, label `Postgres vector DB`.
- Class: `Drupal\ai_vdb_provider_postgres\Plugin\VdbProvider\PostgresProvider`
  (`#[AiVdbProvider(id: 'postgres', …)]`), extends `Drupal\ai\Base\AiVdbProviderClientBase`.
- Discovered by the ai manager `ai.vdb_provider`
  (`\Drupal::service('ai.vdb_provider')->createInstance('postgres')`).
- Backing service: `ai_vdb_provider_postgres.client` (`PostgresPgvectorClient`) — reached via
  `PostgresProvider::getClient()`.

The provider is a thin adapter: it resolves connection data (`getConnectionData()` / `getConnection()`,
password via Key — see [../configure/settings.md](../configure/settings.md)) and delegates every SQL
operation to the client.

## Data model

`createCollection()` creates the main table with fixed native columns:

```
id bigserial PRIMARY KEY, content VARCHAR, drupal_entity_id VARCHAR,
drupal_long_id VARCHAR, server_id VARCHAR, index_id VARCHAR, embedding vector(<dimension>)
```

Native field names (`PostgresProvider::AI_SEARCH_NATIVE_FIELDS`): `drupal_entity_id`,
`drupal_long_id`, `content`, `vector`, `server_id`, `index_id`. Any **other** indexed Search API
field is an "extra field":

- **Single-value** extra field ⇒ a column `ALTER TABLE … ADD COLUMN IF NOT EXISTS` on the main table
  (`addFieldIfNotExists()`), typed via `PostgresPgvectorClient::DATA_TYPE_MAPPING`
  (`integer→INTEGER`, `text→TEXT`, `date→BIGINT`, `decimal→DECIMAL`, `string→VARCHAR`,
  `boolean→BOOLEAN`).
- **Multi-value** extra field (cardinality ≠ 1, decided by `ai_vdb_provider_postgres_is_field_multiple()`)
  ⇒ a **relation table** `<collection>__<field>` (`id, value, chunk_id` with a
  `FOREIGN KEY(chunk_id) REFERENCES <collection>(id) ON DELETE CASCADE`).

Columns/tables are kept in sync by `updateFields()`, triggered by
`hook_search_api_index_update()` (see [../api/services.md](../api/services.md)).

## Index strategy & similarity metric

`Enum\VectorIndexStrategy`: `none` (exact search), `hnsw`, `ivfflat`. `ensureVectorIndex()` compares
the requested strategy+metric against the live `pg_indexes` definition and drops/recreates the index
`"<collection>_embedding_idx"` only when it differs. Metric → pgvector opclass/operator:

| `VdbSimilarityMetrics` | opclass | search operator |
|---|---|---|
| `CosineSimilarity` | `vector_cosine_ops` | `<=>` (returned distance = `1 - raw`) |
| `EuclideanDistance` | `vector_l2_ops` | `<->` |
| `InnerProduct` | `vector_ip_ops` | `<#>` |

## Operations (called by AI Search / search_api backend)

| Method | What it does |
|---|---|
| `indexItems($config, $index, $items, $embedding_strategy)` | Deletes existing items, gets embeddings, then `insertIntoCollection()` per chunk. |
| `insertIntoCollection($collection, $data, $db)` | Splits native vs extra fields; inserts one main row + relation rows. |
| `deleteItems($config, $item_ids)` / `deleteFromCollection()` | Resolves Drupal ids → vdb ids (`getVdbIds()`), deletes `WHERE drupal_entity_id IN (…)`. |
| `querySearch($collection, $output_fields, $filters, $limit, $offset, $db)` | Non-vector `SELECT … FROM <collection> <filters> LIMIT/OFFSET`. |
| `vectorSearch($collection, $vector, $output_fields, $query, $filters, …)` | Similarity search ordered by the metric operator; cosine wraps in a subquery to return `1-distance`. |
| `prepareFilters($query)` / `processConditionGroup()` | Translates a Search API `ConditionGroup` into a SQL `WHERE`/`JOIN` clause; multi-value fields join their relation table and use `@>` / `IN`. |
| `getCollections()` | Lists non-system tables from `pg_catalog.pg_tables`. |
| `deleteAllItems()` | Clears items then re-applies the vector index. |

Filter values are escaped through the client (`prepareStringArrayForSql` → `pg_escape_literal`) and
identifiers through `pg_escape_identifier`; see [../api/services.md](../api/services.md) for the
client's escaping helpers.
