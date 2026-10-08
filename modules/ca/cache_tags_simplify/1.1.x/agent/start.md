# Cache tags simplify — agent index

A single response event subscriber that rewrites a response's cache tags to reduce the
`X-Cache-Tags` header size. No admin UI (`configure` null), no permissions, no Drush, no
plugin types, no config schema. The only setting is `max_cache_tags_count` (default `false`),
set from `settings.php`. Extendable through two hooks.

- **The one setting, the two-pass algorithm (lossless simplify + opt-in lossy replace), and the
  built-in dictionary** → [configure/settings.md](configure/settings.md)
- **`hook_cache_tags_simplify_dictionary` / `_alter` to add or remove tag mappings** →
  [hooks/dictionary.md](hooks/dictionary.md)

Key facts:
- Subscriber: `Drupal\cache_tags_simplify\EventSubscriber\CacheTagsSimplifySubscriber`,
  `KernelEvents::RESPONSE` priority `1` (runs before Purge's `CacheableResponseSubscriber`).
- Simplification (drop concrete tags covered by a present list tag) is always applied — harmless.
- Replacement (add a list tag + drop its concrete tags to fit a limit) runs ONLY when
  `max_cache_tags_count` is set and exceeded; it broadens invalidation. Last resort: response
  made uncacheable (`setCacheTags([])`, `setCacheMaxAge(0)`).
