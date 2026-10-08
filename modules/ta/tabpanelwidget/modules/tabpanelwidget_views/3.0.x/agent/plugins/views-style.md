<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "TabPanelWidget" Views style plugin

`Drupal\tabpanelwidget_views\Plugin\views\style\TabPanelWidget` — `@ViewsStyle`
(id **`tabpanelwidget_views`**, title "TabPanelWidget", theme `views_style_tabpanelwidget_views`,
`display_types = {"normal"}`), extending `StylePluginBase`. Flags: `usesRowPlugin = TRUE`,
`usesFields = TRUE`, `usesRowClass = TRUE`.

## Install & use

```bash
composer require drupal/tabpanelwidget    # provides this submodule
drush en tabpanelwidget_views -y          # pulls in tabpanelwidget + views
```

Edit a View → **Format** → choose **TabPanelWidget**. Under the style settings, set the **grouping
field** (required) — its value becomes each tab/accordion header — and the TabPanelWidget options.
Tip (shown in the form): hide the grouping field from display if you don't want it repeated inside
each panel body.

Like the sibling plugins, `__construct()` sets `$this->tpw = new Tpw();` (the injected-service path
is commented out).

## Options (`defineOptions()`)

- `first_row_default` (default **TRUE**) — mark the first grouping set as the default/open item.
- `tabpanelwidget_settings` (default = current `tabpanelwidget.settings`): nested
  `main_settings.{elements,behavior}`, `tab_settings.{tab_style,tab_options}`,
  `accordion_settings.{accordion_options}`.

(The config schema `views.style.tabpanelwidget_views` declares a `wrapper_class` string, but the
plugin code never reads or sets it — it is effectively dead.)

## Options form (`buildOptionsForm()`)

- Iterates `$form['grouping']`: makes level 0 required (`#required = 1`, `rendered` default TRUE and
  its `rendered`/`rendered_strip` controls hidden), and **unsets grouping levels > 0** — only one
  level of grouping is allowed. Rewrites the grouping-field description to explain it becomes the tab
  title.
- Adds **`first_row_default`** checkbox ("Use first row as default item?"): if checked the first tab/
  section is open on load; uncheck to have an accordion fully collapsed on load.
- Adds the TabPanelWidget settings (same fields as the base module): **Main** (`elements` `h2`–`h5`,
  `behavior`), **Tab settings** (`tab_style`, `tab_options` `centered`/`rounded`; `#states`-shown for
  behavior `responsive`/`tabpanel`), **Accordion settings** (`accordion_options` `disconnected`/
  `icons_at_the_end`/`chevrons_east_south`/`plus_minus`/`animate`; shown for `responsive`/
  `accordion`). Defaults fall back to `tabpanelwidget.settings`.

## Render (`renderGroupingSets($sets, $level = 0)`)

Overrides the base grouping renderer (comment admits it "should be replaced with theme functions and
templates"):

1. `$this->tpw->reset()` — reload options + clear items (Views may reuse one plugin instance across a
   page, so reset avoids leaking items between renders).
2. Apply `setElements/setBehavior/setTabStyle/setTabOptions/setAccordionOptions` from
   `$this->options['tabpanelwidget_settings']`.
3. For each `$set`: `$default = ($first_set && $this->options['first_row_default'])`; for each row
   build a `#type => container` with class `views-row` wrapping
   `$this->view->rowPlugin->render($row)`; then `addItem($set['group'], $set_content, $default)`.
4. Return `$this->tpw->build()`.

Because each row is produced by the View's configured **row plugin**, field/entity access and
formatting are handled by Views exactly as for any other style — this plugin only regroups the
rendered rows into TabPanelWidget panels. The group label (`$set['group']`) is passed to
`addItem()` as the title and emitted as `#markup` (core applies `Xss::filterAdmin` at render). See
the parent [Tpw builder doc](../../../../3.0.x/agent/api/tpw.md).
