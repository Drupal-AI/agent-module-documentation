# Markup — field plugin internals & hooks

The module ships one Field API plugin trio and two module hooks. No services, no plugin
manager, nothing to instantiate programmatically.

## Field type — `markup`

`Drupal\markup\Plugin\Field\FieldType\MarkupItem` (`@FieldType`):

- `id = "markup"`, `category = "formatted_text"`,
  `default_widget = "markup"`, `default_formatter = "markup"`,
  `list_class = \Drupal\markup\Field\MarkupItemList`.
- `schema()` — declares a single stored column `markup` (`varchar`, length 255).
  **Quirk:** neither the widget nor the formatter reads this per-entity column; both read
  the field *setting* `markup.value`/`markup.format`. The column exists but the displayed
  markup is the shared field setting, so all entities show the same markup.
- `propertyDefinitions()` — one `markup` string property.
- `defaultFieldSettings()` — `['markup' => ['value' => '', 'format' => '']]`.
- `fieldSettingsForm()` — a required `text_format` element (`#rows` 15) writing
  `markup.value` + `markup.format`, plus a static instructions line. Format defaults to
  `filter_default_format()` when unset.
- `isEmpty()` — true when the field-setting `markup.value` is `NULL` or `''`
  (both `MarkupItem` and `MarkupItemList` implement this identically).

## Widget — `markup`

`Drupal\markup\Plugin\Field\FieldWidget\MarkupWidget` (`@FieldWidget`, `field_types = {markup}`).
`formElement()` returns a render element:

```php
$element['markup'] = [
  '#type'   => 'processed_text',
  '#text'   => $this->fieldDefinition->getSetting('markup')['value'],
  '#format' => $this->fieldDefinition->getSetting('markup')['format'],
];
```

So on the edit form it prints the field-setting markup through the chosen text format.

## Formatter — `markup`

`Drupal\markup\Plugin\Field\FieldFormatter\MarkupFormatter` (`@FieldFormatter`,
`field_types = {markup}`). `viewElements()` returns the same `processed_text` element built
from `getSetting('markup')['value']` / `['format']` — i.e. identical output to the widget,
on the entity display.

## Module hooks (in `markup.module`)

- `hook_form_field_storage_config_edit_form_alter()` — for fields whose `module == 'markup'`
  it `unset()`s `$form['cardinality_container']`, forcing single cardinality.
- `hook_help()` for `help.page.markup` — renders `README.md`/`README.txt`; if the
  `markdown` module is enabled it processes the text through the `markdown` filter,
  otherwise wraps it in `<pre>`.

## Programmatic use

To create a Markup field in code, define a `FieldStorageConfig`/`FieldConfig` of type
`markup` and set its `settings` to `['markup' => ['value' => '<div>…</div>', 'format' =>
'full_html']]`. There is no runtime API to call — the module exposes no services and
invents no hooks of its own.
