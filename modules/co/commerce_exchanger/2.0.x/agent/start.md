<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Exchanger — agent index

Currency exchange rates for Drupal Commerce 2/3. Each rate source is a
`commerce_exchange_rates` **config entity** bound to a **provider plugin** (`manual` or a
remote API). Rates live in DB tables (`commerce_exchanger_latest_rates`,
`commerce_exchanger_historical_rates`), not config. A calculator service converts a
`Price` between currencies. No `configure` route; managed at
`/admin/commerce/config/exchange-rates` (permission `administer commerce exchanger settings`).

- **Create/read an Exchange rates source (config entity), providers, storage** →
  [configure/exchange-rates.md](configure/exchange-rates.md)
- **Convert prices / read & write rates from code (services + DB tables)** →
  [api/services.md](api/services.md)
- **Write a custom exchange-rate provider plugin** →
  [plugins/provider.md](plugins/provider.md)
- **Permission** → `administer commerce exchanger settings` (gates the collection, add/edit/delete, and `/admin/commerce/config/exchange-rates/import`).

Key facts:
- Config entity id/type: `commerce_exchange_rates`; fields `id`, `label`, `plugin`, `configuration`.
- Built-in provider plugin ids: `manual`, `ecb`, `fixer`, `currencylayer`, `open_exchange_rates`, `transferwise`.
- Calculator service `commerce_exchanger.calculate` → `priceConversion(Price $price, string $target_currency)`; it uses the **first enabled** provider (`DefaultExchangerCalculator::getExchangerId()`).
- Rates store/read service `commerce_exchanger.manager` → `setLatest()` / `getLatest()` / `setHistorical()` / `getHistorical()`.
