# Configure cache_tags_simplify

No admin UI and no exported config UI. The single setting lives in
`cache_tags_simplify.settings` and ships as `max_cache_tags_count: false` (`config/install`).
There is no config schema; override it from `settings.php`:

```php
// settings.php — cap every response at N cache tags (see README for how to size N).
$config['cache_tags_simplify.settings']['max_cache_tags_count'] = 1638;
```

`false` (the default) means "never do the lossy replacement pass" — only lossless
simplification runs.

## What the subscriber does (`CacheTagsSimplifySubscriber::onRespond`)

Runs on every `CacheableResponseInterface` response, at `KernelEvents::RESPONSE` priority `1`
(before Purge). Two passes over the response's cache tags, using the *dictionary*
(list-tag → regex; see [../hooks/dictionary.md](../hooks/dictionary.md)):

1. **Simplification (always, lossless).** For each list tag `L` present on the response,
   remove every concrete tag matching `L`'s regex. Rationale: `node_list` already invalidates
   whenever any node changes, so the individual `node:N` tags are redundant. Never broadens
   invalidation, so it is applied unconditionally.

2. **Replacement (only if over the limit, lossy).** If `max_cache_tags_count` is set and the
   tag count *still* exceeds it: rank list tags by how many concrete tags each would remove
   (`arsort`), then repeatedly add the top list tag and drop its concrete matches until the
   count fits. Only candidates that remove >1 tag are used. This *adds* a list tag that was
   not otherwise present, so the response now invalidates on unrelated events too — coarser
   invalidation, potentially lower hit ratio. That is why it is gated behind the limit.

3. **Last resort.** If the count is still over the limit after replacement, the response is
   made uncacheable: `setCacheTags([])` and `setCacheMaxAge(0)`.

The rewritten tag set is written back with `setCacheTags($cache_tags)`.

## Notes

- No dependency on Purge, but explicitly ordered to run before it.
- Simplification is safe to leave on for all sites; only enable the limit (replacement) when a
  real header-size ceiling forces it.
