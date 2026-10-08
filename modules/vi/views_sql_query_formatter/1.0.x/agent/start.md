<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views SQL Query Formatter (views_sql_query_formatter) — agent index

**Pretty-prints and highlights the SQL query displayed above the Views UI live preview.**

- **Version:** 1.0.x  (info.yml `1.0.0-rc3`)
- **Core:** ^9 || ^10 || ^11
- **Whole module:** `views_sql_query_formatter.module` — `hook_form_view_preview_form_alter()` formats `$form['preview']['preview']['table']['#rows'][0][1]['data']['#context']['query']` via `SqlFormatter::format()`, attaches library `views_sql_query_formatter/styles`
- **No** routes, permissions, services, or plugins

**Security:** Presentation-only alter of the **Views UI preview form**, which is part of the Views administration UI and requires *administer views*. The SQL is only rendered where core already offers it (the "Show the SQL query" preview option) — so it exposes nothing to anonymous/non-admin users that Views admins can't already see; the query field is effectively gated by *administer views*. The query originates from the admin-built view definition, and it is placed into the preview's inline `#template`. No user-request input, no DB writes, no anonymous endpoints. (The `SqlFormatter` class is referenced globally and expected to be autoloadable/present.)
