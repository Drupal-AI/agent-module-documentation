# Configuration

LSCache has a main settings form for what Drupal tells LiteSpeed, plus a separate
purger form (from the `lscache_purger` submodule) for how invalidation happens.

## Prerequisite: the `.htaccess` directives

Before any of these settings do anything, LiteSpeed must be told to consult its
cache via a `CacheLookup public on` directive in `.htaccess` (see
[Installation](../installation/index.md)). The Status report
(`/admin/reports/status`) confirms whether it's in place.

## Open the main settings form

1. Log in as a user with the **Administer LSCache** permission.
2. Go to **Configuration → Development → Performance → LSCache**, or navigate
   directly to `/admin/config/development/performance/lscache`.

### Enabled

Toggles header injection. **Leave it off until LiteSpeed is confirmed working** —
then turn it on to start emitting the `X-LiteSpeed-Tag` and
`X-LiteSpeed-Cache-Control` headers. Turning it off stops contributing tags while
LiteSpeed keeps caching, which is handy during troubleshooting.

### Default TTL

The default cache lifetime, in seconds, emitted as
`X-LiteSpeed-Cache-Control: public,max-age=N`. Set 0 to suppress it. Choose a
value that matches how long your pages can safely be served from cache between
invalidations.

### Tag prefix

A string prepended to every emitted cache tag. Use it to **scope several sites
that share one LiteSpeed cache** so their tags don't collide.

### Private cache

Enables **per‑user caching of authenticated pages**, derived from Drupal cache
contexts (`user`, `user.permissions`, `user.roles`, `session`). It is BigPipe‑ and
drupalSettings‑aware so it won't break AJAX for logged‑in users. This requires the
`private` flag in your directive: `CacheLookup public on private on`.

### Vary cookies

One cookie name per line. Each becomes an `X-LiteSpeed-Vary: cookie=NAME` header
so cached pages vary by that cookie — useful for device class, currency, country,
or an A/B‑test bucket. Each cookie also needs a matching server‑side `CacheVary`
directive.

### Debug

Logs the emitted tag payload for each response on the `lscache` log channel. Turn
it on while setting things up to see exactly which tags a page contributes, then
turn it off.

## Purger submodule settings

After enabling `lscache_purger` (which needs the Purge module), it auto‑wires a
Purge pipeline. Configure it at
**`/admin/config/development/performance/lscache/purger`**:

- **Purge host** — the origin‑direct URL LiteSpeed PURGE requests are sent to,
  such as `http://127.0.0.1`. Use the origin, **not** a CDN URL.
- **Host header override** (`purge_host_header`) — override the Host header on
  PURGE requests so evictions hit the correct canonical‑host cache bucket.
- **Purge strategy** (`purge_strategy`: `tag`, `url`, or `auto`, default
  **auto**) — some LiteSpeed builds silently ignore tag‑based PURGE (the request
  returns HTTP 200 but evicts nothing, so edits never clear). The `url` strategy
  resolves each cache tag to its canonical Drupal paths and sends one PURGE per
  URL; `auto` self‑selects based on a probe. Run **`drush lscache:diag`** to test
  your build's behaviour and get a recommendation.
- **Listing‑page coverage** — a self‑populating tag‑affinity table plus a pinnable
  `static_url_map` resolve aggregate tags (like `node_list` or View configs) to
  the listing pages that carry them. **`drush lscache:list-tag-coverage`** reports
  any gaps.

## ESI fragments (advanced, for developers)

For pages that are mostly shareable but contain a per‑user chunk (a cart count, a
greeting), LSCache provides an `lscache_esi` render element that emits an
`<esi:include>` so LiteSpeed can cache the surrounding page publicly while holding
the fragment per user. This is a code‑level feature — see the sibling
[`agent/api/lscache.md`](../../agent/api/lscache.md) docs for the render‑element
API and its signed‑token trust model.

## Save

Click **Save configuration** on each form. Verify the result with
`curl -I` (looking for `x-litespeed-cache: hit/miss`) and by editing content to
confirm the matching cached pages are purged.
