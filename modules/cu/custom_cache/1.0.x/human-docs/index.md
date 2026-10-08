# Custom cache — manual setup guide

**Custom cache** (`custom_cache`) is a cache backend that puts a ceiling on how
long a "permanent" cache item is allowed to live. In Drupal, `CACHE_PERMANENT`
means "keep this until something invalidates it" — which is correct right up until
an invalidation that was supposed to fire never does. When that happens, a stale
item stays cached forever, and the only cure is a manual cache clear. Custom cache
caps that lifetime so a missed invalidation self-corrects after your chosen
interval instead of never.

It is worth being clear about what this module is: **a safety net, not a fix.** If
you find yourself relying on the cap to hide broken invalidation, the underlying
bug is still there — the cap just makes the wrong data intermittent instead of
permanent, which is harder to diagnose, not easier. The right place to use it is a
site where some data legitimately changes outside Drupal's invalidation reach (a
third‑party integration, an external data source), with the cap set long enough
that it does not mask a genuine problem. The trade‑off is straightforward: a
shorter cap means fresher data but more recomputation, so set it against how long
stale content is acceptable, not against how often you want cache misses.

Custom cache has **no admin UI and no settings form** — you wire it up entirely in
`settings.php`. It depends only on Drupal core and supports Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. All setup happens in
`settings.php`, described in "How to use it" below.

## How to use it

After enabling the module, add its configuration to `settings.php`. First set a
maximum lifetime (in seconds) for permanent items — for example one day:

```php
$settings['custom_cache_melt_time'] = 86400;
```

Then point the cache bins you want capped at the custom backend:

```php
$settings['cache']['bins']['render'] = 'cache.backend.custom_cache';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.custom_cache';
$settings['cache']['bins']['page'] = 'cache.backend.custom_cache';
```

Optionally, exclude cache IDs you always want to keep (they will not be capped):

```php
$settings['custom_cache_exclude_cids'] = [
  '/node/',
  '/taxonomy/term/',
  '/sites/default/files/',
  '/user/',
];
```

Apply the backend only to the bins where capped staleness is acceptable, and
choose `custom_cache_melt_time` deliberately — long enough not to hide a real
invalidation bug, short enough that stale data self‑corrects within a window you
can live with.
