<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Style Selector provides a visual Form API element plus two field types, widgets and formatters for picking a CSS class or a CSS color from a predefined list of allowed values. Selected classes/colors are applied to the rendered entity wrapper.

---

The module ships two field types — `style_selector_css_class` (Style list) and `style_selector_css_color` (Color list) — each an `options`-style list with an admin-defined `allowed_values` list. Two widgets render them as a Claro-styled swatch UI: `style_selector_tile_widget` (large tiles) and `style_selector_compact_widget` (compact radios/checkboxes), both supporting single or multiple selection, an empty option, and per-widget UI toggles (alpha grid, check icon, etc.). Two formatters — `style_selector_css_class_formatter` and `style_selector_css_color_formatter` — add the chosen value to the entity: the class formatter appends CSS class(es) to `#attributes['class']`, the color formatter writes an inline `<property>:<color> !important` style (target property configurable, e.g. `color` or `background-color`). Color values are validated and normalized by the `style_selector.css_color` service (hex is converted and stored as RGB/A; RGB/A, HSL/A, named/system colors and keywords like `transparent`/`currentColor` are accepted). A reusable `style_selector` render element lets custom forms (e.g. Layout Builder settings forms) embed the same picker. Module config at `/admin/config/user-interface/style-selector` (permission `administer site configuration`) lets you attach CSS libraries that define the actual class styles — as shared, theme-only, or admin-only libraries — and register extra global class/color values. There are no module-specific permissions. An optional `style_selector_demo` submodule ships sample CSS libraries.

---

- Let editors pick a background or text color for a node/block from a curated color palette instead of typing hex codes.
- Offer a fixed set of "style" CSS classes (e.g. card variants, utility classes) as a visual swatch picker on a content type.
- Add a color field whose value is applied as an inline `background-color` on the rendered entity.
- Add a color field applied as an inline `color` (text color) via the formatter's target-property setting.
- Add a CSS class field that appends a utility class to the entity wrapper on display.
- Use the large tile widget for a prominent, thumbnail-style style chooser.
- Use the compact widget for a space-efficient radios/checkbox style chooser.
- Allow multiple class/color selections on a single field (checkbox mode).
- Provide an explicit "None" empty option on non-required single-value fields.
- Embed the `style_selector` render element in a custom Layout Builder block settings form to pick a layout style class.
- Reuse the same picker in any custom Form API form via `'#type' => 'style_selector'`.
- Register a project's design-system classes as global "extra CSS classes" available to every Style Selector field.
- Attach a theme library so the chosen classes actually render with styles on the front end (theme-only library).
- Attach an admin-only library so swatches preview correctly in the edit form without leaking styles to the front end.
- Accept a wide range of color formats (hex, rgb/rgba, hsl/hsla, named/system colors, `transparent`, `currentColor`).
- Store hex colors normalized to RGB/A for consistency.
- Toggle the alpha-channel grid background behind translucent color swatches.
- Show or hide the "selected" check icon and empty-option no-symbol per widget.
- Reuse core list formatters (`list_default`, `list_key`) on Style Selector fields for plain-text output.
- Present color swatches with a "T" text-color demo glyph for foreground-color pickers.
- Give a consistent style/color picker UX across Seven, Claro, Gin and Adminimal admin themes.
- Install the demo submodule to see example CSS libraries and preconfigured styles.
- Constrain editors to only the classes/colors a designer has approved, preventing arbitrary CSS.
