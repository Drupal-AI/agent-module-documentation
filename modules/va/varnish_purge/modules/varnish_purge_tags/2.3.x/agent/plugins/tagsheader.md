# TagsHeader plugin — varnish_purge_tags

Provides one instance of Purge's `@PurgeTagsHeader` plugin type.

## `varnish_tagsheader` (`CacheTags`)

```php
/**
 * @PurgeTagsHeader(
 *   id = "varnish_tagsheader",
 *   header_name = "Cache-Tags",
 * )
 */
class CacheTags extends TagsHeaderBase implements TagsHeaderInterface {}
```

- The class body is **empty** — all behaviour comes from `TagsHeaderBase` plus the
  annotation. The `header_name` `Cache-Tags` is the only declaration.
- Purge attaches this header to every cacheable response, filled with that response's Drupal
  cache tags (space/pipe-separated per Purge's formatting).
- No settings, no config schema, no route. Enable the module and the header appears.

## How it fits the pipeline

1. Response is rendered → `varnish_tagsheader` adds `Cache-Tags: node:5 node_list …`.
2. Varnish caches the object with that header.
3. Content is edited → Purge queues a `tag` invalidation.
4. A `varnish`/`varnishbundled` purger (configured for `BAN` + `Cache-Tags:
   [invalidation:expression]`) or the zero-config purger sends a `BAN` naming the tag.
5. Varnish evicts only objects whose stored `Cache-Tags` header matches.

To override the header (e.g. rename it), you'd provide your own `@PurgeTagsHeader` plugin —
this module doesn't expose configuration for it.
