JSON Form Widget renders a nested Drupal field-edit form from a [JSON Schema](https://json-schema.org/), storing the collected values back into the field as a JSON string. Originally part of DKAN, it turns schema documents into form UIs without hard-coding every field.

---

The module provides the machinery to build forms from JSON Schema but is itself abstract: a **widget plugin** must supply the schema. It ships an abstract core field-widget base (`Plugin\Field\FieldWidget\JsonFormWidgetBase`) whose subclasses implement `resolveSchema()`/`resolveUiSchema()`; the bundled `json_form_widget_basic` submodule is the simplest such widget (schema pasted into the widget settings), and DKAN's `DkanJsonFormWidget` is the reference implementation that pulls schemas from the metastore. Form construction is done by a set of services: `json_form.builder` (`FormBuilder`) drives a `FieldTypeRouter` that dispatches each schema property to a type helper (`StringHelper`, `IntegerHelper`, `ObjectHelper`, `ArrayHelper`), a `WidgetRouter` that maps `ui:widget` hints (including select2/select-or-other option lists) to render elements, a `SchemaUiHandler` that applies the optional `schema.ui` document (titles, weights, widgets, placeholders), and a `ValueHandler` that flattens submitted values back to a schema-shaped structure that is JSON-encoded on save. It defines a plugin type, `json_form_option_source` (`@JsonFormOptionSource` annotation, `JsonFormOptionSourcePluginManager`, `Plugin/JsonFormOptionSource`), for supplying dynamic option lists — with a `taxonomy` example plugin. Custom form elements extend core: `upload_or_link` (`Element\UploadOrLink`, a `ManagedFile` subclass that accepts either a file upload or a remote URL and manages file usage), plus `DateRange` and `FlexibleDateTime`. Module hooks handle file-usage cleanup on entity delete, decode file link titles, and grant linked (http-scheme) files the same access as uploaded files via `UploadOrLinkAccessControlHandler`.

---

- Generate a Drupal edit form for a field from a JSON Schema document.
- Store structured, multi-property data as a single JSON value on a text/JSON field.
- Reuse an existing JSON Schema (e.g. DCAT-US metadata) to drive Drupal content entry.
- Customize form labels, ordering (weights), and widgets with a companion `schema.ui` document.
- Build nested/object and array (repeatable) sub-forms from schema `properties` and `items`.
- Render enum/option fields as Select2 or Select-or-other widgets.
- Populate a dropdown's options dynamically from a Drupal taxonomy vocabulary (`taxonomy` option source).
- Add a custom option source (e.g. from an API or entity query) via a `json_form_option_source` plugin.
- Let editors either upload a file or link to a remote URL in one field (`upload_or_link` element).
- Automatically track file usage for files attached through the widget and clean it up on delete.
- Provide a date-range or flexible date/time input inside a schema-driven form.
- Make specific schema properties required using the JSON Schema `required` array.
- Swap in your own schema-storage strategy by subclassing `JsonFormWidgetBase`.
- Use the basic submodule to paste a schema directly into a field's form-display settings.
- Validate and coerce submitted values back into a schema-shaped structure on save.
- Prototype content models from JSON Schema without creating dozens of Drupal fields.
- Drive DKAN dataset/metadata entry forms (its original use case).
- Show decoded filenames/URLs for files entered through the widget.
- Give remote linked files the same download access as uploaded files.
- Support `json`, `json_native`, `text_long`, and `string_long` field types (via the basic widget).
