Submodule of Commerce Currency Resolver that lets shoppers choose their currency, storing the choice in a cookie, and ships a front-end currency-switcher block.

---

The submodule registers a `commerce_price.currency_resolver` service (`CurrencyResolverCookie`, priority 1000 — the highest of the shipped resolvers) that reads the currency code from a cookie (or a reverse-proxy header `X_{COOKIE}`, e.g. `X_COMMERCE_CURRENCY`) and returns the matching currency entity. The cookie name comes from `CurrencyResolverManager::getCookieName()` — `$settings['commerce_currency_cookie']` if set, otherwise the default `commerce_currency`. It also provides a **block plugin** `commerce_currency_resolver_cookie` ("Currency cookie block selector", category *Commerce*) that renders a select form (`CurrencyResolverCookieSelectForm`) listing active currencies; choosing one submits and sets the cookie for one day via `setrawcookie(...)`. A `hook_entity_view_alter` adds the `currency_resolver` cache context to product / product-variation renders so cached prices vary per chosen currency. Because it is top priority, an explicit cookie choice overrides geolocation and language resolvers. No config form and no config schema — behaviour is driven entirely by the cookie/header and block placement.

---

- Add a front-end currency switcher so visitors pick their currency.
- Place the "Currency cookie block selector" block in a header/sidebar region.
- Persist a shopper's chosen currency in a cookie for a day.
- Let an explicit currency choice override geo/language resolution (priority 1000).
- Drive currency from a reverse-proxy header (`X_COMMERCE_CURRENCY`) for CDN/edge setups.
- Rename the cookie via `$settings['commerce_currency_cookie']` in settings.php.
- Give anonymous shoppers a way to switch currency without an account.
- Read back where the switcher block is placed and its region (introspection).
- Confirm the block plugin id `commerce_currency_resolver_cookie` is available.
- Combine with exchanger auto mode so the chosen currency shows converted prices.
- Add per-currency cache correctness to product pages via the currency_resolver context.
- Build a multi-currency storefront with manual currency selection.
- Place the switcher only on commerce pages via block visibility conditions.
- Style the currency select form in a custom theme.
- Reset a shopper to the store default by clearing the cookie.
- Support multiple stores/currencies with a single shared switcher.
- Debug currency resolution by inspecting the cookie value.
- Let editors position the switcher through the Block layout UI.
