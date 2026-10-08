<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ag-Grid (aggrid) — agent index

**Adds an ag-Grid JSON data-grid field to Drupal, with grid structures defined as `aggrid` config entities.**

- **Version:** 8.x-1.x (8.x-1.7)
- **Core:** ^9 || ^10.1 || ^11
- **Depends:** field, node
- **Routes:** `entity.aggrid.collection` `/admin/structure/aggrid`, add/edit/delete forms, and `aggrid.general` `/admin/config/content/aggrid/general` (all `_admin_route`).
- **Permissions:** `administer aggrid config entities`, `administer aggrid general settings` (both marked restrict-access / security implication).
- **Plugins:** field type `AggridFieldType`; widgets `AggridWidgetType`, `AggridJsonWidgetType`; formatters `AggridFormatterType`, `HtmlFormatterType`, `AggridPrevwarninglistFormatterType`; diff plugin `AggridFieldBuilder`.
- **Library:** ag-Grid Community + Enterprise builds are downloaded separately (Drush helper or manual).
- **Submodule:** `aggrid_demo`.

**Security:** All routes are admin, permission-gated, and both permissions are explicitly flagged as security-sensitive (a grid config drives rendered markup/JS). No anonymous or mutating public endpoints; no TLS/credential handling beyond the stored Enterprise license key in config.

See [configure/grids.md](configure/grids.md)