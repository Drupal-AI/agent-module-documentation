# The VAT field, widget, formatter, render element and Webform element

The module adds one Field API field type and the plugins around it, plus a reusable form render
element and (via the submodule) a Webform element. There is **no admin settings page** — all
behaviour is configured per field-widget on a form display, or per element on a Webform.

## Field type `vat_number`

`src/Plugin/Field/FieldType/VatNumber.php` (`@FieldType id = "vat_number"`).

- `default_widget = "vat_widget"`, `default_formatter = "vat_formatter"`.
- Storage: a single `value` column — `type: text`, `size: medium`, `not null: FALSE`. One string
  property `value` labelled "VAT Number".
- `isEmpty()` returns TRUE when `value` is `NULL` or `''`.
- The stored value is the raw submitted string (after the widget's validate strips spaces and dots —
  see below). No normalization to an upper-cased canonical form is persisted.

Add the field from code:

```php
\Drupal::entityTypeManager()->getStorage('field_storage_config')->create([
  'field_name' => 'field_vat',
  'entity_type' => 'node',
  'type' => 'vat_number',
])->save();
\Drupal::entityTypeManager()->getStorage('field_config')->create([
  'field_name' => 'field_vat',
  'entity_type' => 'node',
  'bundle' => 'page',
  'label' => 'VAT number',
])->save();
```

## Widget `vat_widget`

`src/Plugin/Field/FieldWidget/VatNumberWidget.php` (`@FieldWidget id = "vat_widget"`).

Two settings, both default `FALSE` (`defaultSettings()`):

| Setting | Default | Meaning |
|---|---|---|
| `validate_vies` | `FALSE` | Also query the VIES service to confirm the number is registered for intra-EU trade. When off, only the offline format/regex check runs. |
| `fail_if_vies_unavailable` | `FALSE` | Only visible/relevant when `validate_vies` is on. When off, a VIES outage/error is treated as an accepted number; when on, an outage makes validation fail. |

The settings form (`settingsForm()`) renders `fail_if_vies_unavailable` behind a `#states` visible
condition on `validate_vies`. `formElement()` builds a `#type => 'vat_number'` render element and
passes the two settings through as `#validate_vies` / `#fail_if_vies_unavailable`.

Config schema (`config/schema/vat_number.schema.yml`):

```yaml
field.widget.settings.vat_widget:
  type: mapping
  mapping:
    validate_vies: { type: boolean }
    fail_if_vies_unavailable: { type: boolean }
```

Set the widget + settings from code:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'page', 'default')
  ->setComponent('field_vat', [
    'type' => 'vat_widget',
    'settings' => ['validate_vies' => TRUE, 'fail_if_vies_unavailable' => FALSE],
  ])->save();
```

## Formatter `vat_formatter`

`src/Plugin/Field/FieldFormatter/VatNumberFormatter.php` (`@FieldFormatter id = "vat_formatter"`,
label "Simple formatter for the VAT Number"). Display-only, no settings. Renders each item as
`['#type' => 'html_tag', '#tag' => 'p', '#value' => $item->value]`; core's `html_tag` element runs
`Xss::filterAdmin()` on the string value.

## Render element `vat_number`

`src/Element/VatNumber.php` (`@FormElement("vat_number")`) extends the core `Textfield` element. Use
it directly in any form to get the same validation as the field widget:

```php
$form['vat'] = [
  '#type' => 'vat_number',
  '#title' => $this->t('VAT number'),
  '#validate_vies' => TRUE,            // default FALSE
  '#fail_if_vies_unavailable' => TRUE, // default FALSE
];
```

`getInfo()` appends `[static::class, 'validateVatNumber']` to `#element_validate` and defaults both
extra properties to `FALSE`. `validateVatNumber()` (static) short-circuits on an empty value, then
`str_replace([' ', '.'], '', ...)` the value, writes it back with
`$form_state->setValueForElement()`, instantiates `new VatNumberController($value)`, calls
`check($element['#validate_vies'], $element['#fail_if_vies_unavailable'])`, and on `status === FALSE`
calls `$form_state->setError($element, $message)`. See [../api/validation.md](../api/validation.md)
for what `check()` does.

## Webform element `vat_number` (submodule `webform_vat_number`)

`modules/webform_vat_number/src/Plugin/WebformElement/VatNumber.php`
(`@WebformElement id = "vat_number"`, category "Advanced elements"). The submodule is a separate
module (`webform_vat_number`) that depends on `vat_number` + `webform`; it is **not** enabled by
enabling `vat_number`.

- `getDefaultProperties()` adds `validate_vies => FALSE` and `fail_if_vies_unavailable => FALSE`.
- `form()` adds the two checkboxes under the element's `validation` section (same `#states` gating).
- `prepare()` forces `#validate_vies = FALSE` when the Webform operation is `test` (so test
  submissions never hit VIES). Note it dereferences `$webform_submission` without a null guard even
  though the parameter is nullable.
- `getTestValues()` returns a fixed list of sample VAT numbers (one per country) used by Webform's
  test-data generator.
