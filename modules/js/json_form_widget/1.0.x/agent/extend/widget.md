# JSON Form Widget — implementing a widget plugin

The module builds forms but does not decide *where the schema comes from*. That is a field-widget
plugin's job. Create a core `FieldWidget` plugin that extends
`Drupal\json_form_widget\Plugin\Field\FieldWidget\JsonFormWidgetBase` and implement the two
abstract methods.

## Abstract contract (`JsonFormWidgetBase`)

```php
abstract protected function resolveSchema(FormStateInterface $form_state): object;   // JSON Schema as stdClass
abstract protected function resolveUiSchema(FormStateInterface $form_state): ?object; // schema.ui, or NULL
```

`JsonFormWidgetBase` already handles the rest:

- `formElement()` — decodes the stored `$items[0]->value` JSON as default data, calls
  `resolveSchema()`/`resolveUiSchema()`, then `$this->builder->setSchema($schema, $ui_schema)` and
  `$this->builder->getJsonForm($default_data, $form_state, $wrapper_id)`. Returns `['value' => $json_form]`.
  It also persists field parents per entity UUID in form state (for inline_entity_form / nested resolution).
- `extractFormValues()` — re-resolves the schema, walks `$schema->properties`, calls
  `ValueHandler::flattenValues()` per property, drops empty values, and `json_encode`s the result
  into the field value.
- Helpers: `getDefaultSchema($message)` (a minimal read-only info schema for error states),
  `findValueRecursive()`, `extractId()`.
- `handlesMultipleValues()` returns FALSE — one JSON blob per field item.
- DI (`create()`): injects `json_form.builder` and `json_form.value_handler` after the core
  `WidgetBase` constructor args.

## Minimal example

```php
#[FieldWidget(
  id: "my_json_widget",
  label: new TranslatableMarkup("My JSON widget"),
  field_types: ["string_long", "json"],
)]
class MyJsonWidget extends JsonFormWidgetBase {
  protected function resolveSchema(FormStateInterface $form_state): object {
    // e.g. load from a file, entity, or request param:
    return json_decode(file_get_contents($this->resolveSchemaPath()));
  }
  protected function resolveUiSchema(FormStateInterface $form_state): ?object {
    return NULL; // or a decoded schema.ui object
  }
}
```

If your `create()`/constructor needs extra services, override them and call the parent's, keeping
the trailing `FormBuilder $builder, ValueHandler $value_handler` arguments.

## Reference implementations

- `json_form_widget_basic` (this project's submodule) — schema pasted into widget settings.
- DKAN's `DkanJsonFormWidget` — resolves the schema from the metastore by a `?schema=` request param.

## Notes

- The widget stores a JSON **string**; make sure the target field type can hold it (`json`,
  `json_native`, `json_native_binary`, `text_long`, `string_long`).
- Selection happens on the entity's *Manage form display* tab — a restricted admin task
  (`administer <entity> form display`). The schema an admin enters is trusted config.
