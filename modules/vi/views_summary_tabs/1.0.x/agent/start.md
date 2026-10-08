<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Summary Tabs (views_summary_tabs) — agent index

Adds one **Views style plugin**, `tabs_summary`, that renders a view's **argument summary** as a
horizontal row of **tabs** instead of the default unformatted list of links. A *summary* is what a
display shows when a **contextual filter** has no value and its "When the filter value is NOT
available" action is set to **"Display a summary"**: the distinct values that exist for that
argument, each with an optional count, each linking to the filtered result — the mechanism behind an
A–Z glossary, a browse-by-year archive, or a browse-by-category page. This module changes only the
*presentation* of that summary; the rows, links and counts are produced by Views core
(`DefaultSummary`, which this plugin extends).

Mechanism: the plugin (`id: tabs_summary`, `display_types = {"summary"}`, theme
`views_view_summary_tabs`) adds a single `classes` option (default `tabs tabs--primary`) and hands
rendering to `templates/views-view-summary-tabs.html.twig`, which emits
`<nav role="navigation"><ul class="{classes}"><li class="tabs__tab"><a class="tabs__link">…`. The
preprocess `template_preprocess_views_view_summary_tabs()` reuses Views core's summary preprocessing,
marks the **first** row active when none is, and attaches the `olivero/tabs` library when the active
theme is **Olivero** so the tabs pick up that theme's styling. These are navigation links, not
in-page tab panels — the real markup is a `nav` region + list of links, not a `role="tablist"`.

- Depends on: `drupal:views` (Views core). No other dependencies.
- Core: `^9 || ^10 || ^11`. Package: `Views`. Version 1.0.1.
- No settings page / `configure` route — all configuration is the per-display Views style options
  (the `classes` textfield plus the inherited summary options). No permissions, no services, no
  routes, no drush commands.
- Provides config schema (`views.style.tabs_summary`). Defines **one** plugin instance, not a plugin
  *type*.

## What you'd do → where

- **Set a display's summary to render as tabs, change the wrapper CSS classes, or understand the
  plugin / theme hook / preprocess / template** → [plugins/tabs-summary.md](plugins/tabs-summary.md)

## Key facts (real machine names)

- Views style plugin: `tabs_summary` — class
  `Drupal\views_summary_tabs\Plugin\views\style\TabsSummary`
  (`src/Plugin/views/style/TabsSummary.php`, extends
  `Drupal\views\Plugin\views\style\DefaultSummary`), title "Tabs",
  help "Displays the summary as a set of tabs.", `display_types = {"summary"}`,
  `theme = "views_view_summary_tabs"`.
- Style option (config key): `classes` (string), default `tabs tabs--primary`.
- Config schema: `views.style.tabs_summary` (type `views.style.default_summary`), mapping
  `classes: string` — file `config/schema/views_summary_tabs.views.schema.yml`.
- Theme hook: `views_view_summary_tabs` (variables `view`, `options`, `rows`) — declared in
  `views_summary_tabs_theme()` (`views_summary_tabs.module`); preprocess
  `template_preprocess_views_view_summary_tabs()` in `views_summary_tabs.theme.inc`; template
  `templates/views-view-summary-tabs.html.twig`.
- Conditional asset: library `olivero/tabs`, attached only when the active theme is `olivero`.
- Hooks implemented: `hook_theme`.
