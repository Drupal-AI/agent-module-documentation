<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & runtime

The module has **no settings form and no config object of its own** (`configure: null`,
`provides_config_schema: false`). Enabling it (`drush en fast_error_pages`) is enough; it takes
over 404 and 403 handling for anonymous visitors automatically.

## What it reads

The error page paths come from core's **`system.site`** config:

| Status | Config key           | Built-in plugin      |
|--------|----------------------|----------------------|
| 404    | `page.404`           | `FastErrorPage404`   |
| 403    | `page.403`           | `FastErrorPage403`   |

If a key is empty the matching plugin's `getUrl()` returns `NULL` and the module does nothing for
that status (core handles it). Set them the usual way — *Configuration → System → Basic site
settings* — or:

```bash
drush config:set system.site page.404 /node/123 -y
drush config:set system.site page.403 /node/456 -y
```

```php
\Drupal::configFactory()->getEditable('system.site')
  ->set('page.404', '/node/123')
  ->set('page.403', '/node/456')
  ->save();
```

## Caching requirement

The module only pays off when a **full-page cache layer** (core Internal Page Cache, or a reverse
proxy such as Varnish / Nginx / Cloudflare) is active — the warm-path loopback fetch is answered
by that cache. Without one there is no speed-up. Nothing extra is stored: the module keeps only
each error page's **cache tags + contexts** (not the HTML) in its own cache bin
`fast_error_pages_cache_bin` (service `cache.fast_error_pages`). Clear it with a full
`drush cr`, or:

```php
\Drupal::service('cache.fast_error_pages')->deleteAll();
```

## Runtime flow (for debugging)

1. On an uncaught 404/403 exception, `FastErrorPageHtmlExceptionSubscriber::onException()`
   (`KernelEvents::EXCEPTION`, priority 250) runs — **anonymous only**, and skips any request that
   already carries the `X-Drupal-Fast-Error-Pages` header (its own loopback).
2. It looks up the `FastErrorPage` plugin whose id equals the status code and reads that plugin's
   `getUrl()` (the absolute URL of the configured error page).
3. It builds a cache id from the status code (plus any parts added by the alter hook), reads
   `cache.fast_error_pages`.
4. It fetches the page via a loopback HTTP request (`getPage()`), tagged
   `X-Drupal-Fast-Error-Pages: 1` so it does not recurse. The first (cold) fetch is a **POST**
   (bypasses the page cache, forcing a real render); warm fetches are **GET** (served by the page
   cache).
5. During that loopback render, `FastErrorPageStoreCacheInfo::onResponse()`
   (`KernelEvents::RESPONSE`) sees the request URI match a plugin URL (`$plugin->applies($request)`)
   and stores the response's cache tags + contexts in `cache.fast_error_pages` under the cid.
6. The exception subscriber returns an `HtmlResponse($html, $status_code)` carrying the stored tags
   + contexts, plus the `4xx-response` tag and `url` context, so ordinary Drupal invalidation still
   applies. If the fetch fails or no tags/contexts were captured, it returns nothing and core
   handles the error.
