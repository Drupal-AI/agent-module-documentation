# Configuration

## Open the settings form

1. Log in as a user with the **Administer advanced varnish configuration** permission.
2. Go to **Configuration → Development → Advanced Varnish**, or navigate directly to
   `/admin/config/development/adv_varnish`.

Almost everything is stored in one config object, `adv_varnish.cache_settings`,
organized into the sections below.

## General settings

These cover the connection to Varnish and the overall caching behavior:

- **Varnish server(s)** (`varnish_server`) — one or more host names. Enter **multiple
  hosts separated by spaces** to fan purges out to several Varnish servers; each is
  BANned in turn, and a host without a scheme gets an `http://` prefix added
  automatically.
- **Secret** — the shared secret used to authenticate purge/BAN requests. Keep this
  out of committed config (see the secret note in
  [Installation](../installation/index.md)).
- **Page cache maximum age (TTL)** — how long Varnish should cache a page.
- **Grace** — a grace period enabling stale-while-revalidate behavior, so Varnish can
  serve slightly stale content while fetching a fresh copy.
- **Noise** — a per-site key mixed into cache keys, useful for segmenting cached
  content.
- **Debug / logging** — turn these on while testing to trace cacheability decisions
  and purge requests. Debug mode adds extra cache headers to responses; leave it off in
  production.
- **Purger** (`varnish_purger`) — the master toggle for whether Drupal issues BAN
  requests to Varnish at all. The manual purge and deflate tools only appear when this
  is enabled.
- **Purger maintenance mode** — when set, purges are skipped during maintenance mode to
  avoid a thundering-herd of cache misses.

## Availability settings

These control who and what gets cached:

- **Enable caching** — the master switch for Varnish caching.
- **Cache for authenticated users** — extend caching to logged-in users. Note this is
  **per-role**: users who share the same set of roles share a cached page, so anything
  truly personal must be delivered through ESI user blocks rather than rendered directly
  into the page.
- **ESI support** — enable Edge Side Includes so per-user fragments can be rendered
  separately while the surrounding page is cached.
- **ESI user-block purging** — refresh a user's ESI user blocks on POST so their
  personalized content updates.
- **URL filter mode / rules** — include or exclude specific URLs from caching using
  `host|path` blacklist/whitelist rules.

## Cache-control settings

The **Cache-Control** header strings sent to **anonymous** versus **authenticated**
users, so you can tune caching behavior differently for each audience.

## Redirect tab

A separate **Redirect** tab controls the cookie-update reload behavior. Its two flags
are stored in Drupal **state** (not exported config):
`adv_varnish__redirect_forbidden` (default off) and
`adv_varnish__redirect_forbidden_nocookie` (default on).

## Per-node-type TTL overrides

Each content type's edit form (**Structure → Content types → *(type)* → Edit**) gains
an Advanced Varnish section where you can **override the page TTL** for that bundle. The
module also honors a response's own `no-store` / `s-maxage` Cache-Control directives
when computing the effective TTL.

## Per-block ESI settings

Each block's configuration form gains an **Advanced Varnish cache** section where you
can mark the block as an **ESI block**, set its TTL, and choose its cache granularity
(**Shared**, **Per User Roles**, or **Per User ID**). Match the granularity to the
block's audience so the fragment is cached at the right level.

## Purge and deflate tools

When the purger is enabled, two extra forms appear under the settings path:

- **Clear Varnish cache** — purge by cache tag or by URL on demand, or fully flush the
  site (for example during a deployment).
- **Deflate** — instead of a hard flush, progressively lower TTLs over successive cron
  runs, so the cache empties gradually and server load stays manageable.

Purge requests use short Guzzle timeouts (5s request / 2s connect) so a slow or down
Varnish never hangs Drupal.

## ESI user blocks (for developers)

The module defines a `user_blocks` **plugin type** for delivering per-user content
through ESI: a plugin supplies the dynamic content (for example a user's name or cart
count) that is rendered via an ESI route, so the surrounding page can still be cached
anonymously. A second ESI route can render a placed block entity by ID. Implementing a
user block is a coding task — see the sibling [agent docs](../agent/start.md) for the
plugin details.

## Permissions

Two permissions govern the module, assigned at **People → Permissions**:

- **Administer advanced varnish configuration** — access to the settings and purge
  forms.
- **Bypass advanced varnish cache** — lets trusted roles skip Varnish entirely, which
  is handy for debugging with a fresh, uncached response.
