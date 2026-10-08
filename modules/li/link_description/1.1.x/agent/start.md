<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link with description — agent index

Adds a `link_description` field type = core Link field + an extra multi-line **description**.
No settings page (`configure: null`), no permission, no service, no Drush. Depends on core
`link`. You use it by adding a field of type `link_description` to a bundle.

- **The field type, widget, and two formatters (ids, settings, how to add the field)** →
  [plugins/field.md](plugins/field.md)
- **Theme hooks and templates that render the description** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Field type id `link_description` (extends core `LinkItem`); adds a `description` column
  (`text`/`big`) and `description` string property.
- Default widget `link_description` (core `LinkWidget` + a "Long description" textarea).
- Formatters: `link_description` (compact) and `link_separate_description` (separate title/URL),
  both extend the core Link formatters and add the description.
- All core Link field/widget/formatter settings are inherited; the description is stored raw and
  output with `nl2br`.
