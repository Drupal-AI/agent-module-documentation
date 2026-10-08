# Configure widget limits

MaxLength has **no config form of its own**. It attaches third-party settings to
field widgets via `hook_field_widget_third_party_settings_form()`. Configure at
**Manage form display** → click a widget's gear → the **MaxLength Settings** details.

Settings (stored under third-party namespace `maxlength`, schema
`field.widget.third_party.maxlength`):

| Key | Type | Meaning |
|---|---|---|
| `maxlength_js` | int | Maximum characters for the field value. |
| `maxlength_js_label` | text | Countdown message; `@limit`, `@remaining`, `@count` are substituted. |
| `maxlength_js_summary` | int | Maximum characters for the summary (text-with-summary/key_value widgets). |
| `maxlength_js_label_summary` | text | Countdown message for the summary. |
| `maxlength_js_enforce` | bool | **Hard limit** — block typing past the max. If off, a soft limit shows a negative count. |

Which settings appear depends on the widget. Supported widget plugin ids and the
settings they allow (from `WidgetSettings::getAllowedSettingsForAll()`):
`string_textfield`, `string_textarea`, `text_textfield`, `text_textarea`,
`text_textarea_with_summary` (+summary), `key_value_textarea` (+summary),
`link_default`, `linkit` (no truncate). Others get nothing unless added via the hook.

Numbers are validated positive (`maxlength_number_element_validate`). A summary of
the active limit is shown on the Manage form display overview
(`hook_field_widget_settings_summary_alter`). Everything exports with the
`core.entity_form_display.*` config, so limits are deployable.
