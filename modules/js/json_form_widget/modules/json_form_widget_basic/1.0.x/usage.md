JSON Form Widget (Basic) is the simplest concrete widget for JSON Form Widget: it lets a site builder paste a JSON Schema (and optional UI schema) directly into a field's form-display settings, and renders that schema as the field's edit form.

---

This submodule provides one field-widget plugin, `json_form_widget_basic` (`JsonFormWidgetBasic extends JsonFormWidgetBase`), attachable to `json`, `json_native`, `json_native_binary`, `text_long`, and `string_long` field types. Its `settingsForm()` adds two textareas on *Manage form display* — a required **JSON Schema** and an optional **UI Schema** — stored in the widget settings (config schema `field.widget.settings.json_form_widget_basic` with `json_schema` and `ui_schema` text keys). At render time `resolveSchema()`/`resolveUiSchema()` `json_decode` those stored strings; on a parse error they fall back to `JsonFormWidgetBase::getDefaultSchema()` which renders a single read-only "Invalid JSON Schema"/"Invalid UI Schema" info field so the form still builds. Everything else (form building, value flattening, JSON-encoding on save) is inherited from the parent module. This is the "static schema" case; for schemas resolved dynamically (from a metastore, request param, entity, or file) you write your own `JsonFormWidgetBase` subclass instead.

---

- Turn a text/JSON field into a schema-driven form by pasting a JSON Schema into its widget settings.
- Prototype a JSON-Schema form with no custom code.
- Add an optional UI schema to control labels, ordering, widgets, and placeholders.
- Store structured multi-property data as a single JSON value on a `string_long`/`text_long` field.
- Apply a schema-driven form to `json`/`json_native`/`json_native_binary` field types.
- Give editors a nested/object form generated from schema `properties`.
- Render repeatable array items from a schema `items` definition.
- Make schema properties required via the JSON Schema `required` array.
- Fail gracefully to a read-only info field when the pasted schema is invalid JSON.
- Reuse an existing JSON Schema document (e.g. from another system) inside Drupal.
- Demonstrate JSON Form Widget without wiring up a metastore or custom resolver.
- Configure the widget entirely through the Manage form display UI.
- Keep schema and UI schema versioned with the field's config export.
- Serve as a reference/example widget implementation for building a custom one.
- Collect structured metadata against a fixed schema on a content type.
