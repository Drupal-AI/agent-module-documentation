<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Exchanger NBU (commerce_exchanger_nbu) — agent index

A single **Commerce Exchanger provider plugin** that fetches official currency exchange rates from the
**National Bank of Ukraine (NBU)** public API and hands them to the `commerce_exchanger` framework, which
stores them for Drupal Commerce price conversion. The plugin's base currency is **UAH**. Package
`Commerce (Contrib)`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed as **1.2.0** (version dir `1.2.x`).

## Dependencies

- Drupal module: **`commerce_exchanger`** (required, from `.info.yml`); it in turn builds on Drupal Commerce.
- Composer: **`drupal/commerce_exchanger` `^2`** (`composer.json`). No PHP libraries of its own.

## What it provides (from source)

The whole module is **one plugin class** plus an install-time requirement check. There are no routes,
controllers, services, permissions, config schema, forms, or `.module` file.

- **Exchanger provider plugin** `nbu` — `src/Plugin/Commerce/ExchangerProvider/NbuExchanger.php`, class
  `NbuExchanger extends ExchangerProviderRemoteBase` (from `commerce_exchanger`). Annotation
  `@CommerceExchangerProvider`: `id = "nbu"`, label/display_label "National Bank of Ukraine",
  `historical_rates = TRUE`, `base_currency = "UAH"`, `refresh_once = TRUE`, `transform_rates = TRUE`.
  - `apiUrl()` returns the hardcoded endpoint
    `https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json` (HTTPS, no credentials, no query
    parameters beyond `?json`).
  - `getRemoteData($base_currency = NULL)` calls the inherited `apiClient([])` (a Guzzle GET), then
    `Json::decode()`s the body and flattens it into `[$exchange['cc'] => $exchange['rate']]` — an
    ISO-code → rate map. Returns `NULL` when the request fails/empties.
- **Install requirement** `commerce_exchanger_nbu.install` — `hook_requirements('install')` blocks
  installation with `REQUIREMENT_ERROR` unless the **UAH** `commerce_currency` entity exists.

## How rates flow (behaviour lives in the parent)

All fetch orchestration, cross-sync recalculation, and storage live in `commerce_exchanger`'s
`ExchangerProviderRemoteBase` / `ExchangerProviderBase`, not here:

- `apiClient()` (parent) does `httpClientFactory->fromOptions()` then `client->request('GET', apiUrl(), [])`,
  returning the response body string; Guzzle exceptions are logged, not thrown. **Default TLS verification
  applies** — no `verify => false` anywhere.
- `import()` (parent) builds rates via `buildExchangeRates()` → cross-sync calculation, stores the latest
  set, and (because `historical_rates = TRUE`) also stores a historical snapshot. Refresh is driven by the
  framework's cron handling; `refresh_once = TRUE` means one fetch per run.
- Provider selection, the settings form, and the `administer commerce_exchanger`-style gating are all
  provided by the `commerce_exchanger` module — this module adds no admin UI of its own.

This module's surface is small enough that no further agent subdocs are warranted; the source is two files.
