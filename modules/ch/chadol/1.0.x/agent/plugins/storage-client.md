<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# xnttchado storage client — Chado.php

The one plugin that is the module. `src/Plugin/ExternalEntities/StorageClient/Chado.php`,
`class Chado extends \Drupal\xnttsql\Plugin\ExternalEntities\StorageClient\Database` (the generic SQL
client from `xnttsql`). Annotation: `@StorageClient(id="xnttchado", label="Chado")`. Chado is a
PostgreSQL schema for biological data; this client turns a Chado table into an External Entity type by
generating its SQL and field mappings from schema introspection instead of hand-written queries.

## Setup

1. Enable `chadol` (pulls `external_entities`, `xnttsql`, `dbxschema_pgsql`). Rebuild cache if enabled
   via Drush.
2. Ensure a PostgreSQL connection holding a Chado schema exists in `settings.php` `$databases`
   (README shows the array; a remote Chado is just another key). The Drupal DB account must be able to
   read the target schema(s).
3. Create an External Entities type (`admin/structure/external-entity-types/add`) and choose storage
   client **Chado**, or use the one-click built-in types from `/chadolight/admin`
   (see [../config/admin-and-routes.md](../config/admin-and-routes.md)).

## Configuration model (config schema)

`config/schema/chadol.storage_client.schema.yml` defines
`plugin.plugin_configuration.external_entities_storage_client.chadol`. On top of the inherited xnttsql
keys (`queries`, `connection`, `placeholders`, `filter_mappings`) it adds **`chado_config`**:

- `datatype`: `mode` (`type_id` | `table`), `chado_type` (e.g. `feature_317`, i.e. `{table}_{type_id}`),
  `chado_table`.
- `fields`: sequence of per-column settings — `include` (whether/how to output) and a `filter`
  sub-mapping (`filter_type`, `filter_op`, `filter_value`, `filter_min`, `filter_max`, `filter_mode`).
- `joins.list`: sequence of join specs (`join_type`, `join_name`, `required`, and type-specific filter
  sub-forms).

`defaultConfiguration()` seeds `chado_config` with empty datatype/fields/joins.

## How the config form works (`buildConfigurationForm`)

- Forces `schema_count` = 1 (a Chado type maps exactly one schema). Reuses the xnttsql (`xnttdb`) form
  as a base, then unsets `queries`, `placeholder_settings`, `filter_mappings`, and the raw
  `connection.dbkey`/`schemas` widgets.
- `getChadoInstances()` scans every `default`-target pgsql connection from
  `Database::getAllConnectionInfo()`, calls `chadol_get_available_instances()` on each, and offers a
  `dbkey#schema` select. If none found, shows a "No Chado instance found" message and stops.
- After an instance is chosen (AJAX submit `submit_schema`) it calls `initConnection()` and offers the
  **data type** chooser: radios `type_id` vs `table`, plus `getChadoDataTypes()` (cvterm-typed rows,
  grouped by table) and `getChadoTables()` (tables bucketed 1) Main … 6) Audit).
- Once a table is resolved it appends the **fields** form (`getChadoTableFieldForm`) and the **joins**
  form (`getChadoDataJoinForm`). AJAX rebuilds go through `buildAjaxParentSubForm` (inherited).

## Query generation (`generateSqlQueries`)

Called from `validateConfigurationForm`, which first synthesises `connection`/`queries`/`placeholders`
from the Chado selections, sets them on the parent form state, then lets the parent xnttsql validator
run. Highlights:

- `create`/`update`/`delete` queries are left **empty strings** — this client is read-oriented.
- `read` selects all table columns (`t.<col>`), coalescing empty `name`/`uniquename` to `-` (`NONAME`),
  filtered by `t.<table>_id IN (:id[])` (+ `t.type_id = <n>` in `type_id` mode).
- `list`/`count` reuse the same FROM/joins, dropping the id predicate and appending the xnttsql
  `:filters` placeholder.
- Table and column identifiers come from `getChadoTableDef()` (schema introspection via
  `$this->xConnection->schema()->getTableDef(...)`); tables are referenced with the `dbxschema`
  `{1:table}` schema-prefix placeholder. User-entered filter *values* are bound through
  `getChadoPlaceholder()` (named placeholders `:ph_<md5>` registered as constants), and list-value
  filters (cvterm/dbxref/tree ids) are `intval()`-cast or matched from `[id:<digits>]` before use.

## Field mapping (`getRequestedChadoFields` / `getRequestedDrupalFields` / `getRequestedMapping`)

Builds Drupal field definitions + `generic`/`direct` property mappings:

- Always maps `id` (→ `<table>_id`), `uuid` (→ `uniquename` if present else id), `title` (→ `name` if
  present else id).
- For each included column emits a Drupal field of the mapped type (see `mapPgsqlTypeToFieldType`):
  string/text/boolean/decimal/float/integer/datetime, with widget + formatter settings from
  `getFieldTypeFormDisplayOptions()` / `getFieldTypeViewDisplayOptions()`.
- `cvterm`/`dbxref`/`organism` display mappings are stubbed (`@todo Implement`) — the SQL side builds
  them but the Drupal-field side is incomplete in this beta.

## Joins (`getChadoDataJoinForm` + the `case` blocks in `generateSqlQueries`)

Supported `join_type`s, each producing aggregated columns (`array_agg` and a `json_object_agg`
`array_<alias>` / `json_<alias>` pair) via LEFT/INNER JOIN (INNER when `required`):

- `prop` → `{table}prop`; `cvterm` → `{table}_cvterm` (+ `cvterm`); `dbxref` → `{table}_dbxref`
  (+ `dbxref`,`db`, URL = `db.urlprefix || dbxref.accession`); `pub` → `{table}_pub` (+ `pub`);
  `relationship` → `{table}_relationship` (subject/object/any); `fk__<table>__<key>[__<other>]` →
  detected foreign-key link tables (1-to-many / many-to-many).

## Filters

Per-type filter forms + `get*FilterConditions()` builders: text (`getTextFilterForm`, ops i=/contains/
hasword/hasall/begins/ends/regex/length via `mapOperatorExpression`), numeric/date
(`getNumericFilterForm`, ranges + relative offsets via `DrupalDateTime`/`DateInterval`), boolean,
cvterm (whole CV / is_a descendants recursive CTE / explicit id list), dbxref (by `db_id`), organism
(phylotree / node descendants / genus-species text). `mapOperatorExpression()` maps an operator code to
a PostgreSQL expression; an unknown operator logs a warning and yields `FALSE` (query returns nothing).

## Notes

- `create()` injects `messenger`, `logger.factory`, `entity_type.manager`, `entity_field.manager`,
  `token`, `cache.default`, `dbxschema.tool`, `entity_display.repository`. If `dbxschema.tool` cannot
  be built it adds a `CHADOL:` error message and continues with a null tool.
- Multiple Chado schemas / connections on one site are supported; each entity type binds one
  `dbkey#schema`.
