Commerce Currency Resolver enhances Drupal Commerce 3 multi-currency support by resolving which currency the current visitor sees and calculating per-currency prices for products, orders, promotions, fees, taxes and shipping — either from dedicated per-currency price fields or by automatic exchange-rate conversion.

---

Commerce 3 already stores multiple currencies, but it resolves prices only from the current resolved store. This module adds a **price resolver** (tagged `commerce_price.price_resolver`, priority 1000) that returns a product's price from a dedicated per-currency field (`{prefix}{code}`, e.g. `field_price_eur`) when the resolved currency differs from the default, plus an **order processor** and an **order-load event subscriber** that refresh a draft order's total when the shopper's currency changes. A `currency_source` setting picks the strategy: `field` (per-currency price fields only), `auto` (everything converted via Commerce Exchanger), or `combo` (use a field if present, otherwise auto-convert — the default once the exchanger submodule is on). A `currency_resolver` cache context makes render caching currency-aware. The module itself resolves the *current currency* through Commerce's chain currency resolver; six submodules plug into that chain to decide the currency from the shopper's language, GeoIP/Smart IP country, or a cookie, and to wire automatic conversion into exchanger, promotions, fees and shipping. Only draft, unlocked, owned orders belonging to the current user are refreshed. Works only with Dynamic Page Cache (core Page Cache must be off).

---

- Show product prices in the visitor's own currency without duplicating whole product catalogues per store.
- Store a Euro price in `field_price_eur`, a GBP price in `field_price_gbp`, etc., and have the right one resolved automatically.
- Set `currency_source` to `field` so prices come only from dedicated per-currency price fields.
- Set `currency_source` to `auto` to convert every price from the default currency via live exchange rates.
- Set `currency_source` to `combo` to prefer a manual per-currency field and fall back to auto-conversion when the field is empty.
- Change the currency field prefix (default `field_price_`) to match an existing field naming scheme.
- Let a returning shopper keep the currency they selected as they browse (cookie submodule).
- Add a front-end currency switcher block so visitors pick their currency.
- Resolve currency automatically from the interface language (language submodule + a language→currency matrix).
- Resolve currency automatically from the visitor's country via the GeoIP module (geoip submodule).
- Resolve currency automatically from the visitor's country via the Smart IP module (smart_ip submodule).
- Map many countries to one currency, or one currency per country, using the geoip/smart_ip matrix logic switch.
- Auto-convert order adjustments, custom fees and promotions into the resolved currency (exchanger submodule).
- Keep shipping rates correct in the resolved currency, with per-currency flat rates or auto-conversion (shipping submodule).
- Recalculate a cart total the moment a shopper switches currency, on a draft order they own.
- Force a currency refresh on a specific order programmatically via `setData('currency_resolver_force_refresh', TRUE)`.
- Skip currency refresh for a specific order via the `currency_resolver_skip_refresh` order data flag.
- Resolve the correct price when adding order items programmatically, via the `commerce_currency_resolver.price_resolver` service.
- Add a currency-aware cache context (`currency_resolver`) to custom blocks or render arrays.
- Pick which Commerce Exchanger provider supplies the rates through the `currency_exchange_rates` setting.
- Drive currency from a reverse-proxy header (`X_COMMERCE_CURRENCY`) instead of a cookie.
- Rename the currency cookie by setting `$settings['commerce_currency_cookie']` in `settings.php`.
- Build a storefront where promotions defined in one currency still apply after the shopper switches currency.
- Combine several resolvers (cookie beats GeoIP beats language) using the built-in resolver priorities.
- Localise a multilingual Commerce store so each language shows a matching currency.
- Migrate an old multi-currency setup onto Commerce 3 without a separate store per currency.
