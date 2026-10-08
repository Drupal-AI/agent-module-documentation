<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange Rate — install & settings

## Install / enable
```
composer require drupal/exchangerate   # or place in modules/contrib
drush en exchangerate -y
```
Enables core `block`, `rest`, `serialization` (declared deps). No composer.json ships with the module.

## API key
The module needs an ExchangeRate-API v6 key (free tier: 1,500 req/month). It is entered on the settings form and saved into `exchangerate.settings` config under `api_key`. There is NO environment-variable, `getenv()`, dotenv, or Key-module integration — the value lives in configuration. `getRates()` returns `[]` (blocks show an "unavailable" message; JSON/REST return 503) whenever `api_key` is empty.

The rate feed is fetched from a fixed URL built in `ExchangeRateApi::getRates()`:
`https://v6.exchangerate-api.com/v6/{api_key}/latest/{base_currency}`. The host is not configurable and neither `base_currency` (a `<select>` limited to the built-in catalogue) nor the key is taken from request input.

## Settings form
Route `exchangerate.settings_form` → `/admin/config/system/exchangerate`, form `\Drupal\exchangerate\Form\SettingsForm` (extends `ConfigFormBase`), permission `administer exchangerate`. Menu link + local task at that path. Form id `exchangerate_settings_form`; editable config `exchangerate.settings`.

## Config object `exchangerate.settings`
Schema: `config/schema/exchangerate.schema.yml` (type `config_object`). Install defaults: `config/install/exchangerate.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | ExchangeRate-API v6 key. Required by the form. |
| `base_currency` | string | `USD` | ISO 4217 base; all rates are relative to it. Changing it makes the old cache entry (`exchangerate_rates_{BASE}`) obsolete. |
| `ssl_verify` | boolean | `true` | Passed to the Guzzle client (`verify` option) for the rate fetch. Form label warns to disable only for local-dev TLS troubleshooting. |
| `decimal_places` | integer | `4` | Global display precision (0–8), validated in `validateDecimalPlaces()`. |
| `number_format` | string | `dot` | `dot` → `1,234.5678`; `comma` → `1.234,5678` (`formatRate()`). |
| `show_last_updated` | boolean | `false` | Global toggle for the block "Last updated" line. |
| `cache_enabled` | boolean | `true` | Store the API response in `cache.default`. |
| `cache_time` | integer | `1` | Cache duration (with `cache_unit`); max 1 day, enforced in `validateCacheDuration()`. |
| `cache_unit` | string | `hours` | `minutes` or `hours`. |

Form field names are prefixed `exchangerate_*` but `submitForm()` maps them to the unprefixed config keys above.

## Caching behaviour (`ExchangeRateApi`)
- Cache id: `exchangerate_rates_{BASE_CURRENCY}` in `cache.default`; stored value: `['date','timestamp','last_update','rates']`.
- On read, a cache hit is used only if `cache_enabled` AND the stored `date` equals today (`date('Y-m-d')`) — a day boundary always forces a refetch.
- On write, expiry = `getCacheTimestamp()` = `time() + cache_time * (60 | 3600)`; if caching disabled, entry is stored with `CACHE_PERMANENT` (expire 0) but the daily-date check still forces refresh.
- `clearCache($base = NULL)` deletes one currency's entry, or `deleteAll()` on the cache bin when null.
- API errors: an ExchangeRate-API error body (`result === 'error'`) is logged with its `error-type` (not the URL) to the `exchangerate` logger channel and returns `[]`; Guzzle `ConnectException`/`RequestException` are caught and logged.

## Useful drush
```
drush cget exchangerate.settings
drush cset exchangerate.settings base_currency EUR && drush cr
drush cset exchangerate.settings api_key "<key>" && drush cr
```
