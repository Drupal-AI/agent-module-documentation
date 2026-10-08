<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Sort Expression adds a single Views sort handler that lets you order a view by any SQL expression you type in, instead of only by a plain field or column. It is an advanced tool for custom orderings that the built-in sort handlers cannot express.

---

The module registers one Views sort plugin, `views_sort_expression` (`@ViewsSort("views_sort_expression")`), and exposes it in Views data as a global "Expression" sort under the special `views` table (via `hook_views_data_alter()`). When you add this sort to a view you get a free-text "Expression" textarea plus an "Expression has an aggregate function" checkbox. At query time the handler calls the Views SQL query's `addOrderBy(NULL, <expression>, <order>, <alias>)`, so whatever you type becomes the ORDER BY term verbatim, ordered ASC or DESC like any sort. Because the expression is added to the query directly, you may reference anything already present in the compiled SQL — column aliases, joined fields, CASE statements, functions, aggregates. The catch: the field or formula you want to use must actually exist in the generated query, so the module's own help advises enabling "Show the SQL query" on the Views settings page to discover the real aliases, and adding the needed fields/sorts elsewhere in the view first. The aggregate checkbox tells the module the expression contains an aggregate function (SUM, COUNT, MAX, …); when set, `hook_views_post_build()` removes this sort's alias from the query's GROUP BY so the aggregate sort works instead of being grouped. It has no configuration page, no permissions of its own (adding a sort requires the standard `administer views`), and only a config schema for the two stored options. This is an admin/site-builder tool — you must understand the view's SQL to use it safely and correctly.

---

- Sort a numeric-field view so that empty (NULL) values always land last, e.g. `ORDER BY field_value IS NULL, field_value`.
- Put chosen content types on top with a custom priority, e.g. `CASE WHEN node_field_data.type = 'article' THEN 0 ELSE 1 END`.
- Order rows by a computed value such as `field_price * field_quantity`.
- Sort case-insensitively with `LOWER(node_field_data.title)`.
- Sort by string length using `CHAR_LENGTH(field_body_value)`.
- Randomize with a database-specific expression like `RAND()`.
- Order by the absolute value or a rounded value of a numeric column.
- Sort by a date part, e.g. by month with `MONTH(FROM_UNIXTIME(node_field_data.created))`.
- Push a specific promoted item to the very top with `CASE WHEN nid = 42 THEN 0 ELSE 1 END`.
- Order by a boolean flag first, then fall back to another sort added after it.
- Sort by a coalesced value, e.g. `COALESCE(field_override_weight, field_default_weight)`.
- Order by the result of a string comparison or a `LIKE`-based bucket.
- Sort search-style listings by a manually assembled relevance formula.
- Combine several columns into one weighted score and sort by it.
- Sort by an aggregate such as `COUNT(comment.cid)` (tick the aggregate checkbox).
- Order grouped rows by `SUM(field_amount)` or `MAX(field_date)` with the aggregate option on.
- Sort by distance/ordering formulas that reference already-joined geo columns.
- Order by a taxonomy term's weight or another joined field's alias.
- Sort so that future-dated content appears before past content via a CASE on the timestamp.
- Order by whether a text field starts with a given prefix.
- Reproduce a "custom sort order" list (explicit id-to-rank mapping) with a large CASE expression.
- Sort a report so incomplete rows (missing a required column) sink to the bottom.
- Break ties from a preceding sort handler by adding an expression sort as a secondary criterion.
- Order by a modulo/bucketing expression to interleave results.
- Sort by an expression referencing a field only added elsewhere in the view purely to make its alias available.
