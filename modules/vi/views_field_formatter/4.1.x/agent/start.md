<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views field formatter — agent index

Adds one field formatter (id `views_field_formatter`, label **"View"**) that renders a chosen
View — passing the field's value/entity as contextual arguments — instead of the field's own
value. No settings form (`configure: null`), no permission, no Drush, no plugins beyond the
formatter. Depends only on Views.

- **The formatter, its settings keys, how the view is embedded and arguments passed, config location** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id: `views_field_formatter`; available on nearly all field types (string,
  entity_reference, list_*, number, date, link, image, etc.).
- Settings (schema `field.formatter.settings.views_field_formatter`): `view`
  (`"viewid::display"`), `arguments` (map of `{checked, weight}` per available argument),
  `hide_empty` (bool), `multiple` (bool), `implode_character` (string).
- Stored on `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.{type: views_field_formatter, settings}`.
- Embeds the view via a `#type => 'view'` render element; declares a config dependency on the
  chosen view.
