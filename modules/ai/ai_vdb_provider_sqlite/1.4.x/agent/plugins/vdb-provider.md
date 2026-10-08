<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `sqlite` VDB provider plugin — SQLiteProvider

`src/Plugin/VdbProvider/SQLiteProvider.php`. Attribute `#[AiVdbProvider(id: 'sqlite', label: 'SQLite
vector DB')]`, extends `Drupal\ai\Base\AiVdbProviderClientBase`, implements
`ContainerFactoryPluginInterface`. Discovered by AI's `ai.vdb_provider` plugin manager; obtained via
`\Drupal::service('ai.vdb_provider')->createInstance('sqlite')`. The heavy SQL work is delegated to the
`ai_vdb_provider_sqlite.client` service (`SQLiteVectorClient`, see api/client.md).

## Connection & config
- `getConfig()` → `ai_vdb_provider_sqlite.settings`. `isSetup()` = true when `db_path` is set.
- `getConnection(string $database = NULL)`: defaults `$database` to `vdb-test.sqlite.sql`; resolves the
  configured `db_path` directory via `file_system::realpath()` (falls back to the raw path if realpath
  fails, since a not-yet-created file returns FALSE); builds `$db_path . DIRECTORY_SEPARATOR . $database
  . '.sqlite.sql'` and opens it through the client. `$database` here is the AI Search backend's
  `database_settings['database_name']` (admin-set).
- `ping()` runs `SELECT 1`.

## Native vs. filterable fields
`AI_SEARCH_NATIVE_FIELDS = [drupal_entity_id, drupal_long_id, content, vector, server_id, index_id]`.
These map to columns on the main `vec0` table. Everything else is a "Filterable attribute" stored in a
`{collection}__{field}` relation table.

## Collections
- `createCollection($name, $dimension, $metric = CosineSimilarity, $database)` → client
  `createCollection` (a `vec0` virtual table with an `embedding float[$dimension]` column). Create errors
  are logged as warnings, not thrown (clearing an index may drop a not-yet-created collection).
- `dropCollection()` → client `dropCollection` (drops main + relation tables); errors also downgraded to
  warnings.

## Indexing (`indexItems`)
For each Search API item: calls the embedding strategy to get chunks, merges `server_id`/`index_id`
metadata, and builds a `$data` array — native fields as `['value' => …]`, filterable fields as
`['value' => …, 'is_multiple' => …, 'type' => <search_api field type>]` (multiplicity from
`ai_vdb_provider_sqlite_is_field_multiple()`). Before inserting, it deletes existing chunks for the items
(except `skipDeleteItemIds`, which are mid-reindex). `insertIntoCollection()` splits native vs. extra
fields and calls the client.

## Deletion
- `deleteItems()` / `deleteIndexItems()` → `getVdbIds()` resolves Drupal item ids to VDB chunk ids via a
  `querySearch` with `WHERE drupal_entity_id IN (...)` (values escaped via `prepareStringArrayForSql`,
  `limit: 1000000` so no chunk is orphaned), then `deleteFromCollection()` deletes by chunk id from the
  main and relation tables.

## Search
- `querySearch($collection, $output_fields, $filters='', $limit, $offset, $database)` — plain metadata
  select, delegate to client.
- `vectorSearch($collection, $vector_input, $output_fields, QueryInterface $query, $filters='', …)` —
  KNN over the `embedding` column; `$filters` is built by `prepareFilters()`.
- `getRawEmbeddingFieldName()` returns `'embedding'` so raw vectors can be returned when the AI 1.2+
  backend option `include_raw_embedding_vector` is on.

## Filter building (`prepareFilters` / `processConditionGroup` / `prepareFilterValues`)
- Walks the Search API `ConditionGroup` recursively, honoring AND/OR conjunctions and nested groups
  (wrapped in parentheses). Returns a bare SQL predicate (no `WHERE`, no JOINs).
- Skips fields not indexed (and not native) with a warning; only operators `=`, `!=`, `<>`, `IN`,
  `NOT IN` are supported (others warned + skipped). `!=`/`<>`/`NOT IN` set a negate flag → `NOT IN`.
- Native fields become `"collection"."field" IN (values)`; filterable fields become
  `"collection"."id" IN (SELECT chunk_id FROM "collection__field" WHERE value IN (values))` (single-table
  KNN, because vec0 KNN can't join and multi-value fields would duplicate rows).
- `prepareFilterValues()` normalizes each value by field type before it reaches SQL: `boolean`→
  `(int)(bool)`, `integer`→`(int)`, `date`→`(int)` (numeric or `strtotime`), `decimal`/`float`→`(float)`;
  numeric lists go through `prepareArrayForSql`, string lists through `prepareStringArrayForSql`
  (`SQLite3::escapeString`). Identifiers are double-quote escaped by the client.
