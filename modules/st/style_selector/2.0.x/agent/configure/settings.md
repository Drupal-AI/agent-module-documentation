<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Style Selector

## Global module config
Route `style_selector.module_config_form` → `/admin/config/user-interface/style-selector`
(permission `administer site configuration`). Config object `style_selector.settings`:

| Key | Type | Purpose |
|---|---|---|
| `shared_libraries` | list of `machine/library` | Loaded BOTH in the admin widget AND the front-end formatter. |
| `theme_libraries` | list | Loaded ONLY when a field is rendered with the CSS Class formatter (front end). |
| `admin_libraries` | list | Loaded ONLY when the widget is shown in the admin UI. |
| `extra_css_classes` | list of class names | Global class options offered to every Style Selector class field. |
| `extra_color_classes` | list | Global color-class options. |

Libraries are entered one per line as `theme_or_module/library_name`; they must define the CSS
that actually styles the chosen classes (the module ships no design classes of its own). Form input
is sanitized (`Xss`/`Html`) on save. Defaults are all empty arrays.

## Adding a field (Manage fields)
Add a field of type **Style list** (`style_selector_css_class`) or **Color list**
(`style_selector_css_color`). Field storage keeps an `allowed_values` list of `value`/`label` pairs
(same shape as core List fields, schema `field.storage_settings.style_selector_css_class` /
`..._css_color`) — for a class field the `value` is the CSS class; for a color field it is any
supported color string (validated on render).

## Widget settings (Manage form display)
Schema `field.widget.settings.style_selector_tile_widget` / `..._compact_widget`. Keys:
- `size` (both) — swatch size.
- `type` (compact only) — e.g. round/square style.
- `advanced` (`advanced_settings`):
  - `color_prop` — CSS property previewed for color options (nullable).
  - `extra_classes` — extra classes added to the `ssui` container.
  - `empty_option` — label for the None option.
  - `ui_settings`: `alpha_grid`, `check_icon`, `empty_icon`, `text_icon` (booleans).

## Formatter settings (Manage display)
- `style_selector_css_class_formatter` → `extra_classes` (extra classes always added).
- `style_selector_css_color_formatter` → `extra_classes` plus `css_property` (target property for the
  inline style, e.g. `color` or `background-color`). On display the color is written as
  `<css_property>:<value> !important` on the entity wrapper; only the first value is used.

Core `list_default` / `list_key` formatters are also allowed on these fields (via
`hook_field_formatter_info_alter`) for plain-text output.
