<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views String Aggregation (views_string_aggregation) — agent index

Adds SQL-level **string aggregation** to Views as two field aggregation types — **String aggregation**
(`GROUP_CONCAT` / `STRING_AGG`) and **String aggregation DISTINCT** — so a grouped view lists each
group's values on one row instead of only counting them. Depends on core `views`; core requirement
`^10 || ^11`. GPL-2.0-or-later. No permissions, routes, or Drush commands.

## How it works
- On install, module weight is set to 1 so its hooks run late (`views_string_aggregation.install`).
- `hook_views_plugins_query_alter()` (`.module`) swaps the core `views_query` plugin **class** for a
  backend-specific subclass picked from `\Drupal::database()->databaseType()`:
  `MySql` (mysql/mariadb), `PgSql` (pgsql), `Sqlite` (sqlite). Unsupported types just log a notice.
- This automatic swap is gated by config `extend_views_query_plugin` (default TRUE). Set it FALSE +
  `drush cr` to instead assign query plugins per base table via `hook_views_data()`
  (`query_id` = `vsa_views_query_mysql` / `_pgsql` / `_sqlite`).
- `hook_config_schema_info_alter()` adds `vsa_separator`, `vsa_order_by`, `vsa_order_direction`,
  `vsa_max_length` to the `views.query.views_query` schema.

## Key facts
- **Portable across the three supported backends** — the module emits the right function per DB
  (MySQL/MariaDB + SQLite → `GROUP_CONCAT`; PostgreSQL → `STRING_AGG`), so the same view config works
  on all three. Only genuinely unsupported databases (e.g. SQL Server, Oracle) are unhandled.
- **MySQL/MariaDB silently truncate at `group_concat_max_len` (1024 bytes default), no error.** The
  MySQL-only max-length query option sets session `group_concat_max_len` to raise the ceiling; range
  4 … 4294967295. Watch this when validating large-group reports.
- **Backend quirks:** PostgreSQL `DISTINCT` forces ORDER BY to the aggregated field; SQLite `DISTINCT`
  ignores a custom separator (defaults to comma). Both are by database design, documented in source.
- Fills a real gap: core Views aggregation (COUNT/SUM/MIN/MAX/AVG) reduces a group to a number; this
  answers "which values".

## Plugins provided
- Query: `vsa_views_query_mysql`, `vsa_views_query_pgsql`, `vsa_views_query_sqlite`
  (base `VsaBase extends` core `Sql`). Register aggregation types in `getAggregationInfo()`:
  `string_aggregation` → `vsaAggregationMethodSimple`, `string_aggregation_distinct` →
  `vsaAggregationMethodDistinct`.
- Filter + contextual filter: `groupby_string` (`Plugin/views/filter`, `Plugin/views/argument`) —
  filter the aggregated value via `HAVING` clauses (not `WHERE`).

## Files / further reading
- `agent/plugins/query-and-handlers.md` — full mechanism: SQL each backend emits, the query options,
  and the filter/argument HAVING handlers.
- `usage.md` — setup steps, all options, gotchas, and use cases.

## Security
Reviewed 1.0.2: **clean.** SQL is assembled defensively — separator via `Connection::quote()` (and `;`
rejected), order-by field validated against a whitelist of the view's real fields, direction
whitelisted ASC/DESC, max-length integer-cast + range-checked before `SET SESSION`, and all
filter/argument operators use bound placeholders with `escapeLike()`. No public routes; query config
requires the "administer views" permission.
