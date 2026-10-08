# JSON Form Widget (Basic) — configuration

## Selecting the widget

*Manage form display* of the entity/bundle → set the target field's widget to
**"JSON Schema Form (Basic)"** (plugin id `json_form_widget_basic`). Supported field types:
`json`, `json_native`, `json_native_binary`, `text_long`, `string_long`.

## Widget settings (`settingsForm()`)

Two textareas stored in the widget's third-party-free settings:

| Setting | Required | Default | Meaning |
|---|---|---|---|
| `json_schema` | yes | `'{}'` | The JSON Schema document that defines the form's fields. |
| `ui_schema` | no | `NULL` | Optional UI schema (labels, weights, `ui:widget`, placeholders). |

Config schema: `field.widget.settings.json_form_widget_basic` (`json_schema`: text, `ui_schema`:
text). These are exported with the `core.entity_form_display.*` config.

## Runtime resolution

- `resolveSchema()` — `json_decode($this->getSetting('json_schema'))`; on `json_last_error()` or a
  falsy result, returns `getDefaultSchema('Invalid JSON Schema')` (a one-field read-only info form).
- `resolveUiSchema()` — `json_decode($this->getSetting('ui_schema'))`; on parse error returns
  `getDefaultSchema('Invalid UI Schema')`, else the decoded object (or NULL when empty and valid).

All form building, value flattening, and JSON-encoding on save are inherited from
`JsonFormWidgetBase` (see the parent module's `extend/widget.md` and `api/services.md`).

## Trust note

The schema/ui-schema are entered by whoever can edit the form display — a restricted admin task
(`administer <entity> form display`). The pasted schema is trusted site configuration.
