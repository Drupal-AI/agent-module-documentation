<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field types, widgets & formatters

The module does not define new plugin *types*; it provides concrete Field API plugins.

## Field types
- `style_selector_css_class` — label "Style list". Stores a string CSS class chosen from
  `allowed_values`. Class name(s) validated/split by the `style_selector.util` service.
- `style_selector_css_color` — label "Color list". Stores a color string from `allowed_values`;
  hex input is converted and stored as RGB/A, other formats normalized by `style_selector.css_color`.

Both behave like core `options` list fields (allowed-values list of value/label pairs) and appear
under the "Style Selector" field-type category.

## Widgets (Manage form display)
- `style_selector_tile_widget` — large tile/thumbnail swatches.
- `style_selector_compact_widget` — compact radios (single) / checkboxes (multiple).

Both render the shared `ssui` swatch UI (radios for single-value, checkboxes for multiple). See
[../configure/settings.md](../configure/settings.md) for the settings keys.

## Formatters (Manage display)
- `style_selector_css_class_formatter` — merges the stored class(es) plus any `extra_classes` into
  the rendered entity's `#attributes['class']` (done in `hook_entity_view_alter`, not a themed
  field output).
- `style_selector_css_color_formatter` — writes an inline style
  `<css_property>:<first value> !important` onto the entity wrapper (`css_property` defaults to a
  color property; set it to `background-color` etc.).

Because output is applied to the entity wrapper via `hook_entity_view_alter`, the field itself may be
hidden; the visual effect is the class/inline-style on the entity container.
