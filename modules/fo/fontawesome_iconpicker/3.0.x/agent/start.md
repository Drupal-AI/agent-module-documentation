<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome Iconpicker — agent index

Adds a searchable **icon-picker field widget** + **display formatter** for Font Awesome icons,
usable on core `text` / `string` fields. No settings page, routes, permissions, services, or
Drush (`configure` = null). Depends on the contrib `fontawesome` module and the external
`d34dman/vanilla-icon-picker` JS library.

- **Put the picker on a field: widget + formatter, their settings, where config is stored** →
  [configure/field.md](configure/field.md)
- **Plugin ids, theme hook / rendered markup, JS library, supported field types** →
  [api/plugins.md](api/plugins.md)

Key facts:
- Widget id: **`fontawesome_iconpicker`** (settings: `type` [default|component], `size` int,
  `placeholder`). Formatter id: **`fontawesome_iconpicker_formatter_type`** (setting: `size` =
  `fa-1x`…`fa-5x`).
- Both plugins accept field types `text` and `string`. The field stores the icon's CSS class
  string; the formatter renders `<i class="fa <icon> <size>" aria-hidden="true">`.
- Config lives on the display entities: widget under
  `core.entity_form_display.<e>.<b>.<mode>` → `content.<field>` (type
  `fontawesome_iconpicker`); formatter under `core.entity_view_display.…`.
