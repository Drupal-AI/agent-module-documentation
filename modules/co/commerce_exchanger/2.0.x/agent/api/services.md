<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, rates storage, and price conversion

Four services (`commerce_exchanger.services.yml`):

| Service id | Class | Use |
|---|---|---|
| `commerce_exchanger.calculate` | `DefaultExchangerCalculator` | convert a `Price` between currencies |
| `commerce_exchanger.manager` | `ExchangerManager` | read/write the rate tables |
| `commerce_exchanger.import` | `DefaultExchangerImporter` | fetch remote rates now |
| `plugin.manager.commerce_exchanger_provider` | `ExchangerProviderManager` | provider plugin manager |

## Convert a price

```php
/** @var \Drupal\commerce_exchanger\ExchangerCalculatorInterface $calc */
$calc = \Drupal::service('commerce_exchanger.calculate');
$converted = $calc->priceConversion($price, 'USD');   // returns a rounded \Drupal\commerce_price\Price
$rates = $calc->getExchangeRates();                    // [source][target] => ['value'=>..,'manual'=>..]
$id = $calc->getExchangerId();                          // id of the first ENABLED provider
```

- `priceConversion(Price $price, string $target_currency)` looks up
  `rates[source][target]['value']`, calls `$price->convert(...)`, and rounds via
  `commerce_price.rounder`. If no rate exists it throws
  `ExchangeRatesDataMismatchException`. Same-currency input is returned unchanged.
- `DefaultExchangerCalculator::getExchangerId()` returns the **first provider whose
  `status()` is true** — enable exactly one (or order carefully) when you rely on it.

## Read / write rates directly

Rates are stored in DB tables, not config. Table name constants live on
`ExchangerManagerInterface`: `EXCHANGER_LATEST_RATES = 'commerce_exchanger_latest_rates'`,
`EXCHANGER_HISTORICAL_RATES = 'commerce_exchanger_historical_rates'`,
cache tag `EXCHANGER_RATES_CACHE_TAG = 'commerce_exchanger_latest'`.

```php
/** @var \Drupal\commerce_exchanger\ExchangerManagerInterface $mgr */
$mgr = \Drupal::service('commerce_exchanger.manager');

// Overwrite the latest rates for a provider (id = the config entity id).
$mgr->setLatest('my_rates', [
  'USD' => [
    'EUR' => ['value' => '0.92', 'manual' => 0],
    'GBP' => ['value' => '0.79', 'manual' => 0],
  ],
]);

$latest = $mgr->getLatest('my_rates');          // [source][target] => ['value','manual']
$mgr->setHistorical('my_rates', $rates, '2026-01-01');
$hist = $mgr->getHistorical('my_rates', '2026-01-01');
```

- `setLatest()` **replaces** all rows for that exchanger id (delete + insert) and
  invalidates the `commerce_exchanger_latest` cache tag. Values must be numeric strings
  (throws `\RuntimeException` otherwise); use `.` as the decimal separator.
- `manual => 1` marks a rate as manually overridden so automated syncs skip it.

## Field formatter

`commerce_price_exchanger` (`PriceExchangerFormatter`) renders a price field converted to a
`target_currency` (settings: `target_currency`, `currency_display`, `strip_trailing_zeroes`).
Attach it to any price field's display to show a converted amount.
