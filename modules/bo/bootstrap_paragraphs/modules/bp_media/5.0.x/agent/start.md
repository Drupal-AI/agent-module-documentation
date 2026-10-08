<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Media (`bp_media`) — agent index

Submodule of **bootstrap_paragraphs** 5.0.x. Ships **one Paragraph bundle** (`bp_media`, label
"Media") + 7 fields + one Twig template. **No services, no plugins, no permissions, no Drush,
no config schema, no CSS library of its own, `configure: null`.**
`bp_media.module` implements only `hook_theme()` and `hook_help()`.

- **Bundle id, its 7 fields, the media-type restriction, form/view display, field_group, how
  to enable it and create one in PHP** → [configure/media-bundle.md](configure/media-bundle.md)
- **Twig template, emitted classes, the link wrapper, library** →
  [theming/template.md](theming/template.md)

Key facts:

- Bundle: `bp_media`. Config: `paragraphs.paragraphs_type.bp_media` (in `config/optional/`).
- **Only own storage:** `bp_media` — `entity_reference` → **`media`**, cardinality 1,
  `handler_settings.target_bundles` restricted to **`image` and `remote_video`**,
  `auto_create: false`.
- **Shared with the parent module (6):** `bp_header`, `bp_link`, `bp_width`, `bp_background`,
  `bp_margin`, `bp_padding`.
- Extra module dependencies vs its siblings: core **`media`** and **`media_library`** — the
  form display uses the core `media_library_widget`.
- List field values are literal CSS class strings; the view display uses the `list_key`
  formatter so the raw value reaches the template.
