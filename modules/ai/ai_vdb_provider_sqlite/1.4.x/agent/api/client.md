<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SQLiteVectorClient — raw SQLite3 SQL layer

Service `ai_vdb_provider_sqlite.client` → `Drupal\ai_vdb_provider_sqlite\SQLiteVectorClient`
(`src/SQLiteVectorClient.php`, `*.services.yml`). Wraps the native `SQLite3` driver + sqlite-vec `vec0`.
All methods take an open `SQLite3 $connection`. Type maps: `DATA_TYPE_MAPPING`
(integer/date/boolean→INTEGER, decimal→REAL, text/string→TEXT) and `BIND_TYPE_MAPPING` (`SQLITE3_*` bind
constants).

## Connection
`getConnection(string $db_file)`: `new SQLite3($db_file, SQLITE3_OPEN_READWRITE | SQLITE3_OPEN_CREATE)`,
then `loadExtension($ext_file)` where `$ext_file` = `ai_vdb_provider_sqlite.settings:ext_file`. Wraps
failures in `DatabaseConnectionException`. (`ping()` = `querySingle('SELECT 1') === 1`.)

## Schema layout
- Main collection = a `vec0` virtual table:
  `CREATE VIRTUAL TABLE IF NOT EXISTS "collection" USING vec0 (id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT, drupal_entity_id TEXT, drupal_long_id TEXT, server_id TEXT, index_id TEXT,
  embedding float[$dimension])` (`createCollection`).
- Per filterable field: relation table `"collection__field"` =
  `(id PK, value <sqlite_type> NOT NULL, chunk_id INTEGER NOT NULL, FOREIGN KEY(chunk_id) REFERENCES
  "collection"(id) ON DELETE CASCADE)` (`addFieldIfNotExists`). NB: vec0 does not enforce foreign keys,
  so `deleteFromCollection` deletes relation rows manually.
- `getCollections()` lists `sqlite_master` tables excluding `sqlite_%`, `%_idx`, and `%__%` (relation
  tables). `updateFields()` (from `hook_search_api_index_update`) creates a relation table per Filterable
  attribute, cardinality-aware.

## Insert (`insertIntoCollection`)
Builds `INSERT INTO "collection" (content, drupal_entity_id, drupal_long_id, server_id, index_id,
embedding) VALUES (?,?,?,?,?, <vector_string>)` — the five text columns are **bound** via prepared
`bindValue(..., SQLITE3_TEXT)`; the vector is a literal from `prepareVectorArrayForSql`. For each extra
field it ensures the relation table exists (`relationTableExists`, a prepared `sqlite_master` lookup),
then inserts one row per value with a prepared `INSERT INTO "collection__field" (chunk_id, value) VALUES
(?, ?)` binding `chunk_id` (INTEGER) and `value` (mapped bind type). Dates coerced via `strtotime`, bools
cast to int, non-scalars/NULLs skipped.

## Delete (`deleteFromCollection`)
`array_map('intval', $ids)` → `prepareArrayForSql` → `DELETE FROM "collection" WHERE id IN (…)`; then the
same id list is used to delete from every relation table found by `getRelationTablesFromDb`.

## Search
- `querySearch($collection, $output_fields, $filters, $limit, $offset)`:
  `SELECT <fields> FROM "collection" [<filters>] LIMIT <limit> OFFSET <offset>`. `$filters` here is a full
  clause string supplied by the caller (e.g. `WHERE drupal_entity_id IN (...)` from `getVdbIds`, values
  escaped); `$limit`/`$offset` are int-typed params. Output fields escaped via `prepareFieldArrayForSql`.
- `vectorSearch($collection, $vector_input, $output_fields, $filters, $limit, $offset)`:
  `SELECT <fields> FROM "collection" WHERE embedding MATCH <vector_string> AND k = <k> [AND (<filters>)]
  ORDER BY distance LIMIT <limit> OFFSET <offset>`. With filters, `k = max($limit+$offset, count(*), 1)`
  because sqlite-vec v0.1.x post-filters after the KNN top-k; without filters `k = $limit + $offset`.
  `$filters` is the bare predicate from `SQLiteProvider::prepareFilters()`.

## Escaping / SQL-string helpers
- `escapeIdentifierForSql($id)` → `"` + `str_replace('"','""',$id)` + `"` (SQLite identifier quoting);
  used for every table/column name and by `getRelationTableName("collection__field")`.
- `escapeStringForSql($s)` → `'` + `SQLite3::escapeString($s)` + `'` (private) — used by
  `prepareStringArrayForSql` (string value lists) and `prepareVectorArrayForSql`
  (`json_encode($vector, JSON_NUMERIC_CHECK)` then escaped).
- `prepareArrayForSql($items)` → `(a,b,c)` with **no** quoting — callers pass only already-int/float-cast
  or `intval`-mapped values into it.
- `getRelationTablesFromDb()` finds `"collection__%"` tables with a prepared `LIKE ? ESCAPE '\\'`, escaping
  `%`/`_`/`\\` in the collection name first.

## Exceptions
`src/Exception/*` — one typed `\Exception` subclass per operation (Create/Drop/Delete/Insert/GetCollections
/QuerySearch/VectorSearch/AddFieldIfNotExists/EscapeString/DatabaseConnection/DatabaseNotConfigured).
