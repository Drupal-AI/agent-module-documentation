<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views collapsible lists (views_collapsible_list) — agent index

**Views style plugin** `collapsible_list` that renders a view's rows as an expandable/collapsible
`<ul>`. Selected fields are hidden on load and toggled per-row with jQuery. Depends on core `views`.
Version **8.x-1.6**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Mechanism (confirmed from source)
- `src/Plugin/views/style/CollapsibleList.php` — `@ViewsStyle(id = "collapsible_list", theme =
  "views_view_collapsible_list")`, **extends `Drupal\views\Plugin\views\style\HtmlList`**. Adds one
  option, `collapsible_fields` (a `checkboxes` element listing the view's field labels). Forces
  `type` = `ul` and `wrapper_class` = `views-collapsible-list` as fixed `#value`s.
- `views_collapsible_list.module` — `template_preprocess_views_view_collapsible_list()` calls
  `template_preprocess_views_view_list()`, attaches the `views_collapsible_list/collapse` library,
  maps each selected field to a `.views-field-<Html::cleanCssIdentifier(name)>` selector and passes
  them via `drupalSettings.viewsCollapsibleList.fields`, and sets `section_class` =
  `'btn--' . (timestamp + rand(1,9999))` for per-section button scoping. Also implements
  `hook_help()` (renders README).
- `templates/views-view-collapsible-list.html.twig` — per group: two buttons (`Collapse All` /
  `Expand All`, class `section_class`), an optional `<h3>{{ title }}</h3>` group heading, then a
  `<ul>` of `<li>` rows, each with a `<span class="collapse-expand-toggle">` trigger and a
  `<div class="views-fields">{{ row.content }}</div>`.
- `js/views-collapsible-list.js` — jQuery `Drupal.behaviors`. On attach: add `js-collapsible` +
  `.hide()` to the configured field selectors; wire the per-row toggle span (`.toggle('slow')`,
  toggles `js-expanded`) and the Collapse/Expand-All buttons (`.show/.hide('slow')`, manage the
  `disabled` attribute). Library deps: `core/jquery`, `core/drupalSettings`, `core/drupal`.
- `config/schema/views_collapsible_list.schema.yml` — `views.style.collapsible_list` mapping
  (`type`, `collapsible_fields` sequence, `wrapper_class`, `class`).

## Configuration
No admin route. Configure inside a view: Format → Style → **Collapsible List**, then the style
settings expose the **Collapsible fields** checkboxes (the fields to hide/toggle). Supports Views
grouping; grouped sections toggle independently.

## Caveats agents should know
- **Not native `<details>`/`<summary>`.** Disclosure is jQuery show/hide.
- **No built-in a11y.** The trigger is a non-focusable `<span>` with no `aria-expanded`; keyboard /
  screen-reader operation is not provided.
- **Hidden ≠ absent.** Collapsed content is fully rendered in the DOM, queried, and findable by
  browser in-page search — hiding is presentational only.
- Row/field content flows through the normal Views field render pipeline (autoescaped).

## Files
- `data.json` — metadata.
- `usage.md` — short / dense / use-case bullets.
- `agent/plugins/collapsible-list-style.md` — the style plugin in detail.
