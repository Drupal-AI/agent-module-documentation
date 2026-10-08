<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query plugins and Views handlers

All paths under `src/Plugin/views/`.

## Query plugins (`query/`)

### VsaBase.php — base, `extends \Drupal\views\Plugin\views\query\Sql`
- `defineOptions()` adds four query options: `vsa_separator` (default `,`), `vsa_order_by` (`''`),
  `vsa_order_direction` (`ASC`), `vsa_max_length` (`0`).
- `buildOptionsForm()` — only when the display has `group_by` set: a separator textfield (size/maxlength
  5), and, if the display has fields, an "order by" **select** whose options are the view's own fields
  plus a direction select (Ascending/Descending).
- `validateOptionsForm()` — rejects a separator containing `;` ("not allowed by default in Drupal
  `Connection::preprocessStatement`").
- `getAggregationInfo()` — registers the two aggregation types on top of core's:
  - `string_aggregation` → method `vsaAggregationMethodSimple`
  - `string_aggregation_distinct` → method `vsaAggregationMethodDistinct`
  - both map handlers: argument `groupby_string`, filter `groupby_string`, sort `groupby_numeric`.
- Helpers used to build safe SQL:
  - `getVsaFieldOptions()` — builds the whitelist `{table}.{realField} => label` from the display's
    field handlers.
  - `getVsaOrderBy(?$field)` — returns `" ORDER BY {field} {DIR}"` **only if** `{field}` is in the
    whitelist; direction is whitelisted to `ASC`/`DESC` (defaults ASC). Returns `''` otherwise.
  - `getVsaSeparator()` — `return $this->getConnection()->quote($this->options['vsa_separator']);`
    (produces a properly escaped, quoted SQL literal).

The concrete subclasses implement the two `vsaAggregationMethod*` callbacks that Views calls to build
the SELECT expression for an aggregated field (`$field` is the Views-generated field alias, not user
input):

### MySql.php — `id: vsa_views_query_mysql` (mysql, mariadb)
- Simple: `GROUP_CONCAT(<field><ORDER BY> SEPARATOR <quoted-sep>)`
- Distinct: `GROUP_CONCAT(DISTINCT <field><ORDER BY> SEPARATOR <quoted-sep>)`
- Adds a MySQL-only `vsa_max_length` number field (min 0, max 4294967295). `validateOptionsForm()`
  requires a set value to be within 4 … 4294967295.
- `getVsaDatabaseMaxLength()` reads current `group_concat_max_len` via `SHOW VARIABLES`.
- `execute()` — if a valid max-length is set, casts to `(int)`, re-checks the 4 … 4294967295 range,
  then runs `SET SESSION group_concat_max_len = $max_length` (int interpolated — no bound param is
  possible for `SET`, hence the explicit int-cast + range guard) before `parent::execute()`.

### PgSql.php — `id: vsa_views_query_pgsql` (pgsql)
- Simple: `STRING_AGG(<field>, <quoted-sep><ORDER BY>)`
- Distinct: `STRING_AGG(DISTINCT <field>, <quoted-sep><ORDER BY(field)>)` — passes the aggregated
  `$field` into `getVsaOrderBy()` because Postgres `STRING_AGG(DISTINCT …)` can only order by the
  aggregated expression itself, not another field.

### Sqlite.php — `id: vsa_views_query_sqlite` (sqlite)
- Simple: `GROUP_CONCAT(<field>, <quoted-sep><ORDER BY>)`
- Distinct: `GROUP_CONCAT(DISTINCT <field><ORDER BY>)` — SQLite supports no custom separator with
  DISTINCT, so it falls back to SQLite's default comma; ordering still applies.

## Filter handler (`filter/GroupByString.php`)
- `id: groupby_string`, `extends \Drupal\views\Plugin\views\filter\StringFilter`. Filters the
  **aggregated** value, so every operator emits `$query->addHavingExpression(...)` (post-GROUP BY
  `HAVING`) instead of `WHERE`.
- Operators: `opEqual`, `opContains`, `opContainsWord` (word / all-words), `opStartsWith`,
  `opNotStartsWith`, `opEndsWith`, `opNotEndsWith`, `opNotLike`, `opShorterThan`/`opLongerThan`
  (`LENGTH($field)` vs an `(int)` cast value), `opRegex` (`REGEXP`), `opEmpty` (`IS [NOT] NULL`).
- Every value goes in through a **bound placeholder**; LIKE patterns use `$connection->escapeLike()`.
- `canGroup()` returns FALSE (cannot be nested in a Views filter group).

## Argument / contextual filter (`argument/GroupByString.php`)
- `id: groupby_string`, `extends ArgumentPluginBase`. `query()` adds
  `HAVING <field> LIKE <placeholder>` with the value `'%' . escapeLike($argument) . '%'` (bound
  placeholder). Empty argument → no condition. `getSortName()` returns "String".

## Config
- `config/install/views_string_aggregation.settings.yml`: `extend_views_query_plugin: true`.
- Schema `views_string_aggregation.settings` (boolean `extend_views_query_plugin`); plus the four
  `vsa_*` keys injected into `views.query.views_query` by `hook_config_schema_info_alter()`.
