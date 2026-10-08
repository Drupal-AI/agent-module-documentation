<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & the `decimal_string` form element

Two stateless services (declared in `decimal.services.yml`, no constructor args) plus a reusable
render element. Both services wrap `brick/math` `BigDecimal`.

## `decimal.normalizer` — `Drupal\decimal\DecimalNormalizer`

Implements `DecimalNormalizerInterface`.

```php
public function normalize(string $decimal, array $options = []): string|bool
```

Cleans the input, then checks it parses as a `BigDecimal`. Returns the **cleaned string** on
success or `FALSE` on invalid input. Cleanup (`cleanup()`) applies literal `str_replace`:

- space → removed
- `,` → `.`
- `+` → removed
- non-breaking space (`0xC2 0xA0`) → removed

Used by `DecimalStringItem::preSave()` and by the form element's validator. Note: it does not
strip `-`, so negative values parse; `$options` is accepted but unused.

## `decimal.formatter` — `Drupal\decimal\DecimalFormatter`

Implements `DecimalFormatterInterface`.

```php
public function format(string $decimal, array $options = []): string
```

Empty/falsy input is treated as `'0'`. Builds `BigDecimal::of($decimal)`; if `options['scale']`
is set, calls `->toScale($scale, $options['rounding'] ?? RoundingMode::HALF_UP)`. Returns the
BigDecimal cast to string. Used by `DecimalStringFormatter::numberFormat()` and by the form
element's `valueCallback()`.

## Form element `decimal_string` — `Drupal\decimal\Element\DecimalString`

`@FormElement("decimal_string")`, extends `FormElementBase`. Renders as a text input
(`preRenderNumber()` sets `type=text`, theme `input__textfield`). Defaults: `#size`/`#maxlength`
32, `#max_fraction_digits` 18. Use it directly in a custom form:

```php
$form['amount'] = [
  '#type' => 'decimal_string',
  '#title' => t('Amount'),
  '#default_value' => '18.99',
  '#min' => 0,
  '#required' => TRUE,
];
```

- `valueCallback()`: on default value, formats the stored string via `decimal.formatter` (strips
  extra zeroes); on input, trims and returns the scalar (non-scalar → `''`).
- `validateDecimal()` (`#element_validate`): trims; empty is allowed; normalizes via
  `decimal.normalizer` and sets a "%title must be a decimal" error if it returns `FALSE`; enforces
  `#min`/`#max`; on success writes the normalized value back with `setValueForElement()`.
- `processElement()`: adds a default `blur` AJAX event when `#ajax` is set without one.

No routes, permissions, or hooks beyond `hook_help()` and `hook_requirements()`.
