<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Views Accordion (sva) — agent index

Views **style plugin** (id `simple_views_accordion`) that renders each result row as a collapsible native
HTML `<details>` element — a **JavaScript-free accordion**. The summary (header) of each item is the **first
field** of the row; when the display does not use fields (e.g. rows rendered as entities in a view mode) the
**entity label** is used instead. Project name `sva`, module machine name `simple_views_accordion`. Depends
only on core `views`. Version **2.0.1**. Core **`^11.3 || ^12`**.

Display/presentation style — the View's access governs what appears. Select it as the View's **Format**; no
settings page, no routes, no permissions, no services, no drush. Provides config schema; the `configure` route
is `null` (options are per view display).

v2.0 is a new major: it **requires Drupal 11.3+ / 12** (drops 9/10) and **removes the
`simple_views_accordion/simple_views_accordion` library** — no JS or CSS is shipped. Exclusive behaviour now
comes from the browser's **native exclusive accordion**: the `<details>` of one display share a unique `name`
attribute, so opening one closes the others. Two new options (`allow_multiple`, `open_first`) were added and the
plugin id was shortened from `simple_views_accordion_simple_views_accordion` to `simple_views_accordion`
(both handled by `post_update` hooks, so existing views upgrade cleanly).

## What you'd do → where

- **Enable the accordion on a view, set its options (wrapper class, allow-multiple, open-first), and understand
  how the summary/header and exclusive behaviour are produced** → [views-style/accordion.md](views-style/accordion.md)

## Key facts (real machine names)

- Views style plugin: **`simple_views_accordion`** — `Drupal\simple_views_accordion\Plugin\views\style\SimpleViewsAccordion`
  (extends core `StylePluginBase`), declared via `#[ViewsStyle(id: 'simple_views_accordion', theme: 'views_style_simple_views_accordion', display_types: ['normal'])]`.
  `usesRowPlugin = TRUE`, `usesRowClass = TRUE`.
- Theme hook: **`views_style_simple_views_accordion`** → template `templates/views-style-simple-views-accordion.html.twig`.
- Config-schema key: **`views.style.simple_views_accordion`** (`config/schema/simple_views_accordion.schema.yml`).
  Option keys: `wrapper_class` (string, default `item-list`), `allow_multiple` (bool, default `FALSE`),
  `open_first` (bool, default `FALSE`).
- Preprocess: `Drupal\simple_views_accordion\Hook\SimpleViewsAccordionHooks::preprocessViewsStyleSimpleViewsAccordion()`
  (OOP `#[Hook('preprocess_views_style_simple_views_accordion')]`) builds each row into a `#type => details`
  render element and assigns the shared exclusive-accordion `name` attribute.
- No library, no JavaScript, no CSS (the 1.0.x library was removed in 2.0.x).
- Defines no plugin *type*; it provides one Views **style** plugin instance.
- Upgrade path: `simple_views_accordion.post_update.php` — `..._rename_plugin_id` (renames the old doubled plugin
  id) and `..._add_style_options` (adds `allow_multiple`/`open_first` to existing views).
