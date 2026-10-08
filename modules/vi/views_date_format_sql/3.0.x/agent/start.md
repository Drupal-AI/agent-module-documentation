<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Date Format SQL — agent index

Formats timestamp fields in SQL (`DATE_FORMAT`) instead of PHP so the result can be a
GROUP BY key for Views aggregation. No global config page (`configure` null), no
permissions, no Drush. Config schema stores per-handler options. It auto-swaps the
default handler on Field-API `timestamp` fields via `hook_views_data_alter()`.

- **Enabling SQL date formatting on a field/argument, the options, aggregation, timezone,
  and how the handler swap works** → [configure/handlers.md](configure/handlers.md)

Key facts:
- Field handler `views_date_format_sql_field` extends core `EntityField`; argument handler
  `views_date_format_sql_argument` extends core `NumericArgument`.
- Per-handler checkbox "Use SQL to format date" (`format_date_sql`, default FALSE). Off →
  behaves exactly like the core handler.
- The **argument** adds a free-text "Date Format" field (`format_string`).
