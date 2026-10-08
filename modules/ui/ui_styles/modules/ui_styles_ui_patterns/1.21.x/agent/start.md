<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Styles UI Patterns — agent index

Bridges UI Styles and UI Patterns (2.x) with **one** UI Patterns Source plugin,
`ui_styles_attributes`, usable on any component prop of type `attributes`. No route,
permission, or settings page — configuration lives inside each component's source config.

- **The source plugin: id, prop type, settings, config shape, how classes reach the prop** →
  [plugins/styles-source.md](plugins/styles-source.md)

Key facts:
- Source id `ui_styles_attributes` (`AttributesStyles`), `prop_types: ['attributes']`,
  discovered by `plugin.manager.ui_patterns_source`.
- Settings: `styles` (a `ui_styles.selected_mapping`) + `extra` (extra HTML attributes).
  Schema `ui_patterns_source.ui_styles_attributes`.
- `getPropValue()` merges selected + extra classes into the attributes `class` array.
- Requires both `ui_patterns` and `ui_styles` enabled.
