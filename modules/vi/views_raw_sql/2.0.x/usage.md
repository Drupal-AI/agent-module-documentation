<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Raw SQL lets a designated user drop a hand-written SQL expression into a view as a field, a sort or a contextual filter (argument), for the cases the Views UI cannot express.

---

Views assembles its queries from handler plugins, and that set covers most needs but not free-form SQL: a computed column, a `CASE` that orders one status ahead of another, a window function, an aggregate the UI does not offer, or a `WHERE` clause keyed off a database function. Views Raw SQL supplies three handlers, all registered on a `#global` join so they appear in every view. A **Numeric Raw SQL field** (`field_views_raw_sql_numeric`, extends core `NumericField`) adds the expression with `$query->addField(NULL, $sql, 'raw_sql_field', $params)` and can be aggregated (sum/count/etc.) through the field's group-by form. A **Raw Sort** (`sort_views_raw_sql`) adds it with `$query->addOrderBy(NULL, $sql, $order, $id)` and deliberately cannot be exposed (`canExpose()` returns `FALSE`). A **Raw Argument** (`argument_views_raw_sql`, a contextual filter) adds it with `$query->addWhereExpression(0, $sql)`, and offers an extra `[argument]` placeholder that is substituted with the contextual-filter value. Every expression is first run through `\Drupal::token()->replace()`, so global tokens like `[site:name]` interpolate. The module does the important thing correctly at the boundary: the textarea only renders for a user holding the `edit views raw sql` permission, which is `restrict access: TRUE` and ships an explicit `warning:` — *"Raw SQL can expose sensitive site information, and could allow a malicious user to edit the site."* **Treat that permission as equivalent to raw database access, because it is.** Two operational caveats: the expression is validated by nothing (an invalid string simply breaks the view), and it is not portable — it binds the view to one database engine and will not be rewritten by anything that later alters the query. Version **2.0.0-alpha1** (2024), `^10.3 || ^11`, depends only on core `views`. Note that the module's `hook_views_data()` also advertises a "Raw Filter" handler, but no filter plugin class ships in this alpha, so only the field, sort and argument handlers actually work.

---

- Add a computed numeric column to a view via SQL.
- Sort rows by a SQL expression the UI cannot build.
- Order one status value ahead of another with a `CASE`.
- Compute a ratio or product across two existing fields.
- Use a database aggregate the aggregation UI does not offer.
- Add a window-function value to a result row.
- Rank results by a hand-written formula.
- Sort NULLs last explicitly.
- Compute an age or interval from a date column.
- Add a distance/haversine calculation in the query.
- Constrain a view with a `WHERE` expression via a contextual filter.
- Interpolate a global token (e.g. `[site:name]`) into an expression.
- Aggregate a raw expression (sum/count/min/max) through the field group-by.
- Prototype a query change without writing a custom handler.
- Add a subquery-derived value to a view.
- Produce a conditional numeric field.
- Add a calculated score column.
- Express a sort key the Views UI has no plugin for.
- Feed a contextual-filter value into a raw predicate through `[argument]`.
- Restrict raw-SQL editing to a single trusted role via the dedicated permission.
- Bridge to a legacy schema/column Views has no handler for.
- Reproduce a Views Calc style computed field on Drupal 10/11.
