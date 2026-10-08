<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style Selector — agent index

Visual CSS class/color picker: two field types + two widgets + two formatters, plus a reusable
`style_selector` Form API element. Depends on core `options`. Config schema, no permissions, no Drush.
Global config at `/admin/config/user-interface/style-selector` (`administer site configuration`).

- **Module config form: attaching CSS libraries and global extra class/color values, plus per-widget and per-formatter settings keys** → [configure/settings.md](configure/settings.md)
- **The field types, widgets and formatters — plugin IDs and how selections are applied to the entity** → [plugins/fields.md](plugins/fields.md)
- **The `style_selector` render element for custom/Layout Builder forms, and the two services** → [api/element.md](api/element.md)

Key facts:
- Field types: `style_selector_css_class` (label "Style list"), `style_selector_css_color` (label "Color list"); both use an admin `allowed_values` list.
- Widgets: `style_selector_tile_widget`, `style_selector_compact_widget`. Formatters: `style_selector_css_class_formatter`, `style_selector_css_color_formatter`.
- Class formatter adds classes to `#attributes['class']`; color formatter writes inline `<css_property>:<value> !important` (default color prop configurable).
- Colors validated/normalized by service `style_selector.css_color` (hex stored as RGB/A).
- Submodule `style_selector_demo` ships sample CSS libraries (not documented separately).
