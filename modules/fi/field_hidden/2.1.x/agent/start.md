<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Hidden — agent index

Adds three **"Hidden field"** form-widget plugins that render core number/plain-text fields
as `input[type='hidden']` — value is submitted but not shown or editable. No config route,
no settings form, no config schema, no permissions, no Drush, no dependencies beyond core.
Persistent state is just the chosen widget `type` on a field component in an
`entity_form_display` config entity.

- **Which widget id to pick per field type, where it's stored, how to set it (UI + drush)** →
  [configure/select-hidden-widget.md](configure/select-hidden-widget.md)
- **The three widget plugins, what they extend, CSS classes, "- Hidden -" difference** →
  [plugins/hidden-widgets.md](plugins/hidden-widgets.md)

Key fact: pick widget `field_hidden_string_textfield` (string), `field_hidden_string_textarea`
(string_long), or `field_hidden_number` (integer/decimal/float) on *Manage form display*. It
is **not** the same as choosing "- Hidden -": that removes the field from the form; this keeps
it as a submitted hidden input.
