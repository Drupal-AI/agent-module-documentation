<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange Rate — HTTP endpoints

Two independent HTTP surfaces expose the same data. Both return `[]`/error when no API key is configured.

## A. Custom JSON routes (no core REST config needed)
Defined in `exchangerate.routing.yml`, served by `\Drupal\exchangerate\Controller\CurrencyController` (returns `JsonResponse`). All four data routes require the `access exchangerate rest api` permission.

| Route id | Path | Methods | Method |
|---|---|---|---|
| `exchangerate.api.rates` | `/api/exchangerate/rates` | GET | `rates()` |
| `exchangerate.api.rate` | `/api/exchangerate/rates/{from}/{to}` | GET | `rate()` — `from`/`to` constrained to `[A-Z]{3}` |
| `exchangerate.api.convert` | `/api/exchangerate/convert` | GET, POST | `convert()` |
| `exchangerate.api.currencies` | `/api/exchangerate/currencies` | GET | `currencies()` |

- `rates()` — `{base, base_info, date, timestamp, count, rates:{CODE:{code,rate,symbol,name,flag}}}`; 503 with `{error,status}` when rates empty.
- `rate()` — `{from,to,rate,from_info,to_info,date,timestamp}`; 404 when the pair is unavailable.
- `convert()` — reads GET query and, for POST, merges the decoded JSON body. Params: `from` (req), `to` (req; comma-string or array), `amount` (req, >0), `decimals` (0–8, default 2). Validates each and returns 400 on bad input. Response `{from,from_info,amount,decimals,date,timestamp,results:{CODE:{…,converted,rate,…}},errors,success_count,error_count}`.
- `currencies()` — `{count, currencies:{CODE:{code,name,symbol,flag,available}}}`; `available` = code present in live rates.

### Autocomplete routes
`exchangerate.autocomplete` (`/exchangerate/autocomplete`) and `exchangerate.autocomplete_multiple` (`/exchangerate/autocomplete_multiple`), permission `access content`, `CurrencyController::autocomplete()`/`autocompleteMultiple()`. Match the `q` query against the built-in country catalogue (name or code) and return `[{value,label,flag_emoji,symbol}]`. Used by the converter form/block autocomplete fields.

## B. Core REST resources (`@RestResource`)
Require the core REST + Serialization modules and must be enabled/configured at `/admin/config/services/rest`. Access is controlled by the standard `restful get/post <plugin id>` permissions.

- `exchangerate_rates` — `src/Plugin/rest/resource/ExchangeRateResource.php`, canonical `/api/v1/exchangerate`, `get()` returns the enriched rates payload (`{base,base_info,count,date,timestamp,rates}`); throws `ServiceUnavailableHttpException` when rates are empty. Adds cache tag `config:exchangerate.settings`, max-age 3600.
- `exchangerate_conversion` — `src/Plugin/rest/resource/CurrencyConversionResource.php`, canonical/create `/api/v1/exchangerate/convert`, `post($data)` with body `{from, to (string|array), amount, decimals?}`; validates (BadRequest/UnprocessableEntity) and returns the same conversion shape as the custom `convert()` route.

Both resources delegate all logic to the `exchangerate.api` service; they inject `current_user` but do not add extra per-request access checks beyond the REST permission layer.
