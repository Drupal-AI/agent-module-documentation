# How invalidation works (services)

The module is automatic — there is nothing to call. Three pieces do the work:

## 1. `Surrogate-Key` response header
`CacheableResponseSubscriber` (`event_subscriber`, on `KernelEvents::RESPONSE`) runs for the
main request only. For any `CacheableResponseInterface` it joins the response's cache tags with
spaces and sets them as the `Surrogate-Key` header. If the string exceeds
`surrogate_key_header_limit` it is truncated at the last whole tag (to avoid a 502) and a
WARNING is logged. When `override_list_tags` is on, `_list` tags are rewritten to `_emit_list`.

## 2. Edge purge on tag invalidation
`CacheTagsInvalidator` (tagged `cache_tags_invalidator`) implements
`CacheTagsInvalidatorInterface::invalidateTags()`. When Drupal invalidates any cache tags it
calls Pantheon's `pantheon_clear_edge_keys($tags)` (only if that function exists, i.e. on
Pantheon). Requests under `/core/install.php` are skipped.

## 3. File / image path clearing
`pantheon_advanced_page_cache_file_update()` (`hook_ENTITY_TYPE_update` for `file`) calls
`pantheon_clear_edge_paths()` for the file's URL plus every `ImageStyle` derivative URL, so a
replaced image serves fresh immediately. No-op off Pantheon.

## Logging
Dedicated channel `pantheon_advanced_page_cache` (service
`logger.channel.pantheon_advanced_page_cache`) records trims, file clears, and errors. These
services are internal implementation details — override only via a service decorator if needed.
