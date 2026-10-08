# Pantheon Advanced Page Cache — manual setup guide

**Pantheon Advanced Page Cache** (`pantheon_advanced_page_cache`) connects Drupal's
cache-tag system to Pantheon's Global CDN edge cache, so that when content changes,
exactly the right pages are purged from the edge — and nothing more. It lets a
Pantheon-hosted site keep long edge cache lifetimes (great for performance) without
ever serving stale content after an edit.

The module works automatically the moment you enable it — for the common case there
is nothing to configure. On every cacheable page it adds a `Surrogate-Key` HTTP
header listing that page's cache tags, which lets Pantheon's edge (Varnish)
associate the cached response with those tags. When Drupal later invalidates a tag
(for example when you save a node), the module tells Pantheon to purge precisely
the matching edge-cached pages. It also clears the edge cache for a replaced file
and every one of its image-style derivatives, so swapped images appear immediately.

Because the `Surrogate-Key` header has a byte-length ceiling, the module trims an
over-long tag list automatically (and logs a warning) to avoid errors at the edge.
It has no admin UI, no dependencies beyond a couple of Composer libraries, and is
**incompatible with the `big_pipe` module**. On Pantheon-hosted Drupal it is
effectively required for correct caching. Off Pantheon it does no harm — the
edge-purge calls simply no-op — which makes it safe to keep enabled in local and CI
environments.

This guide is written for a **human**. Because the module has no settings screen,
its behavior and the two available config keys are covered below; the sibling
[`agent/`](../agent/start.md) docs describe the internal services for developers.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no admin page** — nothing appears in the admin menu, and there is
nothing to click. The module hooks into Drupal's response and cache-invalidation
pipeline directly and runs on its own.

## How to use it

For a Pantheon site, the setup is simply: install, enable, and let it run. It
begins emitting `Surrogate-Key` headers and purging edge keys on cache-tag
invalidation right away.

The module exposes two configuration keys in its `pantheon_advanced_page_cache.settings`
config object. Neither has a form — you set them via config import, `drush cset`, or
a `settings.php` override:

- **`surrogate_key_header_limit`** *(default `25000`)* — the maximum byte length of
  the `Surrogate-Key` header. This is only honored on **non-Pantheon** environments;
  it is useful for simulating the edge's header limit locally. Valid range 0–25000.
  Override it in `settings.php` like this:

  ```php
  $config['pantheon_advanced_page_cache.settings']['surrogate_key_header_limit'] = 20000;
  ```

- **`override_list_tags`** *(default `false`)* — legacy 1.x behavior that renames
  `_list` cache tags so they are not cleared by default. This is **not recommended**;
  leave it off on modern sites.

If you ever see the module log a warning that the surrogate-key header was trimmed,
it means a page carries an unusually large number of cache tags — a hint to
simplify that page's cacheability rather than a fault in the module. The module logs
to its own `pantheon_advanced_page_cache` channel, which you can watch at **Reports
→ Recent log messages**.
