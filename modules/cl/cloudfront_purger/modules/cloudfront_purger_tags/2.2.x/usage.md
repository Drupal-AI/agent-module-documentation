<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CloudFront Purger Tags is an (experimental) submodule of CloudFront Purge that adds cache-tag invalidation: it emits a `Cache-Tags` response header of hashed Drupal cache tags and provides a tag-aware CloudFront purger that invalidates by those hashed tags.

---

The submodule extends the base CloudFront purger to support Drupal cache-**tag** invalidation, which CloudFront can do via tag-based invalidation (the distribution must have `CacheTagConfig` enabled with a matching header name). It provides a second purger plugin, `cloudfront_tags`, that adds `tag` to the supported invalidation types and, for each tag invalidation, sends a path of the form `#<hash>` to CloudFront. It also provides a Purge **TagsHeader** plugin that sets a `Cache-Tags` header on responses containing the response's Drupal cache tags after three steps: **filter** (drop tags matching the `purge_queuer_coretags` blocklist), **prioritize** (entity tags like `node:123` first, then `_list` tags, then everything else — so the most valuable tags survive CloudFront's 50-tag cap), and **hash** (xxHash3, truncated to 6 hex chars). The header name is configurable (`cloudfront_purger_tags.settings:cache_tag_header_name`, default `Cache-Tags`) and must match the distribution's `CacheTagConfig` `HeaderName`. The filter, prioritizer, and hasher are swappable services (each behind an interface) so sites can customize tag processing. Because it depends on `purge_queuer_coretags`, queued core cache tags flow into the purger. It requires the parent module and Drupal core ≥10.6/11.2, and is marked experimental.

---

- Invalidate CloudFront cached objects by Drupal cache tag (e.g. clear all pages tagged `node:123`).
- Automatically purge the CDN for a specific node/entity when it is updated, by its cache tag.
- Emit a `Cache-Tags` response header of hashed tags for CloudFront tag tracking.
- Keep CDN tag headers small by hashing long Drupal tags (e.g. `config:views.view.x`) to 6 chars.
- Prioritize entity tags so precise invalidations survive CloudFront's 50-tag-per-object limit.
- Exclude noisy tags from the header using the Purge core-tags blocklist (e.g. `config:`, `theme_registry`).
- Match the header name to a distribution's `CacheTagConfig` `HeaderName` setting.
- Rename the tag header (e.g. to `X-Cache-Tags`) to fit an existing CloudFront configuration.
- Use a tag-aware purger (`cloudfront_tags`) instead of, or alongside, path invalidation.
- Send tag invalidations to CloudFront as `#<hash>` paths.
- Swap in a custom cache-tag **filter** to change which tags are dropped.
- Swap in a custom **prioritizer** to change which tags are kept when over the limit.
- Swap in a custom **hasher** if you need a different tag-hashing scheme.
- Reduce the number of path invalidations by invalidating by tag instead.
- Combine tag invalidation with the parent module's path/everything invalidation.
- Ensure updated content is evicted from CloudFront without purging entire path trees.
- Feed queued core cache tags (via `purge_queuer_coretags`) into CDN tag invalidation.
- Run it in a staging environment with the parent purger disabled (black-hole) to test tag flow.
- Debug which hashed tag corresponds to an entity by hashing `node:<id>` with xxHash3.
- Stay within CloudFront's header-size limits by filtering + prioritizing before hashing.
