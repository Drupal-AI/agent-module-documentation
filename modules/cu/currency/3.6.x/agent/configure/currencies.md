<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currencies and currency locales

## The `currency` config entity

One entity per currency. Entity type id `currency`, **id key `currencyCode`** (the 3-letter
ISO code), config prefix `currency.currency.<CODE>` (e.g. `currency.currency.USD`).
Exported properties (`config_export`): `alternativeSigns`, `currencyCode`, `currencyNumber`,
`label`, `roundingStep`, `sign`, `subunits`, `status`, `usages`, `uuid`.

Only `XXX` ("No currency") ships enabled (`config/install/currency.currency.XXX.yml`). Real
currencies are **imported** from the bundled `commercie/currency` data library.

Admin UI (permission-gated, see permissions doc):
- List: `/admin/config/regional/currency` (`entity.currency.collection`, the `configure` route)
- Add: `/admin/config/regional/currency/add`
- Import: `/admin/config/regional/currency/import` (`currency.currency.import`)
- Edit / delete / enable / disable: `/admin/config/regional/currency/{currency}[/…]`

## Import currencies (the usual way to get USD/EUR/…)

Service `currency.config_importer`:

```php
$importer = \Drupal::service('currency.config_importer');
$importer->getImportableCurrencies();   // codes not yet on the site
$usd = $importer->importCurrency('USD'); // creates currency.currency.USD, returns the entity
```

`importCurrencyLocale('de_DE')` does the same for a `currency_locale`.

## Create a custom currency

```php
use Drupal\currency\Entity\Currency;
Currency::create([
  'currencyCode' => 'ABC',
  'currencyNumber' => '999',
  'label' => 'Alpha Coin',
  'sign' => 'α',
  'subunits' => 100,        // minor units per major unit
  'roundingStep' => '0.01',
  'status' => TRUE,
])->save();
```

Read one back: `drush cget currency.currency.USD` or
`\Drupal::entityTypeManager()->getStorage('currency')->load('USD')`.

## The `currency_locale` config entity

Controls how amounts are punctuated. Entity type `currency_locale`, config prefix
`currency.currency_locale.<locale>` (e.g. `currency.currency_locale.en_US`). Fields:
`locale`, `pattern`, `decimalSeparator`, `groupingSeparator`. Ships with `en_US`
(`pattern: "¤#,##0.00;(¤#,##0.00)"`, `.` decimal, `,` grouping). Admin at
`/admin/config/regional/currency-formatting/locale`. The right locale for the current
language/country is chosen at format time by the `currency.locale_resolver` service.
