<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Semantic Views — agent index

Two Views plugins that let you control a view's output **markup** (element type + attributes for
the wrapper/list/rows/fields) from the Views UI, no template needed. Requires core `views`. **No
settings page, routes, permissions, or Drush** — everything lives in the view's display config.

- **The style + row plugins, all their options, and the `attribute|value` / `{{ row_index }}` syntax** →
  [plugins/views-plugins.md](plugins/views-plugins.md)
- **Templates, preprocessors, and the `semanticviews_extract_attributes()` helper** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Style plugin id `semanticviews_style` ("Semantic Views Style"); row plugin id
  `semanticviews_row` ("Semantic Views Row").
- Settings stored in the view's display options (config schemas
  `views.style.semanticviews_style`, `views.row.semanticviews_row`).
- Attributes are entered one per line as `attribute|value` (bare line = key and value); values
  are token-replaced and support `{{ row_index }}` (0-based row number).
- It only changes emitted HTML, not the query/results.
