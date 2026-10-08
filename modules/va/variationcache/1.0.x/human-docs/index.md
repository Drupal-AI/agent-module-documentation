# VariationCache — manual setup guide

**VariationCache** (`variationcache`) is a developer-facing caching layer. It wraps
any ordinary Drupal cache backend and adds *cache-context* awareness, so a single
logical cache item can hold many variations — one per context permutation (per user,
per permission set, per language, per URL query argument, and so on). Your code
stores and reads a value while VariationCache keeps the right variation for the
current request, without you ever hand-building context-specific cache IDs. This is
the very same mechanism Drupal core uses internally for render caching and the
dynamic page cache.

There is **no user interface** here: no settings form, no permissions, no routes, no
Drush commands. The module exists purely as an API that other code depends on. You
interact with it in PHP through the `variation_cache_factory` service.

> **Important — this module is deprecated.** Its code was merged into Drupal core in
> **10.2**. On core 10.2 and newer, the module does nothing but register class
> aliases so that old code referencing `\Drupal\variationcache\Cache\*` keeps
> resolving to the native core classes. Its real purpose today is as a compatibility
> shim / transitional dependency for modules that must support both pre-10.2 and
> 10.2+ core from one namespace. If your site is on Drupal 10.2 or higher and no
> code references the `variationcache` namespace, you can uninstall this module and
> point at the core classes (`\Drupal\Core\Cache\VariationCache`) directly.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent — including the full `variation_cache_factory` API and how to
decorate it — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (typically it arrives as a dependency of another module).

## Where it lives in the admin menu

Nowhere. VariationCache adds nothing to the admin menu — no configuration page, no
permissions, no reports. It is a code-level dependency only.

## How to use it

You use VariationCache from custom PHP, not from the UI. In short: get a
context-aware cache bin from the factory, then read and write through it with
cacheability metadata describing which contexts the data varies by.

```php
use Drupal\Core\Cache\CacheableMetadata;

$cache = \Drupal::service('variation_cache_factory')->get('default');
$keys  = ['my_module', 'expensive_thing'];

$initial = new CacheableMetadata();
$initial->addCacheContexts(['user.permissions']);

if ($hit = $cache->get($keys, $initial)) {
  $data = $hit->data;
}
else {
  $data = build_expensive_thing();
  $cacheability = new CacheableMetadata();
  $cacheability->addCacheContexts(['user.permissions', 'languages:language_interface']);
  $cacheability->addCacheTags(['node_list']);
  $cache->set($keys, $data, $cacheability, $initial);
}
```

In real services, prefer injecting `@variation_cache_factory` rather than the static
`\Drupal::service()` call above. See the [`agent/`](../agent/start.md) docs for the
complete method reference (`get`, `set`, `delete`, `invalidate`) and the class-alias
compatibility details.
