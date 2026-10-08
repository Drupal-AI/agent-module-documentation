<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select Text Value — agent index

Provides four field **widgets** that let editors pick a text field's value from a
Select / Radio / Checkboxes list of predefined `allowed_values`, with an optional
"Other" option (`_custom_value`) that reveals the normal text input for free entry.
No settings page (`configure: null`), no permissions, no Drush, no services you call.
All state lives in the field's `entity_form_display` widget component config.

- **Choose & configure the widget, all settings keys, where config is stored, scripting it** →
  [configure/widgets.md](configure/widgets.md)

Key facts:
- Widget ids by field type: `select_string_textfield` (`string`),
  `select_string_textarea` (`string_long`), `select_text_textfield` (`text`),
  `select_text_textarea` (`text_long`). Widget label is "Select text value".
- Settings keys: `select_type` (`select` | `radios` | `checkboxes`), `allowed_values`
  (one value per line; `key|label` also parsed), `custom_value_label` (default `Other`;
  empty ⇒ allowed-list only), `custom_value_field_title`, `custom_value_field_description`.
- `checkboxes` is only offered when field cardinality ≠ 1, and flips
  `handlesMultipleValues()` to TRUE.
- Config path: `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type` (a `select_*` id) and `content.<field>.settings.*`.
- Values are stored in the field's **normal** storage format — no key mapping, no extra tables.
