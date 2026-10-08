# Configure: the `sql` (Database) storage client

Add a `sql` storage client to an external entity type's data aggregator. It is configured entirely on
the external entity type's storage form (there is no module settings page). Plugin class
`Drupal\xnttsql\Plugin\ExternalEntities\StorageClient\Database` (id `sql`), which extends the parent's
`QueryLanguageClientBase`. Config schema:
`plugin.plugin_configuration.external_entities_storage_client.xnttsql`.

## Config keys

| Key | Purpose |
|---|---|
| `connection.dbkey` | A `settings.php` `$databases` key for a secondary/external DB (empty = Drupal's own DB). |
| `connection.schemas` | Schema names (PostgreSQL) or database names (MySQL); first = default. Empty = default schema. |
| `queries.read` | **Required.** Returns one full object; must contain `= :id` (or `IN (:id)`). Columns become fields (use `AS "alias"`). |
| `queries.list` | **Required.** Single statement returning ids + names; must include the `:filters` placeholder; no ORDER BY/LIMIT/OFFSET (appended by the client). |
| `queries.count` | **Required.** Same shape as LIST but returns one integer aliased `count`; includes `:filters`. |
| `queries.create` / `update` / `delete` | Optional; enable write. May be multiple `;`-separated statements. CREATE's last statement must return the new id aliased `id`. |
| `placeholders[]` | Named `:name` / `:name[]` placeholders resolved from a `query` (SQL) or a `constant` value; substituted as bound parameters in every query. |
| `filter_mappings[]` | Maps a result-column alias to the SQL expression to filter on (needed when LIST uses computed/aliased columns). Each is `{alias, expression}`. |

Table references use `{#:table}` where `#` is a 1-based schema index matching `connection.schemas`
(use `1` if unsure); `{table}` or `{0:table}` addresses Drupal's own tables. Column names returned as
`array_*` are parsed as PostgreSQL arrays (multi-value fields); `json_*` columns are JSON-decoded.

## How queries run (`Database.php`)

- **Read/LIST/COUNT** obtain the SQL from `getQueries()`, which injects filters at the `:filters`
  placeholder (or removes an empty WHERE). Bound arguments come from `getPlaceholders()`.
- Drupal entity-query conditions are turned into SQL by `getSqlFiltersAndValues()`: the column comes
  from the field's `filter_mappings`/mapping, the operator from an allow-listed set, and **every filter
  value is bound as a `:xnttsqltparam…` parameter** (`$this->xConnection->query($sql, $args)`), not
  concatenated. LIMIT/OFFSET are appended from the query range, and ORDER BY only from `ASC`/`DESC`
  sorts.
- **loadMultiple()** rewrites `= :id` to `IN (:id[])` and binds the id array.
- **create/update/delete** run through `runQueries()` inside a transaction, binding `:field` names
  from the entity's raw data.

## Example (from the module README)

```sql
-- READ
SELECT s.stock_id AS "id", s.name AS "name", cv.name || ':' || cvt.name AS "type_name"
FROM {1:stock} s
  JOIN {1:cvterm} cvt ON cvt.cvterm_id = s.type_id
  JOIN {1:cv} cv ON cv.cv_id = cvt.cv_id
WHERE s.stock_id = :id;

-- LIST
SELECT s.stock_id AS "id", s.name AS "name" FROM {1:stock} s WHERE TRUE :filters;

-- COUNT
SELECT COUNT(1) AS "count" FROM {1:stock} s WHERE TRUE :filters;
```

If LIST/COUNT are omitted they can be auto-generated from READ (with a warning). Set the external
entity type's `debug_level` to log the generated SQL (level ≥2 also logs bound argument values).

## Notes

- `read_only` is achieved by simply not providing CREATE/UPDATE/DELETE queries.
- Cross-database use (Drupal on MySQL reading from PostgreSQL, etc.) is supported via `dbxschema`;
  each connection must be declared in `settings.php`.
- One `sql` client works over one connection; use several clients + a group/vertical aggregator to
  combine multiple connections into one entity type.
