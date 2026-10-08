<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MariaDB VDB provider plugin & vector client

Two classes: `MariaDBProvider` (the AI VDB plugin) and `MariaDBVectorClient` (all `mysqli` SQL). The plugin
resolves the client with `\Drupal::service('ai_vdb_provider_mariadb.client')`.

## `ai_search` optional-dependency shim

`ai_vdb_provider_mariadb.module` `require_once`s `src/Compatibility/AiSearchShims.php`, which defines empty
stub interfaces/classes (e.g. `Drupal\ai_search\EmbeddingStrategyInterface`) **only when `ai_search` is not
installed** — so `AiVdbProviderClientBase` (which type-hints those) still class-loads and the `mariadb`
plugin is discoverable without a hard `ai_search` dependency. When `ai_search` is present its real classes
autoload first and the stubs are skipped.

## Plugin — `MariaDBProvider`

`#[AiVdbProvider(id: 'mariadb', label: 'MariaDB vector DB')]`, extends `AiVdbProviderClientBase`. Uses
`LoggerChannelTrait` (the base `__construct` is `final`). `getConfig()` → `ai_vdb_provider_mariadb.settings`.
`isSetup()` always TRUE (Drupal DB or external). Native AI-Search fields:
`drupal_entity_id`, `drupal_long_id`, `content`, `vector`, `server_id`, `index_id`.

| Method | Behaviour |
|---|---|
| `getConnection()` / `getConnectionData()` | Drupal DB or external creds (see [../config/settings.md](../config/settings.md)). |
| `createCollection()` / `dropCollection()` | delegate to the client; log (don't throw) on failure. |
| `insertIntoCollection()` | splits `$data` into the 6 native fields + `extra_fields`, calls the client. |
| `indexItems()` | embeds each item (throttled + retried), then one insert per chunk. Marks each field `is_multiple` via `ai_vdb_provider_mariadb_is_field_multiple()`. |
| `deleteItems()` / `deleteIndexItems()` | resolve VDB ids (`getVdbIds`), scoped by `index_id`, then delete. |
| `getVdbIds()` | `WHERE drupal_entity_id IN (…)` (+ `AND index_id = …`), returns `id`s. |
| `querySearch()` / `vectorSearch()` | pass filters/limit/offset to the client; `vectorSearch()` reads the similarity `metric` from the server backend config. |
| `prepareFilters()` / `processConditionGroup()` | build the SQL WHERE clause (below). |

### Filter building

`prepareFilters($query)` always starts the WHERE with `index_id = <escaped index id>` (multiple indexes
share one collection table — this scopes results to the current index), then appends the Search API
`ConditionGroup`. `processConditionGroup()` walks conditions (recursing into nested groups), resolves each
field's type and cardinality, and emits:
- **string / full_text** fields → values via `MariaDBVectorClient::prepareStringArrayForSql()`.
- **multi-value** fields → a `LEFT JOIN <collection>__<field>` and a `value IN/NOT IN (…)` clause.
- **single-value** fields → `(<field> <operator> <values>)`.
Unknown fields log a warning and are skipped. The assembled string is handed to the client as `$filters`.

## Client — `MariaDBVectorClient` (`src/MariaDBVectorClient.php`)

`getConnection()` opens `new \mysqli(host, user, pass, db, port)` with `mysqli_report(ERROR|STRICT)` and
`utf8mb4`. Helpers:
- `escapeIdentifierForSql()` — backtick-quotes an identifier, doubling internal backticks.
- `escapeStringForSql()` — `"'" . $connection->real_escape_string($s) . "'"`.
- `prepareStringArrayForSql()` — `(` + comma-joined escaped strings + `)`.
- `prepareVectorArrayForSql()` — `VEC_FromText('[v1,v2,…]')` (the bracketed list escaped as one string).
- `prepareFieldArrayForSql()` — comma-joined escaped column identifiers (optionally collection-prefixed).

| Method | SQL |
|---|---|
| `createCollection()` | `CREATE TABLE … embedding VECTOR(n) NOT NULL, VECTOR INDEX(embedding) DISTANCE=cosine\|euclidean, INDEX idx_index_id` (ENGINE=InnoDB). |
| `updateFields()` / `addFieldIfNotExists()` | `ALTER TABLE … ADD COLUMN IF NOT EXISTS` for single-value; a `<collection>__<field>` relation table (FK → id ON DELETE CASCADE) for multi-value. |
| `insertIntoCollection()` | prepared `INSERT` (`?` placeholders + `bind_param('s'…)`) for the native columns + single-value extra fields; `VEC_FromText(...)` for the embedding; multi-value fields inserted into their relation table via `prepareRelationQuery()`. |
| `deleteFromCollection()` | `DELETE … WHERE id IN (…)`. |
| `querySearch()` | `SELECT <fields> FROM <collection> [<filters>] LIMIT ? OFFSET ?`. |
| `vectorSearch()` | `SELECT VEC_DISTANCE_COSINE\|EUCLIDEAN(embedding, VEC_FromText('[…]')) AS distance, <fields> FROM <collection> [<filters>] ORDER BY distance LIMIT/OFFSET`. |
| `getCollections()` | lists base tables from `information_schema`. |

`DATA_TYPE_MAPPING` maps Search API types → MariaDB column types (`integer`→INT, `text`→TEXT, `date`→BIGINT,
`decimal`→DECIMAL, `string`→VARCHAR(255), `boolean`→BOOLEAN). Each client method throws a dedicated exception
(`src/Exception/*Exception.php`) carrying the `mysqli` error on failure.

## Operate it

- MariaDB requires `ORDER BY distance` + `LIMIT` for the VECTOR index to be used — `vectorSearch()` always
  adds both.
- Similarity metric (`cosine` default, or `euclidean`) is chosen on the Search API server and used both at
  table creation (index `DISTANCE=`) and query time (`VEC_DISTANCE_*`).
- The `id`-scoping `index_id` filter is mandatory because one collection table can hold vectors for several
  indexes/servers.
