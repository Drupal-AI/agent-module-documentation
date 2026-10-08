# Services, client API, hook & routing (API)

## Services (`ai_vdb_provider_postgres.services.yml`)

| Service | Class | Notes |
|---|---|---|
| `ai_vdb_provider_postgres.client` | `Drupal\ai_vdb_provider_postgres\PostgresPgvectorClient` | The raw pgvector client. No constructor args. |
| `ai_vdb_provider_postgres.vector_index_config_subscriber` | `…\EventSubscriber\VectorIndexConfigSubscriber` | `event_subscriber`; args `@ai.vdb_provider`, `@ai_vdb_provider_postgres.client`, `@logger.factory`. Applies the index strategy on `search_api.server.*` config save — see [../configure/settings.md](../configure/settings.md). |

The provider plugin (`postgres`) is discovered via the **ai** module's `ai.vdb_provider` manager, not
declared here. See [../plugins/vdb-provider.md](../plugins/vdb-provider.md).

## `PostgresPgvectorClient` — using it from code

`$client = \Drupal::service('ai_vdb_provider_postgres.client');` Every method takes an explicit
`\PgSql\Connection` (get one from `\Drupal::service('ai.vdb_provider')->createInstance('postgres')->getConnection($db)`).
Requires the **pgsql** PHP extension (`ext-pgsql`); the client uses the procedural `pg_*` API.

Key methods:

- `getConnection(string $host, int $port, string $username, string $password, string $default_database, ?string $database = NULL): Connection|false`
  — `@pg_connect("host=… dbname=… port=… user=… password=…")`; throws `DatabaseConnectionException` on failure.
- `ping(Connection)`, `getCollections(Connection)`.
- `createCollection($name, $dimension, $conn)`, `dropCollection($name, $conn)`.
- `insertIntoCollection($collection, $drupal_entity_id, $drupal_long_id, $content, $vector, $server_id, $index_id, $extra_fields, $conn)`.
- `deleteFromCollection($collection, array $ids, $conn)`.
- `querySearch($collection, $output_fields, string $filters, $limit, $offset, $conn)`,
  `vectorSearch($collection, $vector_input, $output_fields, string $filters, $limit, $offset, VdbSimilarityMetrics $metric, $conn)`.
- Vector index: `getVectorIndexDetails()`, `getVectorIndexStrategy()`, `createVectorIndex()`,
  `dropVectorIndex()`, `ensureVectorIndex()`.
- `updateFields($fields, $collection, $conn)` — reconciles columns / relation tables for the index's fields.

### Escaping / SQL-building helpers

- `escapeIdentifierForSql($id, $conn)` → `pg_escape_identifier` (table/column/index names).
- `escapeStringForSql($s, $conn)` (private) → `pg_escape_literal`.
- `prepareStringArrayForSql(array, $conn)` → `pg_escape_literal` each item, wrapped as `(…)`.
- `prepareVectorArrayForSql(array, $conn)` → `[f,f,…]` escaped as a literal.
- `prepareFieldArrayForSql(array $fields, $conn, $collection)` → comma-joined escaped identifiers.
- `prepareArrayForSql(array)` → bare `(a,b,c)` (no escaping — intended for already-safe values).
- `getRelationTableName($collection, $field, $conn)` → escaped `<collection>__<field>`.

Reads/writes are done with `pg_query_params` (parameterized) for the main insert, and `pg_query`
for identifier-heavy DDL/DML where names are pre-escaped. Every failure throws a typed exception from
`src/Exception/` (e.g. `CreateCollectionException`, `QuerySearchException`, `VectorIndexException`,
`InsertIntoCollectionException`, `EscapeStringException`, `DatabaseConnectionException`,
`DatabaseNotConfiguredException`).

## Hook

`ai_vdb_provider_postgres.module`:

- `hook_search_api_index_update(IndexInterface $index)` — fires when a Search API index is saved.
  It bails unless the server's backend is `SearchApiAiSearchBackend` **and** `backend_config.database === 'postgres'`,
  then calls `PostgresPgvectorClient::updateFields($index->getFields(), $collection, $connection)` to
  add any newly-indexed field columns / relation tables.
- `ai_vdb_provider_postgres_is_field_multiple($field)` — helper returning whether a field's
  cardinality ≠ 1 (used when building extra-field data).

## Routing & menu

- Route `ai_vdb_provider_postgres.settings_form` → `/admin/config/ai/vdb_providers/postgres`
  (`_form` `PostgresConfigForm`, `_permission: 'administer ai providers'`).
- Menu link `ai_vdb_provider_postgres.settings_menu` under parent `ai.admin_vdb_providers`.

No permissions, no drush commands, no libraries are defined by this module.
