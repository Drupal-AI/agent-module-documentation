# JSON Form Widget — agent index

Builds a nested Drupal field-edit form from a JSON Schema and stores the values as a JSON string.
The module is a **framework**: a field-widget plugin supplies the schema. No config page
(`configure` null), no permissions, no Drush. Depends on core `file`, plus contrib `select2` and
`select_or_other`. Defines one plugin type: `json_form_option_source`.

- **Implement a widget: subclass `JsonFormWidgetBase` (`resolveSchema`/`resolveUiSchema`)** → [extend/widget.md](extend/widget.md)
- **The `json_form_option_source` plugin type (dynamic option lists; `taxonomy` example)** → [plugins/option-source.md](plugins/option-source.md)
- **Form-builder services, the `upload_or_link`/date elements, and module hooks (file usage, access)** → [api/services.md](api/services.md)

Submodule (own docs):
- `json_form_widget_basic` — paste-a-schema widget → [../../modules/json_form_widget_basic/1.0.x/agent/start.md](../../modules/json_form_widget_basic/1.0.x/agent/start.md)

Key facts:
- Abstract base widget: `Plugin\Field\FieldWidget\JsonFormWidgetBase` (single value; not multi-value).
- Values are `json_encode`d into the field on save; read back via `json_decode` in `formElement()`.
- Plugin type `json_form_option_source`: annotation `@JsonFormOptionSource`, manager `JsonFormOptionSourcePluginManager`, dir `Plugin/JsonFormOptionSource`, example `TaxonomySource`.
- Custom elements: `upload_or_link` (upload OR remote URL), `DateRange`, `FlexibleDateTime`.
- Originally extracted from DKAN; reference widget = DKAN's `DkanJsonFormWidget`.
