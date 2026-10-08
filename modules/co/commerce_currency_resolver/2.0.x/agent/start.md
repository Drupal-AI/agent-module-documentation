# Commerce Currency Resolver — agent index

Enhances **Commerce 3** multi-currency: resolves the visitor's currency and returns/converts
per-currency prices. Depends on `commerce_price` + `commerce_order` (composer also pulls
`commerce_exchanger`). Config UI at `/admin/commerce/config/commerce_currency_resolver/settings`
(route `commerce_currency_resolver.configuration`, permission `administer commerce currency
resolver settings`). Config object: `commerce_currency_resolver.settings`. Needs Dynamic Page
Cache; core Page Cache must be **off**.

- **Settings keys (`currency_source`, `currency_field_prefix`, `currency_exchange_rates`), the
  config form, and how field/auto/combo modes behave** → [configure/settings.md](configure/settings.md)
- **Services & runtime architecture — the price resolver, order processor, order-load
  subscriber, `CurrencyResolverManager`, the `currency_resolver` cache context, order-data
  flags, and how to resolve a price programmatically** → [api/services.md](api/services.md)
- **The single permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Price resolver `commerce_currency_resolver.price_resolver` (tag `commerce_price.price_resolver`,
  priority 1000) returns `{prefix}{code}` field (e.g. `field_price_eur`) when resolved currency
  differs from the base price currency and `currency_source` is `field` or `combo`.
- `currency_source`: `field` (per-currency fields), `auto` (exchanger conversion), `combo`
  (field first, else auto). `auto`/`combo` + the `currency_exchange_rates` provider selector are
  only exposed when the **exchanger** submodule is enabled (it form-alters the settings form).
- Current-currency selection is Commerce's chain currency resolver; the 6 submodules add
  tagged `commerce_price.currency_resolver` services (cookie 1000, geoip/smart_ip 900,
  language 800) or wire conversion into exchanger/shipping.
- Only **draft, unlocked** orders **owned by the current user** with a currency mismatch are
  refreshed (`CurrencyResolverManager::shouldCurrencyRefresh()`).
- Submodules nest under this project: `commerce_currency_resolver_{cookie,exchanger,geoip,
  language,shipping,smart_ip}`.
