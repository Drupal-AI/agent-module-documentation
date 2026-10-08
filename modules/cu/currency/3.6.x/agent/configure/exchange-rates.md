<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange rates and conversion

Conversion is done by **exchange rate provider** plugins (`@CurrencyExchangeRateProvider`),
stacked and queried through the `currency.exchange_rate_provider` service. Two ship:

- `currency_fixed_rates` — rates you enter by hand (config `currency.exchanger.fixed_rates`).
- `currency_historical_rates` — historical rates bundled with the exchange library.

## Which providers are enabled

Config `currency.exchange_rate_provider`:

```yaml
plugins:
  - { plugin_id: currency_fixed_rates, status: true }
  - { plugin_id: currency_historical_rates, status: true }
```

Order = weight (first match wins in the stack). Admin form:
`/admin/config/regional/currency-exchange` (`currency.exchange_rate_provider.config`).
Programmatically: `Drupal\currency\PluginBasedExchangeRateProvider::loadConfiguration()` /
`saveConfiguration([$plugin_id => bool])`.

## Fixed rates

Managed at `/admin/config/regional/currency-exchange/fixed` (add/edit forms). Stored in
`currency.exchanger.fixed_rates` as:

```yaml
rates:
  - { currency_code_from: EUR, currency_code_to: USD, rate: '1.25' }
```

Set one via the plugin (this is the supported write path):

```php
$fixed = \Drupal::service('plugin.manager.currency.exchange_rate_provider')
  ->createInstance('currency_fixed_rates');
$fixed->save('EUR', 'USD', '1.25');   // writes currency.exchanger.fixed_rates
$fixed->load('EUR', 'USD');           // ExchangeRate object, ->getRate() === '1.25'
$fixed->delete('EUR', 'USD');
```

## Loading a rate / converting

```php
$provider = \Drupal::service('currency.exchange_rate_provider');
$rate = $provider->load('EUR', 'USD');   // stacks all enabled providers
if ($rate) {
  $converted = bcmul('100', $rate->getRate(), 6);   // 100 EUR in USD
}
```

**Gotcha:** `->load($from, $to)` throws a TypeError (in the stacked decorator) when *no*
provider can supply the pair rather than returning NULL — ensure a fixed/historical rate
exists for the pair before calling, or wrap in a try/catch. The `currency_exchange` text
filter handles this by falling back to the original token.
