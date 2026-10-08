<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TabPanelWidget Quick Tabs (tabpanelwidget_quicktabs) — agent index

Submodule of **tabpanelwidget**. Adds a **Quick Tabs `TabRenderer` plugin** so a Quick Tabs
instance renders as responsive/accessible TabPanelWidget tabs-or-accordion. Package `Custom`.
Core `^9 || ^10`. License GPL-2.0-or-later. Version 3.0.0. Depends on **`tabpanelwidget`** and
**`quicktabs`**.

- **The renderer plugin, its per-instance options form, and render flow** →
  [plugins/tab-renderer.md](plugins/tab-renderer.md)

## What it actually is

- **One plugin:** `Drupal\tabpanelwidget_quicktabs\Plugin\TabRenderer\TabPanelWidget` (annotation
  `@TabRenderer(id = "tabpanelwidget", name = "TabPanelWidget")`), extending
  `Drupal\quicktabs\TabRendererBase`. Selected as the renderer when editing a Quick Tabs instance.
- **No** routes, permissions, services, hooks, config schema, or Drush. **No** config object of its
  own — per-instance options live inside the Quick Tabs instance config under a `tabpanelwidget` key.
- Ships one CSS library `tabpanelwidget_quicktabs.global`
  (`css/tabpanelwidget-quicktabs.css`), attached at render for `.tpw-qt-panel-title` styling of
  block titles shown inside panels.
- Instantiates the builder with **`new Tpw()`** (the injected-service path is commented out).

## Render flow (`render(QuickTabsInstance $instance)`)

Reads `$instance->getOptions()['tabpanelwidget']`, pushes element/behavior/tab-style/tab-options/
accordion-options into the `Tpw`, then for each configured tab: creates the tab-type plugin via
`plugin.manager.tab_type`, renders it, skips it when empty and *hide empty tabs* is on, optionally
prepends a `tpw-qt-panel-title` container with the block title, marks the instance's default tab,
and `addItem($tab['title'], $content, $default)`. Returns `Tpw::build()` plus the
`tabpanelwidget_quicktabs/tabpanelwidget_quicktabs.global` library.

See parent [../../../../3.0.x/agent/api/tpw.md](../../../../3.0.x/agent/api/tpw.md) for the `Tpw`
builder and [../../../../3.0.x/agent/config/settings.md](../../../../3.0.x/agent/config/settings.md)
for the defaults these per-instance options fall back to.
