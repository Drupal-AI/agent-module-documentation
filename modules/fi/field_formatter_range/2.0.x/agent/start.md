<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Formatter Range — agent index

Adds **order / limit (display items) / offset (skip items)** to any field formatter on a
**multi-value** field, so a display can show a curated subset of a field's values. No field
type, widget, or formatter of its own; no config UI page (`configure: null`), no permissions,
no Drush, no plugins. Its only persistent state is a **third-party setting** on a formatter
component in an `entity_view_display` config entity.

- **Turn range/order/offset on for a field, where it is stored, values, and how to script it** →
  [configure/range-settings.md](configure/range-settings.md)

Key facts:
- Setting path: `core.entity_view_display.<entity>.<bundle>.<view_mode>` →
  `content.<field>.third_party_settings.field_formatter_range` → `{order, limit, offset}`.
- `order`: 0 = Default, 1 = Reverse, 2 = Random. `limit`: display items (0 = all).
  `offset`: skip items from the start.
- The settings group appears **only when the field cardinality is not 1** (multi-value).
- Applies at render via `hook_preprocess_field` (reverse/shuffle → `array_slice(offset, limit)`);
  stored values are unchanged. Config schema: `field.formatter.third_party.field_formatter_range`.
