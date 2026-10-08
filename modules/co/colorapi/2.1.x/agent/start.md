<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color API — agent index

Provides a "color" concept in Drupal: Typed Data color types, an optional **Color field**
(`colorapi_color_field`) with formatters, and an optional **Color config entity**
(`colorapi_color`). Two feature switches live in `colorapi.settings`.

- **Module settings, the two feature switches, config route, permission, Color entity admin** →
  [configure/settings.md](configure/settings.md)
- **The Color field: field type, columns, formatters + their settings, widget** →
  [plugins/field.md](plugins/field.md)
- **`colorapi.service`, the Color config entity API, Typed Data types, hex constraint** →
  [api/service-and-entity.md](api/service-and-entity.md)

Key facts:
- `colorapi.settings`: `enable_color_field` (default **true**), `enable_color_entity`
  (default **false**). Configure at `/admin/config/color/settings`
  (route `colorapi.admin_config`, permission `administer colors`).
- Field type **`colorapi_color_field`** stores `name` (varchar 255) + `color` (varchar 7);
  default formatter `colorapi_color_display`, default widget `colorapi_color_widget`.
- Config entity **`colorapi_color`** (`id`, `label`, `color`) only exists when
  `enable_color_entity` is true; managed at `/admin/config/color/colors`.
- Service **`colorapi.service`**: `hexToRgb($hex, 'red'|'green'|'blue')`,
  `isValidHexadecimalColorString()`. Hex regex `/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/`.
