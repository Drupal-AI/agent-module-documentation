Cache tags simplify shrinks the cache-tags a response advertises (the `X-Cache-Tags`/`X-Drupal-Cache-Tags` header Purge and reverse proxies read) by dropping concrete entity tags that are already covered by a corresponding list tag, and — only when a configured limit is exceeded — by collapsing large tag groups into a single list tag.

---

The module registers one response event subscriber (`CacheTagsSimplifySubscriber`, priority `1` on `KernelEvents::RESPONSE`, deliberately before Purge's own subscriber) that rewrites the cacheable metadata of every `CacheableResponseInterface` response. It works from a *dictionary* mapping a list cache tag to a regex that matches the concrete tags it subsumes (e.g. `node_list => /^node\:/`). The built-in dictionary (via `hook_cache_tags_simplify_dictionary`) covers `block`, `menu_link_content`, `media`, `node`, `file`, `taxonomy_term`, `user`, `profile`, and `group`. Two passes run: (1) **simplification** — for every list tag present on the response, its concrete matching tags are removed because the list tag already invalidates on the same events; this is lossless and always applied. (2) **replacement** — only when `max_cache_tags_count` is set and the tag count still exceeds it, the subscriber adds the highest-yield list tag(s) and removes their concrete tags until the count fits; this is lossy (it broadens invalidation and can lower cache-hit ratio) so it is opt-in. If even after replacement the count still exceeds the limit, the response is made uncacheable (empty tags, `max-age 0`). There is no admin UI, no permissions, and no config schema; the only setting is `max_cache_tags_count`, set from `settings.php`. Custom code extends behavior via `hook_cache_tags_simplify_dictionary` / `_alter`.

---

- Keep the `X-Cache-Tags` response header under a reverse proxy's header-size limit (Varnish `http_resp_hdr_len`, Apache `LimitRequestFieldSize`).
- Drop thousands of redundant `node:N` tags from a listing page when `node_list` is already present.
- Reduce cache-tag noise on Views-heavy pages that emit both list and per-row entity tags.
- Cap total cache tags per response to a fixed number (e.g. 1638) via `max_cache_tags_count`.
- Prevent Purge from choking on oversized tag sets before it processes the response.
- Collapse many `media:N` tags into a single `media_list` tag under load.
- Collapse `taxonomy_term:N`, `user:N`, `file:N`, `group:N`, `profile:N` tags into their list tags.
- Shrink cache-tag headers for CDN edge caches that enforce header limits.
- Lower the number of tags a purge backend must track and invalidate.
- Add a project-specific list tag → regex mapping via `hook_cache_tags_simplify_dictionary`.
- Prevent a specific list tag's concrete tags from being collapsed via `hook_cache_tags_simplify_dictionary_alter` (e.g. keep `user:N` granular).
- Trade slightly coarser invalidation for staying within header limits on the busiest pages only.
- Guarantee no page ever ships more than the configured tag count (falling back to uncacheable as a last resort).
- Apply lossless simplification site-wide without any configuration at all (just enable the module).
- Diagnose header-size 502/400 errors caused by huge cache-tag headers behind Varnish.
- Keep block-related `config:block.*` tags collapsed into `config:block_list`.
- Run before Purge so purge sees the already-simplified tag set.
- Prioritise collapsing the largest tag groups first (the subscriber sorts candidates by match count).
- Avoid over-invalidation by only replacing when actually over the limit, never preemptively.
- Ship a self-hosted alternative to raising proxy header limits on the infrastructure side.
