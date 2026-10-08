<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange Rate — the `exchangerate.api` service

Service id `exchangerate.api` → `\Drupal\exchangerate\Service\ExchangeRateApi` (`src/Service/ExchangeRateApi.php`). Constructor args (see `exchangerate.services.yml`): `config.factory`, `http_client_factory`, `cache.default`, `logger.factory`, `module_handler`, `string_translation`. Inject it, or `\Drupal::service('exchangerate.api')`.

## Public methods
- `getRates(): array` — returns the `conversion_rates` map (`['USD'=>1.0,'EUR'=>0.92,…]`) for the configured base currency, from cache when valid else from the API. Returns `[]` when `api_key` is empty or on any fetch/API error.
- `getBaseCurrency(): string` — reads `base_currency` from config.
- `convert(string $from, string $to, float $amount, int $decimals = 2): ?float` — converts an amount, handling three cases against the base currency: same-currency (returns rounded amount), `from`==base (`amount * rate[to]`), `to`==base (`amount / rate[from]`), else cross-rate (`amount / rate[from] * rate[to]`). Codes are upper-cased. Returns `NULL` when rates are empty or a code is missing (logs a warning).
- `getRate(string $from, string $to): ?float` — `convert($from, $to, 1.0, 6)`; the live pair rate at 6 dp, or `NULL`.
- `getSupportedCurrencies(): array` — `array_keys(getRates())`; codes present in the live feed.
- `getCountries(): array` — the built-in catalogue (~160 entries) keyed by ISO 4217 code; each value `['name' (translated), 'currency_code', 'currency_symbol', 'flag_emoji']`. Runs `hook_exchangerate_countries_alter()` before returning.
- `formatRate(float $rate, ?int $decimals = NULL): string` — `number_format` using config `decimal_places` (default 4) and `number_format` (`dot`|`comma`).
- `getLastUpdated(): ?string` — the `last_update`/`date` string from the current cache entry, else `NULL`.
- `clearCache(?string $baseCurrency = NULL): void` — deletes `exchangerate_rates_{BASE}` or `deleteAll()`.
- `isCacheEnabled(): bool`, `getCacheTimestamp(): int` — config helpers (see config/settings.md).

## Example
```php
public function __construct(protected readonly ExchangeRateApi $er) {}
public static function create(ContainerInterface $c): static {
  return new static($c->get('exchangerate.api'));
}
// ...
$eur = $this->er->convert('USD', 'EUR', 100.0, 2); // 92.31 or NULL
$rate = $this->er->getRate('USD', 'JPY');          // 157.006 or NULL
```

## Hook: `hook_exchangerate_countries_alter(array &$countries)`
Documented in `exchangerate.api.php`. Invoked at the end of `getCountries()` so other modules can add/modify/remove entries (keyed by currency code, each with `name`, `currency_code`, `currency_symbol`, `flag_emoji`).
```php
function my_module_exchangerate_countries_alter(array &$countries): void {
  $countries['XAU'] = ['name' => t('Gold'), 'currency_code' => 'XAU', 'currency_symbol' => 'Au', 'flag_emoji' => '🥇'];
  unset($countries['KPW']);
}
```
