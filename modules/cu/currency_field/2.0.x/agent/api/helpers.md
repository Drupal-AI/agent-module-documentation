<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data helpers API (currency_field.module)

Two procedural functions expose the bundled ISO 4217 dataset to any code — no field or entity
required. Both read `currencies.yml` fresh from disk each call (no static cache).

## `currency_field_currencies()`
Loads the module's `currencies.yml` via
`\Drupal::service('extension.list.module')->getPath('currency_field')`, decodes it with
`\Drupal\Core\Serialization\Yaml::decode()`, and returns the full array of currency rows. Each row
is an associative array with keys:

- `Entity` — issuing country/entity, upper-case (e.g. `UNITED STATES OF AMERICA`)
- `Currency` — currency name (e.g. `US Dollar`)
- `AlphabeticCode` — ISO 4217 alpha code (e.g. `USD`)
- `NumericCode` — ISO 4217 numeric code (e.g. `840`)
- `MinorUnit` — number of decimal places (e.g. `2`), may be blank
- `WithdrawalDate` — set for withdrawn currencies, otherwise null

The list is the full dataset (~2,600 rows including historical/withdrawn entries), so it contains
one row per country, not per code — codes like `EUR` appear many times.

## `currency_field_currency_options($blank = TRUE, $format = ['AlphabeticCode' => 'Currency'])`
Returns a Form API `#options` array. `$format` is a one-entry map `['<keyColumn>' => '<labelColumn>']`:
options are keyed by `<keyColumn>` and labelled by `<labelColumn>`. Because it uses
`array_combine(keys, values)`, duplicate keys collapse to a single option. If `<labelColumn>` is
`Entity`, labels are normalized with `ucwords(strtolower(...))`. When `$blank` is `TRUE` the
returned array is prepended with an empty entry (the leading key/value pair produced by the blank
row of the dataset).

Example — codes as keys, currency names as labels:
```php
$options = currency_field_currency_options(FALSE, ['AlphabeticCode' => 'Currency']);
// ['USD' => 'US Dollar', 'EUR' => 'Euro', ...]
```

The widget calls it as
`currency_field_currency_options(!$element['#required'], ['AlphabeticCode' => $display])`.

## Notes
- No external network access; the dataset is a static file shipped with the module.
- Values are plain strings — safe for Views filters, migrations, JSON:API export, and custom forms.
