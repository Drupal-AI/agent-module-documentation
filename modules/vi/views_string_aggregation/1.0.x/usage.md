<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views String Aggregation adds two field aggregation types to Views — "String aggregation" and "String aggregation DISTINCT" — that concatenate the values in each group into one string using the database's native aggregate function (`GROUP_CONCAT` on MySQL/MariaDB and SQLite, `STRING_AGG` on PostgreSQL), so a grouped view can list each group's values instead of only counting them.

---

Core Views aggregation reduces a group to a number (COUNT/SUM/MIN/MAX/AVG); the question a report usually asks is "which values", not "how many". This module answers that at the SQL level. Enable "Use aggregation" on a view, add the field you want to collapse, and set its Aggregation type to **String aggregation** or **String aggregation DISTINCT**; the group's values come back as one separated string on a single row. Integration is automatic and needs no per-view plumbing: on install the module bumps its module weight, and `hook_views_plugins_query_alter()` swaps the core `views_query` plugin class for a database-specific subclass (`VsaBase extends` core `Sql`) chosen from `\Drupal::database()->databaseType()` — `MySql`, `PgSql`, or `Sqlite`. That subclass registers the extra aggregation types in `getAggregationInfo()` and builds the correct SQL for the detected backend, so the same view configuration is portable across all three supported databases; an unsupported backend just logs a notice and behaves like stock Views. When aggregation is on, extra per-view options appear under **Advanced > Other > Query settings**: a **separator** (default `,`), an **order-by field** (a select limited to the view's own fields) with **ASC/DESC** direction, and — MySQL/MariaDB only — a **maximum length** that sets the session `group_concat_max_len`. The chief real-world gotcha is that MySQL/MariaDB silently truncate a `GROUP_CONCAT` result at `group_concat_max_len` (1024 bytes by default) with no error; the max-length option exists precisely to raise that ceiling for large groups. Two backend quirks the module documents: with PostgreSQL `DISTINCT` the ORDER BY must use the aggregated field itself, and with SQLite `DISTINCT` a custom separator is not supported (SQLite falls back to its default comma). The module also ships `groupby_string` Views filter and contextual-filter handlers that filter on the aggregated value using `HAVING` (rather than `WHERE`), with the usual string operators (equals, contains, starts/ends with, regex, length, empty). Security-wise the SQL assembly is guarded: the separator is passed through `Connection::quote()` (and semicolons are rejected in validation), the order-by field is validated against a whitelist of the view's real fields, the direction is whitelisted to ASC/DESC, the max-length is integer-cast and range-checked before the `SET SESSION` statement, and all filter/argument operators use bound placeholders with `escapeLike()`.

---

- Install with `composer require drupal/views_string_aggregation`, then `drush en views_string_aggregation` and `drush cr`.
- Depends only on core `views`; targets Drupal `^10 || ^11`.
- In a view, turn on **Use aggregation** under Advanced settings, then add the field to aggregate.
- Set that field's **Aggregation type** to **String aggregation** (all values) or **String aggregation DISTINCT** (deduplicated values).
- Group by whatever column defines the rows (e.g. node id, content type); the aggregated field collapses per group.
- Configure the concatenation under **Advanced > Other > Query settings** once aggregation is enabled.
- **Separator** option: characters placed between concatenated values, default `,`, max 5 chars; a `;` is rejected by validation.
- **Order concatenated values by**: a select restricted to the current display's fields, so you cannot point it at an arbitrary column.
- **Order direction**: Ascending or Descending, applied inside the aggregate function.
- **Concatenated values maximum length** (MySQL/MariaDB only): sets session `group_concat_max_len`; `0` keeps the database default; valid range 4 to 4294967295 bytes.
- Backend detection is automatic — MySQL/MariaDB and SQLite emit `GROUP_CONCAT(...)`, PostgreSQL emits `STRING_AGG(...)`.
- PostgreSQL `DISTINCT`: the ORDER BY is forced to the aggregated field (Postgres cannot order a `STRING_AGG(DISTINCT ...)` by a different field).
- SQLite `DISTINCT`: a custom separator is ignored (SQLite `GROUP_CONCAT(DISTINCT ...)` supports no separator argument); ordering still works.
- **MySQL truncation gotcha**: results longer than `group_concat_max_len` (1024 bytes default) are silently cut off with no error — raise the max-length option or bound the group size and spot-check long groups.
- Use the `groupby_string` filter/contextual filter to filter on the aggregated string; these emit `HAVING` clauses (post-aggregation), not `WHERE`.
- Filter operators: equals, contains, contains-any/all-word, starts/ends with (and negations), not-like, shorter/longer than, regex, empty/not-empty.
- The `groupby_string` filter reports `canGroup() = FALSE`, so it cannot itself be placed in a filter group.
- Disable automatic integration by setting `extend_views_query_plugin: false` in `views_string_aggregation.settings`, then `drush cr`.
- With automatic integration off, assign a query plugin per base table in `hook_views_data()`: `$views_data['table']['base']['query_id'] = 'vsa_views_query_mysql'` (or `_pgsql` / `_sqlite`).
- Only config schema is added (`views.query.views_query` gains `vsa_separator`, `vsa_order_by`, `vsa_order_direction`, `vsa_max_length`); the module defines no permissions, routes, or Drush commands.
- Good fits: tags/terms per node, order-item titles per order, authors per publication, roles per user, flat CSV/REST exports from grouped data.
- Aggregation runs in SQL, so it is efficient, but very large groups can still be heavy; prefer DISTINCT where duplicates are expected.
- The kernel tests (`tests/src/Kernel/Query/`) cover basic and distinct aggregation, separators, ordering, exposed filters, and MySQL max-length.
