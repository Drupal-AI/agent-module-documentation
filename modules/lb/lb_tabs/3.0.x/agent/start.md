<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tabs And Accordion Layout (lb_tabs) — agent index

Provides two Drupal **Layout Builder layout plugins** — `lb_tabs_tabs` (Tabs) and
`lb_tabs_accordion` (Accordion) — that render a section's blocks as a jQuery UI tab
strip or accordion instead of a stacked column. Both extend one base class and share
the same three per-layout settings.

- Depends on contrib modules `jquery_ui_tabs` and `jquery_ui_accordion` (the jQuery UI
  components removed from core after Drupal 9).
- Core requirement `^9 || ^10 || ^11`.
- **No** routes, permissions, drush commands, config entities, `.module`/`.install`, or
  services. **No** settings page (`configure` is null) — settings are set per section in
  the Layout Builder UI.
- Ships config **schema** (`config/schema/lb_tabs.schema.yml`), templates, JS behaviors,
  CSS, and a `libraries.yml`.

## Solution docs
- **Add/operate the tabs or accordion layout, its settings, regions, and rendering** →
  [plugins/layouts.md](plugins/layouts.md)

## Key facts
- Layout plugin ids: `lb_tabs_tabs`, `lb_tabs_accordion` (annotation category `Effects`,
  labels `Tabs` / `Accordion`).
- Base class: `Drupal\lb_tabs\Plugin\Layout\LbTabsLayoutBase` (extends core
  `LayoutDefault`); subclasses `TabsLayout`, `AccordionLayout`.
- Settings keys (config schema type `lb_tabs`): `initially_active_item` (integer),
  `collapsible` (boolean), `labels_from_blocks` (boolean).
- Config schema types: `layout_plugin.settings.lb_tabs`,
  `layout_plugin.settings.lb_tabs_accordion`.
- Regions: `content_blocks` (default) and, for tabs with `labels_from_blocks`,
  `label_blocks`.
- Templates: `lb-tabs-tabs` (`layouts/tabs/lb-tabs-tabs.html.twig`), `lb-tabs-accordion`
  (`layouts/accordion/lb-tabs-accordion.html.twig`).
- Libraries: `lb_tabs/tabs`, `lb_tabs/accordion` (front-end, JS+CSS), and
  `lb_tabs/tabs_in_lb`, `lb_tabs/accordion_in_lb` (CSS-only, used inside the LB editor).
- JS behaviors: `Drupal.behaviors.lb_tabs`, `Drupal.behaviors.lb_tabs_accordion` — read
  `drupalSettings[pluginId][domId]` and call jQuery UI `.tabs(options)` / `.accordion(options)`.
