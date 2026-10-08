# Configuration

All of the module's behaviour is driven by one settings form, backed by the
`adv_varnish.cache_settings` config object. This page walks through it section by
section.

## Open the settings form

1. Log in as a user with the **Administer advanced varnish configuration** permission.
2. Go to **Configuration → Development → Advanced Varnish**, or navigate directly to
   `/admin/config/development/adv_varnish`.

## General (server & purger)

Settings for talking to Varnish and controlling purges:

- **Varnish server** — the Varnish host that purge/BAN requests are sent to.
- **Secret** — a shared secret used with Varnish for purge authorisation.
- **Noise** — a per-site private key mixed into the cache key, letting you vary or
  segment cached content.
- **Page cache maximum age** — the page TTL sent to Varnish.
- **Grace** — the grace (stale-while-revalidate) period, so Varnish can serve slightly
  stale content while fresh content is fetched.
- **Debug** / **Logging** — diagnostic options for troubleshooting cacheability.
- **Enable purger** (`varnish_purger`) — must be **on** for the module to send BAN
  purge requests when content changes, **and** for the manual Clear/Deflate forms below
  to be reachable.
- **Purger maintenance mode** — when on, purges are suppressed while the site is in
  maintenance mode (avoids a cache-miss stampede during deploys).

## Availability (what gets cached)

- **Enable cache** — the master switch. Without it, the module does not emit Varnish
  caching headers at all.
- **Authenticated users** — also cache pages for logged-in users (use with ESI for
  personalised regions).
- **ESI** — enable Edge Side Includes support so per-user fragments stay dynamic while
  the page is cached.
- **ESI purge user blocks** — purge a user's ESI blocks (their `user:id` tag) on POST
  requests so their personalised content refreshes.
- **URL filter mode** + **URL filter rules** — restrict caching to a set of URL
  patterns (**whitelist**) or exclude a set of patterns (**blacklist**).

## Cache control headers

Two `Cache-Control` header strings, one for **anonymous** and one for
**authenticated** visitors. They use a `path|header` form that maps a path match to
the header emitted for that audience. Only the anonymous default ships out of the box
(`/user/logout|must-revalidate, no-cache, private`).

## Manual purge & deflate

When **Enable purger** is on, two extra forms appear as tabs on the settings page:

- **Clear Varnish cache** (`/admin/config/development/adv_varnish/clear_cache`) — purge
  by a cache **tag** or a **URL**.
- **Deflate Varnish cache** (`/admin/config/development/adv_varnish/deflate`) —
  progressively lower TTLs instead of a hard flush.

(When the purger is disabled these routes exist but are access-denied.)

## Permissions

At **People → Permissions**:

- **Administer advanced varnish configuration** — reach the settings, purge and deflate
  forms.
- **Bypass advanced varnish cache** — users in a role with this permission are served
  without Varnish caching, which is useful for editors and admins who need to see
  changes immediately.

## Setting it from the command line

```bash
drush cget adv_varnish.cache_settings
drush cset adv_varnish.cache_settings available.enable_cache 1 -y
drush cset adv_varnish.cache_settings general.varnish_server 'http://varnish:6081' -y
drush cset adv_varnish.cache_settings general.varnish_purger 1 -y
```
