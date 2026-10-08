<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — anonymous_redirect.settings

Single config object, edited at `/admin/config/system/anonymous-redirect` (`AnonymousRedirectSettingsForm`, permission `administer site configuration`). Schema: `config/schema/anonymous_redirect.schema.yml`.

## Config keys (`anonymous_redirect.settings`)

| Key | Type | Default | Form field | Meaning |
|---|---|---|---|---|
| `enable_redirect` | boolean | `false` | "Enable Anonymous Redirect" | Master on/off switch. |
| `redirect_url` | string | `/user/login` | "Redirect Base URL" | Where anonymous users go. Internal: `<front>` or `/path`. External: `http://example.com` (no trailing slash). |
| `redirect_url_overrides` | string | `''` | "Redirect URL Overrides" | Newline-separated internal paths to exempt from the redirect. `*` wildcards supported. |

Note the form field names differ from the config keys: `enable_anonymous_redirect` → `enable_redirect`, `redirect_base_url` → `redirect_url`, `redirect_url_overrides` → `redirect_url_overrides`.

## Set via drush

```bash
drush config:set anonymous_redirect.settings enable_redirect true -y
drush config:set anonymous_redirect.settings redirect_url '/user/login' -y
# Overrides: newline-separated string; wildcards allowed.
drush config:set anonymous_redirect.settings redirect_url_overrides "/user/login
/privacy
/public/*" -y
```

## Runtime behavior (`AnonymousRedirectSubscriber::redirectAnonymous`)

- Runs on kernel `REQUEST`, priority 100. No redirect when: `enable_redirect` is false, the user is authenticated, or `system.maintenance_mode` state is on.
- Skips paths under the `assets://` stream wrapper directory (so asset aggregation/derivatives still generate).
- A leading interface-language prefix (e.g. `/es`) is stripped from the current path before override matching.
- Override match: exact membership in the list **or** `PathMatcher::matchPath()` against the raw override text (enables `*` wildcards). A match means no redirect.
- Target resolution:
  - `UrlHelper::isExternal($redirect_url)` → `TrustedRedirectResponse($redirect_url)` (required for external URLs; adds config as cacheable dependency).
  - `<front>` → `CacheableRedirectResponse` to the front page (unless already there).
  - otherwise → `CacheableRedirectResponse` to `internal:<redirect_url>`. If `redirect_url` is exactly the `user.login` route and the current path isn't `/`, the requested path is added as `?destination=` so the user returns after login.

## Cache

`AnonymousRedirectCacheTag::onSave()` invalidates the `rendered` cache tag whenever `anonymous_redirect.settings` is saved, so previously cached pages pick up the new redirect state. Each redirect response also depends on the config object for cacheability.

## Overriding per environment

Because it is a plain config object, the redirect can be toggled or retargeted per environment from `settings.php`:

```php
$config['anonymous_redirect.settings']['enable_redirect'] = TRUE;
$config['anonymous_redirect.settings']['redirect_url'] = 'https://staging-lock.example.com';
```
