<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `currencyapi.service` API and cron fetch

Service id **`currencyapi.service`** → `Drupal\currencyapi\CurrencyApiService`
(`src/CurrencyApiService.php`), constructed with `@config.factory` and `@keyvalue.expirable`.
Get it with `\Drupal::service('currencyapi.service')`.

## Storage model

Rates live in the **expirable key/value** collection **`currencyapi.com`**, key **`rates`**. The
stored value is the CurrencyAPI.com response `data` array, keyed by currency code, each entry like
`{"code": "USD", "value": 1.08, "is_default": false}`. `setDefaultCurrency()` marks the first code in
`currencies` as `is_default = true` before saving.

## Methods (source-accurate)

- `fetchExchangeRates(): ?array` — reads `api_key` + `currencies` from config, throws
  `\RuntimeException` if the key is empty, builds the URL, calls the API, marks the default currency,
  stores `response['data']` under `rates`, returns the response or NULL. **Live API call.**
- `buildApiUrl($api_key, $currencies): string` — `sprintf('https://api.currencyapi.com/v3/latest?apikey=%s&base_currency=%s&currencies=%s', urlencode(...))`.
  Host is **hardcoded**; `base_currency` and `currencies` both come from `$currencies` (first element
  is the base). Ignores the `api_url` config key.
- `makeApiRequest($d): ?array` — `@file_get_contents($url, FALSE, $context)` with a 10s HTTP stream
  context and `Accept: application/json`. On failure logs `currencyapi` error "Failed to fetch
  exchange rates…" (no URL/key in the message) and returns NULL; otherwise `json_decode(..., TRUE)`.
- `getAllRates(): array` — returns the stored `rates` array (or `[]`).
- `convert(float $amount, string $from, string $to)` — same-currency returns the amount; when
  `$from === 'EUR'` (hardcoded, see caveat) multiplies by `rates[$to]['value']`; otherwise divides
  amount by `rates[$from]['value']`. Result is passed through `formatCurrency()` (a string). Note the
  `$from === $to` branch does not early-return, so it is overwritten by the following branches.
- `sell(float $amount, string $in_currency, string $out_currency)` — converts, then adds
  `conversion / 100 * buyrate_<in_currency>` (the per-currency markup) and returns the total.
- `getLastUpdate(): ?int` — reads `_last_update` from key/value collection `currencyapi_rates` (a
  **different** collection than where cron writes `last_update`, so this returns NULL in practice).
- `formatCurrency($number)` — `number_format($number, 2, '.', ' ')` (thousands separator is a space).
- `applyCurrencyApi($number)` — returns `$number * 100`.
- `weBuy($code, $d)` — computes `buy_at_buy = buy_at_base + buy_at_base/100*buy` for the markup table.
- `getDefaultCurrency(&$d)` / `setDefaultCurrency(&$d)` — locate/mark the `is_default` currency.
- `ceil($float)` — `(int)($float + 0.5)`.
- **Empty stubs:** `getRate(string $currency): ?float {}` and `getSystemCurrencies() {}` return
  nothing — do not rely on them.

## Caveats when calling the API

- `convert()` and the default-currency logic hardcode/assume `EUR` in places (marked `@todo` in
  source); results are correct only when EUR is effectively the base.
- Return types are inconsistent: `convert()`/`sell()`/`formatCurrency()` yield **strings**
  (formatted), while callers sometimes cast back to `(float)`.
- `getAllRates()` returns `[]` until cron (or a manual `fetchExchangeRates()`) has populated the
  store.

## Cron

`currencyapi_cron()` → `currencyapi.cron` (`CurrencyApiCron`, arg `@state` but it actually uses
`config.factory`). `cron()` calls `shouldRun($now)`: runs when `now > last_update + 86400`. When it
runs it calls `queueTasks()` (which directly calls `fetchExchangeRates()` — no real queue) and saves
`last_update = now` into `currencyapi.settings`. Net effect: **one fetch per 24h**. Force a refresh
by clearing `last_update` (or waiting out the interval) and running `drush cron`.
