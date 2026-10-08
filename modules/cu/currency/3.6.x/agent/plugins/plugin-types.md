<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types you can extend

Currency defines two annotation-based plugin types. Discovery is under
`src/Plugin/Currency/<Type>/` in any module.

## 1. Amount formatter — `@CurrencyAmountFormatter`

- Annotation: `Drupal\currency\Annotation\CurrencyAmountFormatter` (`id`, `label`,
  optional `operations_provider`).
- Manager: `plugin.manager.currency.amount_formatter`.
- Interface: `AmountFormatterInterface::formatAmount(CurrencyInterface $currency, $amount, $language_type)`.
- Ship example: `Basic` (`id = currency_basic`).

```php
namespace Drupal\my_module\Plugin\Currency\AmountFormatter;

use Drupal\currency\Plugin\Currency\AmountFormatter\AmountFormatterInterface;
use Drupal\Core\Plugin\PluginBase;

/**
 * @CurrencyAmountFormatter(
 *   id = "my_module_accounting",
 *   label = @Translation("Accounting style")
 * )
 */
class Accounting extends PluginBase implements AmountFormatterInterface {
  public function formatAmount(/* CurrencyInterface */ $currency, $amount, $language_type = 'language_content') {
    // return a formatted string
  }
}
```

Select your formatter as the site default on `/admin/config/regional/currency-formatting`
(stored in `currency.amount_formatting` → `plugin_id`).

## 2. Exchange rate provider — `@CurrencyExchangeRateProvider`

- Annotation: `Drupal\currency\Annotation\CurrencyExchangeRateProvider` (`id`, `label`,
  optional `operations_provider`).
- Manager: `plugin.manager.currency.exchange_rate_provider`.
- Interface: `ExchangeRateProviderInterface` — implement `load($from, $to)` (return an
  `ExchangeRate` or NULL) and `loadMultiple(array $pairs)`.
- Ship examples: `FixedRates` (`currency_fixed_rates`), `HistoricalRates`
  (`currency_historical_rates`).

```php
/**
 * @CurrencyExchangeRateProvider(
 *   id = "my_module_api_rates",
 *   label = @Translation("Live API rates")
 * )
 */
class ApiRates extends PluginBase implements ExchangeRateProviderInterface { /* load()/loadMultiple() */ }
```

Enable it (and order it in the stack) at `/admin/config/regional/currency-exchange`
(config `currency.exchange_rate_provider` → `plugins`). The stacked
`currency.exchange_rate_provider` service then consults it when resolving a pair.

Both managers are cache-cleared via the `plugin_manager_cache_clear` tag, so `drush cr`
picks up a new plugin class.
