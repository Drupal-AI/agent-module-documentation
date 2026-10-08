<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Table Rowspan (views_table_rowspan) — agent index

Provides one Views **style plugin**, `table_rowspan` (title "Table Rowspan"), that extends
the core table style and merges repeated cells in a grouped column using the HTML `rowspan`
attribute — a category shown once against its whole group instead of on every row. Chosen as a
view's display **format** in place of the standard table; everything else about the view is
unchanged and the choice is reversible with one setting.

Depends on core `views`. Core requirement `^10 || ^11`. No settings page (`configure: null`),
no permissions, no services, no drush, no config schema of its own — all configuration lives in
the view's own style options.

- **Select and configure the style on a view (the `rowspan` option, how grouping drives merging, the render/preprocess mechanics, CSS)** → [views/table-rowspan.md](views/table-rowspan.md)

Key facts:
- Plugin id `table_rowspan`; class `Drupal\views_table_rowspan\Plugin\views\style\TableRowSpan`
  extends `Drupal\views\Plugin\views\style\Table`; annotation `theme = "views_view_table"`,
  `display_types = {"normal"}`.
- Adds one style option, **`rowspan`** (boolean, default `TRUE`), rendered as the checkbox
  "Merge rows in table" in the style options form.
- Merging is driven by the core Table **`grouping`** option — the grouped field's repeated
  values are what get merged. No grouping configured ⇒ behaves like a plain table.
- `views_table_rowspan_preprocess_views_view_table()` reads `$view->rowspan` and, per group,
  sets `rowspan="N"` + class **`cell-rowspan`** on the first cell and `style="display:none"` on
  the duplicate cells. Uses core template `views-view-table.html.twig`; ships no CSS/library.
- Help route `help.page.views_table_rowspan`. No `.routing.yml`, `.permissions.yml`,
  `.services.yml`, `.libraries.yml`, `config/`, or `.install`.
