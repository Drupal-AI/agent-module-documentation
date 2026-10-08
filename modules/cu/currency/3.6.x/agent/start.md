<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Currency — agent index

Currency metadata (ISO 4217 as `currency` config entities), locale-aware amount formatting,
and a pluggable exchange-rate/conversion system. Configure route: `entity.currency.collection`
(`/admin/config/regional/currency`). Depends on the `plugin` module and the `commercie/currency*`
libraries; needs the `bcmath` PHP extension. Only `XXX` currency and the `en_US` locale ship
enabled — real currencies are **imported**.

- **Currencies & currency locales (config entities, importing, custom currencies)** →
  [configure/currencies.md](configure/currencies.md)
- **Exchange rates & conversion (providers, fixed rates, the service)** →
  [configure/exchange-rates.md](configure/exchange-rates.md)
- **Formatting amounts (formatter plugins, `currency_amount` element, text filters)** →
  [api/formatting.md](api/formatting.md)
- **Services to call programmatically** → [api/services.md](api/services.md)
- **The two plugin types you can extend** → [plugins/plugin-types.md](plugins/plugin-types.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Currency entity: id key = `currencyCode` (3-letter code), config prefix `currency.currency.<CODE>`.
- Fixed rates live in `currency.exchanger.fixed_rates` → `rates: [{currency_code_from, currency_code_to, rate}]`.
- Enabled providers live in `currency.exchange_rate_provider` → `plugins: [{plugin_id, status}]`.
- Import currencies with the `currency.config_importer` service (`importCurrency('USD')`).
- `\Drupal::service('currency.exchange_rate_provider')->load($from, $to)` throws if no provider
  can supply the pair — define a fixed rate first.
