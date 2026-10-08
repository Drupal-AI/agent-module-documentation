<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TabPanelWidget Views (tabpanelwidget_views) — agent index

Submodule of **tabpanelwidget**. Adds a **Views style plugin** that groups rows into responsive/
accessible TabPanelWidget tabs-or-accordion panels. Package `Custom`. Core `^9 || ^10`. License
GPL-2.0-or-later. Version 3.0.0. Depends on **`tabpanelwidget`** and **`views`**.

- **The style plugin, its options form, grouping requirement, and render flow** →
  [plugins/views-style.md](plugins/views-style.md)

## What it actually is

- **One plugin:** `Drupal\tabpanelwidget_views\Plugin\views\style\TabPanelWidget` — annotation
  `@ViewsStyle(id = "tabpanelwidget_views", title = "TabPanelWidget", theme =
  "views_style_tabpanelwidget_views", display_types = {"normal"})`, extending `StylePluginBase`.
  `usesRowPlugin = TRUE`, `usesFields = TRUE`, `usesRowClass = TRUE`.
- Config schema `views.style.tabpanelwidget_views` (`config/schema/tabpanelwidget_views.schema.yml`)
  declares only a `wrapper_class` string — **note: `wrapper_class` is not actually used** by
  `defineOptions()`/`buildOptionsForm()`/`renderGroupingSets()`; the plugin's real options live under
  `tabpanelwidget_settings` + `first_row_default`.
- **No** routes, permissions, services, hooks, or Drush. Builds the widget with **`new Tpw()`**.

## Behavior

- Requires **one** grouping field (the form forces `grouping[0]` required and removes deeper grouping
  levels); the group value becomes each tab/accordion **header**.
- Options form exposes the same TabPanelWidget settings as the base module (element, behavior, tab
  style, tab options, accordion options), defaulting to `tabpanelwidget.settings`, plus
  **`first_row_default`** ("Use first row as default item?", default TRUE) — whether the first group
  is open on load.
- `renderGroupingSets($sets)` calls `tpw->reset()`, applies options, then for each set renders its
  rows via `$this->view->rowPlugin->render($row)` (wrapped in a `views-row` container) and
  `addItem($set['group'], $set_content, $default)`; returns `Tpw::build()`.

Row/field/entity access is enforced by Views' normal row rendering. See parent
[../../../../3.0.x/agent/api/tpw.md](../../../../3.0.x/agent/api/tpw.md) (Tpw builder) and
[../../../../3.0.x/agent/config/settings.md](../../../../3.0.x/agent/config/settings.md) (defaults).
