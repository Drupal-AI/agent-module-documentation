# Field type, widget & formatter

The module provides one field type and its default widget/formatter. Everything is configured on the
entity's **field storage/instance** and **form-display** — there is no module settings page.

| Plugin | id | Class |
|---|---|---|
| Field type | `commerce_currencies_price` | `Plugin/Field/FieldType/CurrenciesPrice` |
| Widget | `commerce_currencies_price_default` | `Plugin/Field/FieldWidget/CurrenciesPriceDefaultWidget` |
| Formatter | `commerce_currencies_price_formatter` | `Plugin/Field/FieldFormatter/CurrenciesPriceFormatter` |

## Field type `commerce_currencies_price`

Stores all currency prices in **one serialized blob column**, not one row per currency.

- Storage schema (`CurrenciesPrice::schema()`): single column `prices` — `type: blob`, `size: big`,
  `not null: FALSE`, `serialize: TRUE`.
- Property (`propertyDefinitions()`): `prices` = `MapDataDefinition` (an open map, so keys are not
  pre-declared). `mainPropertyName()` returns `NULL`.
- Attribute metadata: `category: "commerce"`, `default_widget: "commerce_currencies_price_default"`,
  `default_formatter: "commerce_currencies_price_formatter"`. Cardinality is not restricted (unlimited
  by default; add multiple deltas if needed).
- `isEmpty()` treats the item as empty when `values['prices']` is empty **or** its first key is empty
  (an unsubmitted widget leaves a stray empty-string key).
- The stored map shape is `['prices' => ['USD' => ['number' => '9.99', 'currency_code' => 'USD'],
  'EUR' => ['number' => '8.50', 'currency_code' => 'EUR'], …]]`.

## Widget `commerce_currencies_price_default`

Renders the `commerce_currencies_price` render element (one `commerce_price` sub-field per currency).

Form-display settings (`defaultSettings()` / `settingsForm()`):

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `required_prices` | checkbox (bool) | `FALSE` | If on, a price is `#required` for **every** available currency. |
| `available_currencies` | checkboxes (currency codes) | `[]` | Which currencies get an input. Empty = **all** currencies with `status = TRUE`. |

- The currency option list comes from `getEnabledCurrencies()`:
  `entityTypeManager->getStorage('commerce_currency')->loadByProperties(['status' => TRUE])`.
- `getAvailableCurrencies()` drops unchecked entries and falls back to all enabled currencies when
  none are selected.
- `formElement()` seeds `#default_value` from `$item->toArray()` (empty on a new entity), and passes
  `#required_prices` + `#available_currencies` to the render element.
- `massageFormValues()` reshapes submitted values to `[$delta => ['prices' => …]]` before save.

Set the widget from code:

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('commerce_product_variation', 'default', 'default')
  ->setComponent('field_currency_prices', [
    'type' => 'commerce_currencies_price_default',
    'settings' => [
      'required_prices' => FALSE,
      'available_currencies' => ['USD' => 'USD', 'EUR' => 'EUR'],
    ],
  ])->save();
```

## Formatter `commerce_currencies_price_formatter`

`viewElements()` returns `[]` — the field renders **nothing** on entity display. To show per-currency
prices, read the value in code (see [../api/index.md](../api/index.md)) and build your own render
array, or use a custom Twig/formatter. There are no formatter settings.
