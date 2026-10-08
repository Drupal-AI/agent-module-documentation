<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fetches live currency exchange rates from ExchangeRate-API and exposes them through configurable blocks, an AJAX converter, an injectable service, and JSON/REST endpoints.

---

Exchange Rate is a currency-rate integration for Drupal 10 and 11. Once an ExchangeRate-API v6 key and a base currency are set on the settings form (`/admin/config/system/exchangerate`), the module pulls the daily rate table for that base currency, caches it in Drupal's default cache backend for a configurable duration, and enriches every currency with a built-in catalogue of ~160 country names, ISO 4217 symbols, and flag emojis. Site builders get two blocks (a rates display with six CSS layouts and an AJAX converter form), and developers get the `exchangerate.api` service plus two ways to read data over HTTP: lightweight custom JSON routes under `/api/exchangerate/*` and formal `@RestResource` plugins under `/api/v1/exchangerate` for the core REST module. The single altable hook, `hook_exchangerate_countries_alter()`, lets other modules add, change, or remove currencies in the catalogue.

---

- Display a live exchange-rate table for a chosen set of currencies in any block region.
- Let visitors convert an amount from one currency into several targets at once with an inline AJAX form.
- Add a currency converter to a page without writing any JavaScript or custom code.
- Show rates relative to a site-wide base currency (default USD) that an admin can change.
- Pick and drag-order exactly which currencies/countries appear in the rates block.
- Choose among six responsive display layouts (list, flex cards, CSS grid, dark gradient, striped table) for the rates block.
- Show or hide flag emojis, currency symbols, and country names per block.
- Render a rich-text description above the rates list using an allowed text format.
- Display a "Last updated" timestamp reflecting the last successful API fetch.
- Format rate numbers in dot (`1,234.5678`) or comma (`1.234,5678`) style with 0–8 decimal places.
- Cache the daily rate table to stay within a free-tier API quota (1,500 requests/month).
- Convert prices in a custom module by injecting the `exchangerate.api` service and calling `convert()`.
- Look up a single live pair rate programmatically with `getRate('USD', 'EUR')`.
- Expose rates to a decoupled/JS front end via `GET /api/exchangerate/rates` (JSON).
- Fetch one pair over HTTP with `GET /api/exchangerate/rates/{from}/{to}`.
- Convert amounts over HTTP with `GET`/`POST /api/exchangerate/convert` (single or multiple targets).
- List every supported currency and whether live data is available via `GET /api/exchangerate/currencies`.
- Serve rates and conversions to authenticated API clients through core REST resources at `/api/v1/exchangerate` and `/api/v1/exchangerate/convert`.
- Gate all HTTP data access behind the `access exchangerate rest api` permission.
- Add, rename, or remove currencies in the catalogue from a custom module via `hook_exchangerate_countries_alter()`.
- Power a currency-autocomplete widget (country name or code) via the `/exchangerate/autocomplete` route.
- Override the block/converter Twig templates and CSS in a custom theme for full visual control.
- Support travel, banking, e-commerce, and reporting sites that need up-to-date foreign-exchange figures.
- Clear cached rate data for one base currency or all currencies with the service's `clearCache()`.
