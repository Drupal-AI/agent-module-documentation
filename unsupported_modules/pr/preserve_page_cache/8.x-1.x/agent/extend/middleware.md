<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How preserve_page_cache overrides the page cache

## Service override
`preserve_page_cache/src/NoTagsPageCacheServiceProvider.php` (auto-discovered as `<Module>ServiceProvider`) alters the container:

```php
$container->getDefinition('http_middleware.page_cache')->setClass(NoTagsPageCache::class);
```

So the core `page_cache` middleware is replaced by `NoTagsPageCache extends PageCache`.

## Overridden set()
`NoTagsPageCache::set($request, $response, $expire, $tags)`:
1. If `$response->getMaxAge() > 0`, set `$expire = request_time + max-age` (time-based expiry instead of permanent).
2. Resolve `$request->getPathInfo()` to a system path via `path_alias` AliasManager; if it matches `/node\/(\d+)/`, replace `$tags` with just `["node:<id>"]`.
3. Otherwise all incoming tags are dropped (the default `$tags` handling before the node check leaves them empty for non-node paths).
4. Calls `parent::set()` with the adjusted expiry and (mostly empty) tags.

## Implications
- Anonymous page cache entries are invalidated by expiry (max-age), not by tag flushes.
- Editing a node still clears that node's page (retained `node:<id>` tag).
- To tune longevity, control each response's `Cache-Control: max-age` / page cache max-age.

## Extending
To keep additional tags (e.g. `taxonomy_term:<id>`), subclass `NoTagsPageCache` and re-point the service in your own service provider, preserving the tags you need before calling `parent::set()`.
