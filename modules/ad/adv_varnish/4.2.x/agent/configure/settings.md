<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Advanced Varnish cache

All settings live in **`adv_varnish.cache_settings`** (plus two state flags, see "Redirect" below).
Settings form: route `adv_varnish.config_form` → `/admin/config/development/adv_varnish`
(permission `administer advanced varnish configuration`).

## Config structure

```yaml
adv_varnish.cache_settings:
  general:
    varnish_server: ''                 # one or MORE space-separated hosts (e.g. "127.0.0.1 127.0.0.2");
                                       #   each host is prefixed with http:// if it lacks a scheme
    secret: ''                         # shared secret; sent as X-Varnish-Purge / X-Varnish-Secret
    noise: ''                          # per-site private key that varies the cache (hashing noise)
    page_cache_maximum_age: ''         # page TTL sent to Varnish
    grace: ''                          # grace (stale-while-revalidate) period
    debug: ''                          # debug mode (adds X-Cache-Debug header)
    logging: ''                        # logging toggle (watchdog)
    varnish_purger: false              # enable the built-in purger (BAN on tag invalidation)
    purger_maintenance_mode: false     # skip purges while the site is in maintenance mode
  available:
    enable_cache: false                # master switch: emit Varnish caching headers
    authenticated_users: false         # also cache for logged-in users
    esi: false                         # enable ESI support
    esi_purge_user_blocks: false       # purge "user:id" tag on POST to refresh ESI user blocks
    url_filter_mode: 'blacklist'       # 'blacklist' (default) or 'whitelist'
    url_filter_rules: ''               # newline "host|path" rules (see format below)
    excluded_urls: ''                  # deprecated, falls back to url_filter_rules
  cache_control:
    anonymous: '/user/logout|must-revalidate, no-cache, private'   # shipped default
    authenticated: ''                  # Cache-Control header for logged-in users
```

Only `cache_control.anonymous` ships in `config/install`; the rest are populated by the settings
form. `cache_control` values are newline `path|header` entries mapping a path match to the
`Cache-Control` header string emitted for that audience (first match wins).

**URL filter rules format** (`available.url_filter_rules`): one `host|path` rule per line, where
`host` matches `SERVER_NAME` (or `*`) and `path` is a `REQUEST_URI` prefix (or `*`). Example:
`example.com|/admin`. In blacklist mode a matching rule disables caching; in whitelist mode caching
is only enabled when a rule matches. The `adv_varnish_update_10001` update migrated any legacy
`available.excluded_urls` into `url_filter_rules` and set `url_filter_mode` to `blacklist`.

## Redirect flags (stored in STATE, not config)

The form's "Redirect" tab writes two values via the `state` service (they govern the cookie-update
reload in `RequestHandler`):

- `adv_varnish__redirect_forbidden` — default `FALSE`. Prevent redirect after a cookie update.
- `adv_varnish__redirect_forbidden_nocookie` — default `TRUE`. Prevent redirect if the cookie is
  still empty after update (avoids search-engine / cookieless infinite loops).

Read/write with `\Drupal::state()->get('adv_varnish__redirect_forbidden')` etc.

## Drush / scripting

No custom Drush commands. Use core config commands:

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

- **available.enable_cache** — master switch; without it caching headers are not emitted.
- **general.varnish_purger** — must be TRUE for the module to send BAN purge requests **and** for the
  manual "Clear Varnish cache" / "Deflate" routes to be accessible (see `RouteSubscriber`).
- **available.esi / esi_purge_user_blocks** — enable ESI fragment support and purge a user's ESI
  blocks (`user:id` tag) on POST requests.
- **general.purger_maintenance_mode** — when TRUE, purges are suppressed while the site is in
  maintenance mode.
- **url_filter_mode + url_filter_rules** — restrict caching to (whitelist) or exclude (blacklist) the
  listed `host|path` patterns.
- **general.debug / general.logging** — add debug cache headers / write vital actions to the
  `adv_varnish` watchdog channel; use while testing.

## Per-node-type TTL override

`hook_form_node_type_form_alter` adds an "Advanced Varnish cache" group to each node-type form with
`override` (checkbox) and `ttl` (select), stored as `adv_varnish` third-party settings on the node
type. When `override` is set, that TTL replaces `general.page_cache_maximum_age` for nodes of that
bundle. A response's own `no-store` (→ TTL 0) or `s-maxage=N` (→ caps TTL) Cache-Control directives
are also honored.

## Per-block ESI settings

`CacheBlockForm` (an override of core's `BlockForm`) adds an "Advanced Varnish cache" fieldset to
each block instance form: `cache.esi` (checkbox — render this block as an ESI fragment), `cache.ttl`
(select), and `cache.cachemode` (Shared / Per User Roles / Per User ID). Stored in the block plugin
configuration under the `cache` key.

## Manual purge & deflate

When `general.varnish_purger` is enabled, two extra admin forms appear under the settings tabs:

- **Clear Varnish cache** — `/admin/config/development/adv_varnish/clear_cache`
  (`ClearCacheForm`): purge by a cache **tag** or **URL**, or full-flush the site.
- **Deflate Varnish cache** — `/admin/config/development/adv_varnish/deflate` (`DeflateForm`):
  progressively lower TTLs instead of a hard flush; the queue is drained on cron.

(When the purger is disabled both routes are registered with `_access: 'FALSE'`.)

## Permissions

- `administer advanced varnish configuration` (restricted) — settings, purge and deflate forms.
- `bypass advanced varnish cache` — users in a role with this permission are served without Varnish
  caching (useful for editors/admins).

## Requirements check

At runtime the module reports an **error** if the **BigPipe** module is enabled: BigPipe's chunked
streaming and Varnish's full-response buffering for ESI are mutually exclusive. Disable BigPipe for
Advanced Varnish to work correctly (`src/Hook/AdvVarnishRequirements.php`).
