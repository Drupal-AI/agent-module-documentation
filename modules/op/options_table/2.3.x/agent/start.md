<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Options Table — agent index

Provides one field widget, **`options_table`** ("Draggable Table"), for options field
types (`entity_reference`, `list_integer`, `list_float`, `list_string`). Same select/deselect
as core Check boxes/radio buttons, plus a drag-and-drop **Weight** column so multi-value
selections are stored in a chosen order. No config entity, no admin page (`configure: null`),
no permissions, no Drush. Requires core **Options** module.

- **Select the widget on a field / set `toggle_label` / where it is stored** →
  [configure/widget.md](configure/widget.md)

Key fact: the widget is applied per field on **Manage form display** and stored in the
`entity_form_display` config entity as `content.<field>.type: options_table` with an optional
`settings.toggle_label`. Its one custom setting is `toggle_label` (heading for the
checkbox/radio column). For multi-value fields the stored delta order follows the table order.
