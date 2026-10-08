# Hook: hook_field_migration_field_widget_info

Implemented in `existing_values_autocomplete_widget.module` as
`existing_values_autocomplete_widget_field_migration_field_widget_info()`. Relevant only when
migrating a Drupal 7 site: it tells the field-migration mapping to convert several legacy D7 CCK
autocomplete widgets into this module's `existing_autocomplete_field_widget`.

Returned mapping (D7 field type → D7 widget → target widget):

| D7 field type | D7 widget | Target widget |
| --- | --- | --- |
| `list_text` | `autocomplete_widgets_allowvals` | `existing_autocomplete_field_widget` |
| `list_integer` | `autocomplete_widgets_allowvals` | `existing_autocomplete_field_widget` |
| `list_decimal` | `autocomplete_widgets_allowvals` | `existing_autocomplete_field_widget` |
| `list_float` | `autocomplete_widgets_allowvals` | `existing_autocomplete_field_widget` |
| `text` | `autocomplete_widgets_flddata` | `existing_autocomplete_field_widget` |
| `text` | `autocomplete_widgets_suggested` | `existing_autocomplete_field_widget` |
| `text` | `autocomplete_widgets_node_reference` | `existing_autocomplete_field_widget` |

Caveat from the source comment: this hook currently requires two core migration patches
(`3204212` field-migration widget/formatter mapping, and `3202462` allow map formatter
migration) to take effect. Without them the mapping is inert. The target widget only applies to
`string` fields, so migrated fields must resolve to a `string` field type for the widget to be
valid.

`hook_help` is also implemented (route `help.page.existing_values_autocomplete_widget`) and just
prints the module's one-line description on the module help page.
