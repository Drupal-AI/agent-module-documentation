<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Exchanger provides currency exchange rates for Drupal Commerce 2/3: each rate source is a `commerce_exchange_rates` config entity backed by a provider plugin (manual entry or a remote API), and a calculator service converts a `Price` from one currency to another using the stored rates.

---

Commerce Exchanger adds a configurable exchange-rate layer on top of Commerce's `commerce_price`. You create one or more **Exchange rates** config entities (`commerce_exchange_rates`) at *Commerce → Configuration → Exchange rates*, each choosing a **provider plugin**: `manual` (rates you type in and maintain), or a remote provider (`ecb` European Central Bank, `fixer`, `currencylayer`, `open_exchange_rates`, `transferwise`) that fetches ratios from an external API on cron. Rates are stored in two dedicated database tables (`commerce_exchanger_latest_rates` and, optionally, `commerce_exchanger_historical_rates` keyed per day) via the `commerce_exchanger.manager` service, not in config. The `commerce_exchanger.calculate` service (`DefaultExchangerCalculator`) reads the active provider's latest rates and exposes `priceConversion(Price $price, string $target_currency)` to convert and round a price; it picks the first enabled provider. A `commerce_price_exchanger` field formatter renders any price field converted to a chosen target currency. Provider plugins are annotation/attribute plugins in the `Plugin\Commerce\ExchangerProvider` namespace; writing a new remote provider is mostly implementing `apiUrl()` and `getRemoteData()`. Remote providers support enterprise mode (fetch by any base currency), cross-sync (derive non-base pairs by cross conversion), rate transforming (reverse ratios), and manual per-currency overrides that survive automated syncs. The module integrates with Commerce Currency Resolver for storefront multi-currency display.

---

- Convert an order total or product price from EUR to USD using stored exchange rates.
- Maintain exchange rates by hand for currencies your finance team fixes manually.
- Import daily EUR-based rates automatically from the European Central Bank on cron.
- Pull rates from Fixer, Currencylayer, or Open Exchange Rates using an API key.
- Fetch rates from TransferWise for mid-market currency conversion.
- Display product prices in a visitor's currency with the `commerce_price_exchanger` field formatter.
- Override a single currency pair's ratio manually while the rest sync automatically from the API.
- Store long-term historical rates per day for auditing or reporting.
- Provide multi-currency pricing together with the Commerce Currency Resolver module.
- Programmatically convert a `Price` in custom code via the `commerce_exchanger.calculate` service.
- Write rates directly into the rates table from custom code with `commerce_exchanger.manager` `setLatest()`.
- Run several exchange-rate sources side by side (e.g. a manual set and a remote set).
- Cross-calculate non-base currency pairs when a provider only supplies a single base currency (like ECB).
- Reverse-transform provider ratios that publish target→source instead of source→target.
- Refresh rates only once per day for providers whose free tier updates daily.
- Add a custom remote provider plugin for a national bank by implementing `apiUrl()` and `getRemoteData()`.
- Strip trailing zeroes or force a currency symbol when formatting a converted price.
- Trigger a manual rates import from the Exchange rates collection page's "Run import" action.
- Gate access to exchange-rate configuration with the "administer commerce exchanger settings" permission.
- Round converted prices consistently using Commerce's price rounder.
- Show a secondary "approximately X USD" price beside the primary currency on a product page.
- Keep base-currency rates authoritative while deriving all other conversions from them.
- Back a currency switcher's conversions with a single manual rate source.
- Seed a test/staging site with fixed manual rates so checkout math is deterministic.
- Feed converted prices into reports without calling any external API at request time.
- Migrate legacy hard-coded conversion ratios into a managed exchange-rate entity.
