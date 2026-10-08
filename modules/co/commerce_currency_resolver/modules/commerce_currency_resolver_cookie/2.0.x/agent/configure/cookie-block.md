# Configure — currency switcher block & cookie

## Currency switcher block

- **Plugin id:** `commerce_currency_resolver_cookie`
- **Admin label:** *Currency cookie block selector* (category *Commerce*)
- **Class:** `Plugin\Block\CurrencyResolverCookieSelectBlock` → builds
  `CurrencyResolverCookieSelectForm`.

Place it via **Block layout** (`/admin/structure/block`) or as a config entity:

```php
$block = \Drupal\block\Entity\Block::create([
  'id' => 'currency_switcher',
  'plugin' => 'commerce_currency_resolver_cookie',
  'region' => 'sidebar_first',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => ['label' => 'Currency', 'label_display' => '0'],
  'visibility' => [],
]);
$block->save();
```

The form is a `select` of active currencies (default = current store's default currency) that
auto-submits (`onChange`); submit calls
`setrawcookie(cookieName, code, now + 86400, '/')` and adds the `currency_resolver` cache context.

## Cookie / header

- Cookie name: `CurrencyResolverManager::getCookieName()` →
  `Settings::get('commerce_currency_cookie')` ?? **`commerce_currency`**.
  Change it in `settings.php`:
  ```php
  $settings['commerce_currency_cookie'] = 'my_currency';
  ```
- The resolver also accepts a reverse-proxy header `X_{UPPER_COOKIE_NAME}` (e.g.
  `X_COMMERCE_CURRENCY`) checked *before* the cookie — useful behind a CDN/edge that maps a
  cookie to a header.

## Resolution

`CurrencyResolverCookie::resolve()` (priority 1000): header `X_{COOKIE}` → else cookie →
`manager->getCurrencyByCode($code)`; NULL if neither present (chain falls through to geoip /
language / store default).
