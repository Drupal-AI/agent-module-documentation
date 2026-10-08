# Commerce Currency Resolver Cookie — agent index

Submodule of **commerce_currency_resolver**. Lets shoppers pick a currency; stores it in a
cookie; ships a switcher block. Highest-priority shipped resolver, so a chosen currency wins.

- **The resolver, the switcher block & form, the cookie/header, and how to place the block** →
  [configure/cookie-block.md](configure/cookie-block.md)

Key facts:
- Resolver service `commerce_currency_resolver_cookie.currency` (`Resolver\CurrencyResolverCookie`),
  tagged `commerce_price.currency_resolver` **priority 1000** (top). Reads cookie **or** reverse-proxy
  header `X_{COOKIE_UPPER}` (e.g. `X_COMMERCE_CURRENCY`).
- Cookie name = `CurrencyResolverManager::getCookieName()` = `Settings::get('commerce_currency_cookie')`
  ?? `commerce_currency`. Set `$settings['commerce_currency_cookie']` in settings.php to change it.
- Block plugin id **`commerce_currency_resolver_cookie`** ("Currency cookie block selector",
  category *Commerce*) → renders `CurrencyResolverCookieSelectForm`; on submit sets the cookie for
  1 day (`setrawcookie`, 86400s, path `/`).
- `hook_entity_view_alter` adds the `currency_resolver` cache context to product / variation renders.
- No config form, **no config schema**, no own permission (block placement via Block layout).
