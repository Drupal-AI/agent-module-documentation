<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome — agent index

Adds an **icon-picker widget** and an **icon formatter** to core `string` fields. No custom
field type, no global config (`configure: null`), no permissions, no Drush. A text field holds
an icon class (e.g. `fas fa-eye`) and renders as an `<i>`.

- **Set up an icon field: widgets, the formatter, their settings, the library dependency** →
  [configure/icon-fields.md](configure/icon-fields.md)

Key facts (plugin ids):
- Widgets (field type `string`): `font_awesome_icon_picker_widget` ("Font Awesome icon picker",
  current, Furcan IconPicker) and `font_awesome_icon_picker` ("… (LEGACY)", Farbelous
  iconpicker, default `fas fa-eye`).
- Formatter (field type `string`): `font_awesome_icon` — wraps value in `<i class="value size
  fixed_width">`; settings `size` (`fa-xs`…`fa-10x`) and `fixed_width` (default `fa-fw`).
- Requires `lp_fontawesome` (Libraries Provider) for the actual Font Awesome assets; the
  formatter attaches `lp_fontawesome/fontawesome` on render.
- Config lives on the field's *Manage form display* (widget) and *Manage display* (formatter).
