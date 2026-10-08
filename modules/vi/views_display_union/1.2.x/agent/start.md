<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Display Union (views_display_union) — agent index

Adds a Views **display plugin** (`id: union`) that combines its own result set with one or more
"main" displays in the same view using a SQL `UNION`. You add a union display to a view, list its
fields/filters/arguments to match a page or block display, and set its **Attach to** option to that
main display. At run time the module UNIONs the union display's query into the main display's query,
so sorting, paging and the row style all apply to the **combined** result set. Useful to logically
OR result sets that use different contextual filters or relationships but expose the same fields.

- Dependency: core `views`. Core requirement: `^10.2 || ^11 || ^12`.
- No routes, no permissions, no drush, no settings page (`configure` is null).
- Configured per view: the union display's **Attach to** option (`displays`).

Solution docs:
- **Add and configure a union display — options, validation rules, runtime mechanism, config schema**
  → [views/union-display.md](views/union-display.md)

Key facts (real machine names):
- Display plugin: `Drupal\views_display_union\Plugin\views\display\Union`, id `union`, title "Union".
- Display option: `displays` — array of main display ids this union attaches to. Config schema key
  `views.display.union`, mapping `displays` (sequence of strings).
- Hook service: `Drupal\views_display_union\Hook\ViewsDisplayUnionHooks` (autowired). Implements
  `hook_views_pre_execute` (builds the UNION), `hook_views_ui_display_tab_alter` (hides UI rows in
  the Views UI for union displays), `hook_help`.
- The UNION is built with core `Select::union()` on the compiled Views queries — both `query` and
  `count_query`. Union displays are discovered through the main display's `getAttachedDisplays()`.
