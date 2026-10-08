# Reading & writing values in code + the render element

The module stores per-currency prices; it does **not** resolve which price to charge. To use the
stored data you read it yourself.

## Reading stored prices

`CurrenciesPrice` (the field item, `Plugin/Field/FieldType/CurrenciesPrice`) exposes:

```php
/** @var \Drupal\commerce_currencies_price\Plugin\Field\FieldType\CurrenciesPrice $item */
$item = $entity->get('field_currency_prices')->first();

// Preferred: value objects, keyed by currency code, empty numbers skipped.
$prices = $item->toPrices();          // ['USD' => Price('9.99','USD'), 'EUR' => Price('8.50','EUR')]
$usd = $prices['USD'] ?? NULL;        // \Drupal\commerce_price\Price or NULL

// Raw serialized map (magic __get on the item list / item):
$raw = $entity->field_currency_prices->prices;         // ['USD' => ['number' => '9.99', ...], ...]
$raw = $entity->field_currency_prices->get(0)->prices; // same, explicit delta
```

- `toPrices()` (`CurrenciesPrice.php:135`) iterates `toArray()['prices']` and builds a
  `\Drupal\commerce_price\Price((string) $number, $currency_code)` for each entry whose `number` is
  set and not `''`. Missing/empty currencies are simply absent from the returned array — there is **no
  fallback** to another currency, so the caller must handle a currency that has no stored price.
- `toArray()` returns the full stored map (a map item has no fixed properties, so it returns
  `getValue()` verbatim).
- The magic `__get()` returns `[]` for an unset key rather than `NULL`.

## Writing values

```php
$entity->set('field_currency_prices', [
  'prices' => [
    'USD' => ['number' => '9.99', 'currency_code' => 'USD'],
    'EUR' => ['number' => '8.50', 'currency_code' => 'EUR'],
  ],
]);
$entity->save();
```

`setValue()` (`CurrenciesPrice.php:62`) accepts either that array or a serialized string. When given a
string it calls `unserialize($values, ['allowed_classes' => FALSE])` — objects are never restored —
and nulls the value when `prices` is empty.

## Render element `#type => 'commerce_currencies_price'`

`Element/CurrenciesPrice` (extends `FormElementBase`) can be reused in any Form API form, independent
of the field widget:

```php
$form['prices'] = [
  '#type' => 'commerce_currencies_price',
  '#required_prices' => FALSE,
  '#available_currencies' => ['USD', 'EUR'],
  '#default_value' => [
    'prices' => ['USD' => ['number' => '9.99', 'currency_code' => 'USD']],
  ],
];
```

- Element info: `#input`/`#tree`/`#multiple` = TRUE, wrapped in a `container`.
- `processCurrenciesPrice()` builds a `details` sub-element `prices` containing one core
  `commerce_price` element per code in `#available_currencies`, each locked to that single currency
  (`#available_currencies => [$key]`) and `#required` per `#required_prices`.
- `validateCurrenciesPrice()` flattens the submitted `['prices' => …]` back onto the element value.
- Both `#available_currencies` and `#required_prices` are **required** properties when you use the
  element directly (the process callback reads them without a default).
