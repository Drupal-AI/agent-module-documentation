<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Display Union adds a Views display type (`union`) that combines the results of several displays in the same view into one list with a SQL `UNION`, so a single page can list rows that no single query could produce, sorted and paged as one set.

---

Views builds one query per display, and that query has one base setup with one set of contextual filters and relationships. A listing that must logically OR two or more result sets — the same content pulled through different contextual filters, or through different relationships — ordered together and paged as one, cannot be expressed that way. The usual workarounds are a view per case rendered in sequence (no combined sorting or paging), Search API (powerful, but a whole indexing stack for what is really a query problem), or a hand-written query. This module adds a fourth option: a **Union** display that you configure with the same fields, contextual filters and sort criteria as a "main" page or block display, then attach to it via the display's **Attach to** option. At run time `hook_views_pre_execute` clones the view onto each attached union display, builds its query and count query, and appends them to the main query with the core `Select::union()` method — so the row style, sorting and paging of the main display apply to the merged result set. The union display carries the `displays` option (config schema key `views.display.union`), validates that its field list and contextual filters match the main display, and requires that any exposed filter it uses also exist on the main display. The only dependency is core `views`, and `core_version_requirement` is `^10.2 || ^11 || ^12`.

---

- Logically OR two result sets that use different contextual filters into one list.
- Combine rows reached through different relationships in a single view.
- Page across the merged results as one set.
- Sort a combined list by a shared field.
- Avoid Search API for a simple combined listing.
- Build a unified activity feed from several displays.
- Show recent items gathered by more than one filter set.
- Produce a single RSS feed from several displays.
- Merge two filtered lists into one output.
- Build a "latest across the site" style page.
- Combine results without writing custom SQL.
- Reuse existing displays' fields as the union template.
- Attach one union display to multiple main displays.
- Keep combined sorting and paging that a sequence of views cannot give.
- Aggregate several content sources under one row style.
- Union a page and its matching count query for correct pager totals.
- Match a union display's fields and sorts to the main display.
- Prepare a combined listing for Drupal 11 or 12.
