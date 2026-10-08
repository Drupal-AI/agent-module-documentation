<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Color API provides the concept of a "color" in Drupal: low-level Typed Data color types (hexadecimal / RGB), an optional **Color field** that stores a human-readable name plus a color, matching display formatters, and an optional **Color configuration entity** for reusable named colors.

---

The module has two feature switches in `colorapi.settings`: `enable_color_field` (default **true**) and `enable_color_entity` (default **false**), toggled at `/admin/config/color/settings` (config route `colorapi.admin_config`, permission `administer colors`). When the Color field is enabled it exposes the `colorapi_color_field` field type, which stores two columns — `name` (varchar 255) and `color` (varchar 7, e.g. `#RRGGBB`) — and computes RGB values on save via the `colorapi.service` service. Four formatters render it: `colorapi_color_display` (a colored block, the default), `colorapi_text_display` (styled text), `colorapi_raw_hex_display`, and `colorapi_raw_rgb_display`; the raw/text formatters have `display_name` and `show_hash` settings. The default widget is `colorapi_color_widget` (a real color-picker UI needs the `jquery_colorpicker` contrib module). Under the hood, Typed Data plugins register the data types `colorapi_color`, `hexadecimal_color` and `rgb_color`, with a `HexColorConstraint` validating strings against `/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/`. The `colorapi.service` service offers `hexToRgb($hex, 'red'|'green'|'blue')` and `isValidHexadecimalColorString()`. When the Color entity is enabled, a `colorapi_color` config entity type appears (managed at `/admin/config/color/colors`) with `id`, `label` and `color`, exposing `getHexadecimal()`, `getRgb()`, `getRed()`, `getGreen()`, `getBlue()`. `hook_entity_type_alter` / `hook_field_info_alter` remove the entity/field when their switch is off, and the settings form refuses to disable a feature while Color data or Color fields still exist.

---

- Add a "brand color" field (name + hex) to a content type.
- Store a swatch with a human-readable name alongside content.
- Render a color field as a colored block/square using the `colorapi_color_display` formatter.
- Show a color as styled text with `colorapi_text_display`.
- Output the raw hex string (optionally with/without the leading `#`) via `colorapi_raw_hex_display`.
- Output the raw RGB values via `colorapi_raw_rgb_display`.
- Toggle whether the leading hash is shown using the formatter's `show_hash` setting.
- Optionally display the color's human-readable name with the `display_name` formatter setting.
- Maintain a central list of reusable named colors as Color configuration entities.
- Manage site "theme colors" at `/admin/config/color/colors` as config entities.
- Convert a hex color to red/green/blue components with `colorapi.service->hexToRgb()`.
- Validate that a user-entered string is a valid hex color (`isValidHexadecimalColorString()`).
- Use the `hexadecimal_color` / `rgb_color` Typed Data types in custom code.
- Attach the `HexColorConstraint` to validate a hex color property.
- Build a color-picker editing experience by pairing the field with `jquery_colorpicker`.
- Enable only the Color field (default) and leave the Color entity off for a lightweight setup.
- Enable the Color entity to share named colors across the site.
- Compute RGB automatically whenever a color value is set on a Color field.
- Store both 3-digit (`#abc`) and 6-digit (`#aabbcc`) hex colors.
- Export named colors as configuration for deployment across environments.
- Prevent disabling the Color field while color fields still exist (guarded settings form).
- Provide a consistent color data model to other modules that depend on Color API.
- Theme color output with the `colorapi-color-display` / `colorapi-text-display` templates.
- Give editors a labelled color value rather than a bare hex string.
