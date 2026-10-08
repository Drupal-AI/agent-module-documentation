# JSON Form Widget — services, elements & hooks

## Services (`json_form_widget.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `json_form.builder` | `FormBuilder` | Entry point. `setSchema($schema, $ui_schema=null)` then `getJsonForm($data, $form_state, $wrapper_id)` builds the render array. Injects router + schema-ui handler. |
| `json_form.router` | `FieldTypeRouter` | Dispatches each schema property to a type helper by its JSON type. Injects the 4 helpers. |
| `json_form.string_helper` | `StringHelper` | String/email/format elements (injects `email.validator`). |
| `json_form.integer_helper` | `IntegerHelper` | Number/integer elements. |
| `json_form.object_helper` | `ObjectHelper` | Nested object sub-forms. |
| `json_form.array_helper` | `ArrayHelper` | Repeatable array items (injects object + string helpers). |
| `json_form.widget_router` | `WidgetRouter` | Maps `ui:widget` hints → render elements; resolves option sources. Injects `uuid`, string helper, `plugin.manager.json_form_option_source`. |
| `json_form.schema_ui_handler` | `SchemaUiHandler` | Applies the `schema.ui` doc (titles, weights, widgets, placeholders). Injects logger + widget router. |
| `json_form.value_handler` | `ValueHandler` | `flattenValues()` — coerce submitted values back to schema shape for storage. |
| `json_form.logger_channel` | logger | Channel `json_form_widget`. |
| `plugin.manager.json_form_option_source` | `JsonFormOptionSourcePluginManager` | Option-source plugin manager (see plugins/option-source.md). |

Typical programmatic build:

```php
$builder = \Drupal::service('json_form.builder');
$builder->setSchema($schemaObject, $uiSchemaObject);
$form['value'] = $builder->getJsonForm($defaultData, $form_state, 'my-wrapper');
```

## Custom render/form elements (`src/Element/`)

- **`upload_or_link`** (`UploadOrLink`, `@FormElement`, extends core `ManagedFile`) — one field that
  accepts either a **file upload** or a **remote URL** (radio `file_url_type`: `upload` / `remote`).
  A remote URL is turned into a managed `File` entity (`getManagedFile()` creates a permanent file
  owned by the current user, uri = the URL) so file usage can be tracked. `getFileUri()` rewrites
  absolute local URLs back to a `public://`-style scheme. `submitForm()` (added as a form submit in
  `hook_form_alter`) finalizes usage; `removeSubmit()`/`preRenderManagedFile()` handle removal and
  control visibility. Remote values are validated as URLs (`UrlHelper::isValid`).
- **`DateRange`** (`Element\DateRange`), **`FlexibleDateTime`** (`Element\FlexibleDateTime`) — date
  inputs used from schema-driven forms.

## Module hooks (`json_form_widget.module`)

- `hook_field_widget_complete_form_alter()` — flags the form (`has_json_form_widget`) when a
  `JsonFormWidgetBase` widget is present.
- `hook_form_alter()` — appends `UploadOrLink::submitForm` to the submit handlers when the flag is set
  (so remote-file usage is recorded on submit).
- `hook_entity_delete()` — removes `json_form_widget` file-usage rows for files tied to the deleted
  entity (queries `file_usage` by type/id/module).
- `hook_preprocess_file_link()` — decodes filenames/URLs for files with `json_form_widget` usage.
- `hook_entity_type_build()` — swaps the `file` entity's access handler to
  `UploadOrLinkAccessControlHandler`, which grants `download` access to files whose scheme starts
  with `http` (remote links entered in the widget), and defers to core `FileAccessControlHandler`
  otherwise.
