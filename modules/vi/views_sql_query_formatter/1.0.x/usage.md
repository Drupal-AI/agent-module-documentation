<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views SQL Query Formatter improves the SQL query that Views optionally displays above the live preview in the Views UI, formatting and syntax-highlighting it so it is readable and copy-pasteable.

---

It implements `hook_form_view_preview_form_alter()`: when the preview form contains the query render element, it runs the query text through `SqlFormatter::format()`, adds line breaks before `AS`/`ON`/`IN` for indentation, switches the highlighter background to transparent, and strips `&quot;`, `{`, and `}` so the result can be pasted and run directly. The formatted markup replaces the preview's query `#template` and the module's CSS library is attached. That's the whole module — a single presentation-layer hook plus a stylesheet.

Because it only alters the **Views UI preview form**, the formatted SQL is shown exactly where core already shows the query (the "Show the SQL query" preview setting), which lives at the Views admin UI and requires the *administer views* permission. It does not create any route that exposes SQL to non-admins. Typical setup: enable the module and turn on "Show the SQL query" in the Views UI advanced settings; the query above the preview is now formatted.

---

- Format the SQL query shown in the Views UI preview
- Syntax-highlight a view's generated SQL
- Indent JOIN/ON/AS/IN clauses for readability
- Make the previewed query copy-paste ready
- Strip `{}` curly table-prefix braces from the shown query
- Debug a complex view by reading its formatted SQL
- Copy a view's SQL to run directly in a DB client
- Improve readability when tuning view performance
- Inspect how exposed filters change the generated SQL
- Teach/learn how Views builds queries
- Give the query panel a transparent, theme-friendly background
- Review joins added by relationships in a view
- Verify aggregation/group-by SQL produced by a view
- Compare SQL before/after changing a filter
- Keep the query readable while iterating in the preview
