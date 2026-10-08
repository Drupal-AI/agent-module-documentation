<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Type Tray — agent index

Replaces the `/node/add` page with a categorised, illustrated tray. Two places hold state:
one global config object for the **categories**, and **third-party settings on each
`node_type`** for that type's category, icon, thumbnail, description and weight.

- **Global settings (`type_tray.settings`), route, permission** →
  [configure/settings.md](configure/settings.md)
- **Per-content-type third-party settings (`type_tray.*` on `node.type.*`)** →
  [configure/per-type.md](configure/per-type.md)
- **Templates, layouts, favourites, cache tags** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Config object `type_tray.settings`: `categories` (sequence `key: Label`), `fallback_label`
  (default `Uncategorized`), `text_format` (default `plain_text`).
- Settings form route `type_tray.settings.form` = **`/admin/config/content/type-tray/settings`**
  (the README's `/admin/config/type-tray/settings` is out of date). Permission:
  `administer type tray`.
- Per-type keys under `node.type.<type>:third_party_settings.type_tray`:
  `type_category`, `type_thumbnail`, `type_icon`, `type_description`,
  `existing_nodes_link_text`, `type_weight`.
- Reserved keys: uncategorised = `_none`, favourites group = `type_tray__favorites`.
- It hijacks core's `node.add_page` route controller — no new path for the tray itself.
