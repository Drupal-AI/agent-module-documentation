<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & API

Call these from custom code to trigger Cloudflare purges programmatically.

## `cloudflare_purge.purge` → `Purge` (main entry point)

Handles credential resolution, Zone-ID validation, rate limiting, batching (100/request), user
messaging, and gated logging. Prefer this over the low-level API service.

```php
/** @var \Drupal\cloudflare_purge\PurgeInterface $purge */
$purge = \Drupal::service('cloudflare_purge.purge');

$purge->purgeEverything(showMessage: TRUE);          // whole zone
$purge->purgeByUrls(['https://example.com/node/1']); // files
$purge->purgeByTags(['node:123', 'taxonomy_term:9']);// tags (formatted for wire first)
$purge->purgeByPrefixes(['https://example.com/blog/']);
$purge->purgeByHostnames(['cdn.example.com']);
$purge->hasCredentials();                             // bool
```

Every method returns a `CloudflarePurgeResult` (`isSuccess()`, `getStatusCode()`, `getMessage()`,
`getData()`, `getPurgedCount()`, `isRateLimited()`, `isAuthenticationError()`). Each method accepts a
`bool $showMessage = TRUE` to suppress the messenger output for headless/queue use. Type constants:
`Purge::TYPE_EVERYTHING|TYPE_URLS|TYPE_TAGS|TYPE_PREFIXES|TYPE_HOSTNAMES`.

## `cloudflare_purge.api` → `CloudflarePurgeApi` (low-level)

Thin Guzzle wrapper around `https://api.cloudflare.com/client/v4/zones/{zone}/purge_cache` (base URL is
a hardcoded constant — not configurable). Methods take the resolved credentials
explicitly: `purgeEverything`, `purgeByUrls`, `purgeByTags`, `purgeByPrefixes`, `purgeByHostnames`.
Enforces `MAX_BATCH_SIZE = 100` (drops + logs overflow), `ZONE_ID_PATTERN = /^[a-f0-9]{32}$/i`, 30s
timeout. You normally do not call this directly — go through `Purge`.

## `cloudflare_purge.credential_resolver` → `CredentialResolver`

Single source of truth for credentials. Key methods: `getCredentials()` (returns
`use_bearer`, `zone_id`, `bearer_token`, `email`, `authorization`), `getCredential($name)`,
`getAuthMethod()`, `hasCredentials()`, `hasSettingsOverride()`, `hasIncompleteSettingsOverride()`,
`detectAuthMethod()`, `detectStorageMethod()`. Resolution order: settings.php → Key module → plain
config. The `key.repository` dependency is optional (`@?key.repository`).

## `cloudflare_purge.cache_tag_formatter` → `CacheTagFormatter`

`formatForWire(array $tags)` applies prefix + optional hashing + size guard so the `Cache-Tag` header
and the tag-purge call use identical tokens. Used by both `Purge::purgeByTags()` and the response
subscriber.

## Auto-purge internals (usually not called directly)

- `cloudflare_purge.cache_tag_invalidator` → `CloudflareCacheTagInvalidator` — tagged
  `cache_tags_invalidator` (priority -100); routes invalidated tags to immediate purge or the pending
  set. Const `LAST_FULL_PURGE_STATE_KEY`.
- `cloudflare_purge.pending_tags_store` / `.pending_tag_drainer` — the dedup table
  (`cloudflare_purge_pending_tags`) and its drain into the `cloudflare_purge_tags` queue.
- `Plugin\QueueWorker\CloudflarePurgeQueueWorker` — processes queued tag batches on cron.
- `cloudflare_purge.event_subscriber` → `CloudflarePurgeSubscriber` — adds the `Cache-Tag` header.

This module defines **no plugin types** to implement; the QueueWorker above is an instance of core's
plugin type, not a new one.
