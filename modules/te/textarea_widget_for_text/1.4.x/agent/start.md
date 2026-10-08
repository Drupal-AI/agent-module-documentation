<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textarea Widget For Text Fields — agent index

Makes core's multi-row **Text area** widget available to short text fields. Whole module = one
`hook_field_widget_info_alter()`. **No settings form, no configure route, no config schema, no
permissions, no Drush, no plugins.** Its only persistent state is the widget `type` on a field
component in an `entity_form_display` config entity.

- **Select the textarea widget for a short text field / where it is stored / the one hook** →
  [configure/widget.md](configure/widget.md)

Key facts: adds field type `text` to the core `text_textarea` widget and `string` to the core
`string_textarea` widget. Choose **"Text area (multiple rows)"** on *Manage form display*; the
component's `type` becomes `string_textarea` (plain) or `text_textarea` (formatted) in
`core.entity_form_display.<entity>.<bundle>.<mode>`.
