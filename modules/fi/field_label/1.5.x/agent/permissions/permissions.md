# Field Label — permissions

Defined statically in `field_label.permissions.yml`. Each gates one feature on the formatter
"Label settings" form; a feature shows only when its global `*_enabled` flag is on **and** the
user has the permission (logic in `field_label_field_formatter_third_party_settings_form()`).
Users lacking a permission get a hidden field that preserves any existing value.

| Permission | Gates | Enabled flag |
|---|---|---|
| `edit_field_label_value` | The "Label value" text override | `label_value_enabled` |
| `edit_field_plural_label` | The "Plural label value" field | `plural_label_enabled` |
| `edit_field_label_class` | Free-form "Extra label classes" text field | `label_class_enabled` |
| `edit_field_label_class_select` | The "Label class" select (from `class_list`) | `label_class_select_enabled` |
| `edit_field_label_tag` | The "Label wrapper" tag select (from `allowed_tags`) | `label_tag_enabled` |

Notes:
- The global settings form itself is gated by core's `administer site configuration`, not by
  these permissions.
- These permissions are most useful with **Layout Builder**: they let you expose label
  styling to editors working in layouts without granting broad *Manage display* access.
- Grant on `/admin/people/permissions` or in `user.role.<role>.permissions`.
