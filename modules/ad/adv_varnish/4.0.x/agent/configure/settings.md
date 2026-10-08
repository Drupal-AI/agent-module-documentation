<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Advanced Varnish cache

All settings live in **`adv_varnish.cache_settings`**. Settings form: route `adv_varnish.config_form`
→ `/admin/config/development/adv_varnish` (permission `administer advanced varnish configuration`).

## Config structure

```yaml
adv_varnish.cache_settings:
  general:
    varnish_server: ''                 # Varnish host purge/BAN requests are sent to
    secret: ''                         # shared secret used with Varnish
    noise: ''                          # per-site private key that varies the cache
    page_cache_maximum_age: ''         # page TTL sent to Varnish
    grace: ''                          # grace (stale-while-revalidate) period
    debug: ''                          # debug mode
    logging: ''                        # logging toggle
    varnish_purger: false              # enable the built-in purger (BAN on tag invalidation)
    purger_maintenance_mode: false     # skip purges while the site is in maintenance mode
  available:
    enable_cache: false                # master switch: emit Varnish caching headers
    authenticated_users: false         # also cache for logged-in users
    esi: false                         # enable ESI support
    esi_purge_user_blocks: false       # purge "user:id" tag on POST to refresh ESI user blocks
    url_filter_mode: ''                # 'blacklist' or 'whitelist'
    url_filter_rules: ''               # newline URL patterns for the filter
    excluded_urls: ''                  # deprecated, use url_filter_rules
  cache_control:
    anonymous: '/user/logout|must-revalidate, no-cache, private'   # shipped default
    authenticated: ''                  # Cache-Control header for logged-in users
```

Only `cache_control.anonymous` ships in `config/install`; the rest are populated by the settings
form. The `cache_control` values are `path|header` style entries mapping a path match to the
`Cache-Control` header string emitted for that audience.

## Drush / scripting

```bash
drush cget adv_varnish.cache_settings
drush cset adv_varnish.cache_settings available.enable_cache 1 -y
drush cset adv_varnish.cache_settings general.varnish_server 'http://varnish:6081' -y
drush cset adv_varnish.cache_settings general.varnish_purger 1 -y
```

```php
\Drupal::configFactory()->getEditable('adv_varnish.cache_settings')
  ->set('available.enable_cache', TRUE)
  ->set('available.esi', TRUE)
  ->set('general.varnish_purger', TRUE)
  ->save();
```

## What the toggles do

- **available.enable_cache** — master switch; without it the response subscriber does not emit
  Varnish caching headers.
- **general.varnish_purger** — must be TRUE for the module to send BAN purge requests **and** for the
  manual "Clear Varnish cache" / "Deflate" routes to be accessible (see `RouteSubscriber`).
- **available.esi / esi_purge_user_blocks** — enable ESI fragment support and purge a user's ESI
  blocks (`user:id` tag) on POST requests.
- **general.purger_maintenance_mode** — when TRUE, purges are suppressed while the site is in
  maintenance mode.
- **url_filter_mode + url_filter_rules** — restrict caching to (whitelist) or exclude (blacklist) the
  listed URL patterns.

## Manual purge & deflate

When `general.varnish_purger` is enabled, two extra admin forms appear under the settings tabs:

- **Clear Varnish cache** — `/admin/config/development/adv_varnish/clear_cache`
  (`ClearCacheForm`): purge by a cache **tag** or **URL**.
- **Deflate Varnish cache** — `/admin/config/development/adv_varnish/deflate` (`DeflateForm`):
  progressively lower TTLs instead of a hard flush.

(When the purger is disabled both routes exist but are access-denied.)

## Permissions

- `administer advanced varnish configuration` — settings, purge and deflate forms.
- `bypass advanced varnish cache` — users in a role with this permission are served without Varnish
  caching (useful for editors/admins).
