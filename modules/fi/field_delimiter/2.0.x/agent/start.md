<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Delimiter — agent index

Adds a **"Field Delimiter"** text setting to a field formatter on any **multi-value** field, so
its values render separated by a string you choose. No settings form, no configure route, no
permissions, no plugins, no Drush. Its only persistent state is a **third-party setting** on a
formatter component in an `entity_view_display` config entity.

Key facts:
- Setting path: `core.entity_view_display.<entity>.<bundle>.<view_mode>` →
  `content.<field>.third_party_settings.field_delimiter.delimiter`.
- Only offered for fields whose storage `isMultiple()` (cardinality != 1).
- Delimiter is XSS-filtered to allow only `br, hr, span, img, wbr`.
- Rendered by `hook_preprocess_field()` as a `#suffix` on every item except the last (needs 2+ items).

- **Set a delimiter on a multi-value field / where it is stored** → [configure/delimiter.md](configure/delimiter.md)
- **How the mechanism works (hooks, render, allowed HTML)** → [api/mechanism.md](api/mechanism.md)
