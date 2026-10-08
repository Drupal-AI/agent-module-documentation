<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CloudFront Purger Tags — agent index

Experimental submodule of **CloudFront Purge** adding cache-**tag** invalidation. Provides a
tag-aware purger `cloudfront_tags` and a Purge TagsHeader plugin that sets a `Cache-Tags` response
header of **hashed** Drupal cache tags. Depends on `cloudfront_purger` + `purge_queuer_coretags`;
core ≥ 10.6 / 11.2. No admin route (`configure: null`).

- **Enable/use it: the `cloudfront_tags` purger, the Cache-Tags header + header-name setting,
  distribution CacheTagConfig, blocklist, limits** → [configure/tags.md](configure/tags.md)
- **Tag processing pipeline (filter→prioritize→hash) and the swappable services** →
  [extend/services.md](extend/services.md)

Key facts:
- Purger plugin id: `cloudfront_tags` (`@PurgePurger`), types `{tag, path, wildcardpath, everything}`;
  extends the base `cloudfront` purger, overriding `processTagInvalidation()` to emit `#<hash>` paths.
- TagsHeader plugin id: `cloudfront` (`@PurgeTagsHeader`, `header_name = "Cache-Tags"`,
  `dependent_purger_plugins = {"cloudfront_tags"}`).
- Config `cloudfront_purger_tags.settings:cache_tag_header_name` (default `Cache-Tags`) — must match
  the distribution's `CacheTagConfig` `HeaderName`.
- Pipeline: **filter** (`purge_queuer_coretags` blocklist) → **prioritize** (entity tags, then `_list`,
  then other) → **hash** (xxHash3, 6 hex chars, `CacheTagsHashInterface::HASH_LENGTH`).
- Swappable services: `CacheTagFilterInterface`, `CacheTagPrioritizerInterface`,
  `CacheTagsHashInterface` (autowired; `_defaults: autowire: true`).
- Shares the parent's `cloudfront_purger.settings` (distribution id, AWS auth, `disabled`).
