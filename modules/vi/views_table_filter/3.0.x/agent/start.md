<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Table Filter (views_table_filter) — agent index

**Moves a Views table display's exposed filters into their matching table-header columns (via Better Exposed Filters).**

- **Version:** 3.0.x  •  core `^10 || ^11`  •  package Views  •  deps: views, better_exposed_filters
- **Mechanism:** form-alter only — no routes, permissions, services, or config entities.
  - `hook_form_views_ui_edit_display_form_alter`: adds per-filter "Move filter to the table column" select under BEF advanced settings.
  - `hook_form_views_exposed_form_alter`: marks the view and adds a hidden `views_table_filter` input when table filters are configured.
  - `hook_preprocess_views_view_table`: injects header placeholders + `drupalSettings` filter→identifier map.
- **Library/JS:** `views_table_filter.core` clones exposed widgets into header cells and syncs values back.
- **Security:** no anonymous/mutating endpoints; operates on site-builder view config, not request data; header class via `Html::cleanCssIdentifier()`. No security findings.