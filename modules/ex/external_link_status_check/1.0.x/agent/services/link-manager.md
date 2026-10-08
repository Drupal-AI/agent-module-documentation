<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scanning pipeline: services, hooks & queue worker

All discovery, HTTP checking, and queueing lives in three services plus one queue worker.

## `ExternalLinkManager` (`src/ExternalLinkManager.php`)

Service `external_link_status_check.manager` (aliased to the FQCN). Constructor deps:
`http_client` (Guzzle), `database`, `entity_type.manager`, `logger.factory`. Key methods:

- `getEntitiesToScan(): array` — iterates all entity type definitions, keeps `content`-group types
  that have a `storage` handler, skips `file, user, path_alias, menu_link_content, redirect`, and
  returns `[['type' => id, 'id' => id], …]` for every entity (query uses `accessCheck(FALSE)` —
  this is a background maintenance sweep, not a user-facing listing).
- `scanEntity(ContentEntityInterface $entity): void` — extracts current URLs, calls
  `cleanupRemovedLinks()` (deletes registry rows for this entity whose `url_hash` is `NOT IN` the
  current set; deletes all if the entity now has none), then `checkLink()` for each URL passing
  `FILTER_VALIDATE_URL`.
- `extractUrlsFromEntity(ContentEntityInterface): array` — deep-walks every field value with
  `array_walk_recursive`, regex-matches `https?://` and `www.` URLs, trims trailing punctuation,
  prefixes `www.` matches with `https://`. Follows entity-reference fields recursively; guards
  infinite recursion via `$processedEntities` keyed by uuid/type:id.
- `checkLink(string $url, $entity_id, $entity_type): void` — looks up the registry by `url_hash`;
  if a row was checked <86400s ago it re-uses the cached status/metadata. Otherwise it issues a
  Guzzle **GET** (`timeout` 5, `connect_timeout` 5, `allow_redirects` TRUE, custom `User-Agent`,
  `verify` TRUE), records the status code, parses metadata, and upserts. On any exception it stores
  status `404` with response time 0.
- `parseMetadata(string $html): array` — loads the response body into `DOMDocument`
  (`libxml_use_internal_errors`), reads `<title>` and the first `og:image`/`twitter:image`/`image`
  meta content as `thumbnail`.
- `getEntityLabel()` / `updateRegistry()` — resolves the source entity label; upserts into
  `external_links_registry` keyed on `url_hash`, truncating `title` to 255 chars.

## `EntityScanQueueService` (`src/Service/EntityScanQueueService.php`)

Service `external_link_status_check.entity_scan_queue`. Deps: `queue`, `entity_type.manager`,
`database`.

- `queueAllEntities()` — for each content-entity type (same skip list) queues up to **50** ids
  (`range(0,50)`, `accessCheck(FALSE)`) into `external_link_status_check_queue` as
  `['entity_type' => …, 'entity_id' => …]`.
- `queueEntity(EntityInterface)` — queues one entity item.
- `deleteEntityLinks(EntityInterface)` — deletes all registry rows for the entity.

## Hooks

`external_link_status_check.module` (procedural) implements `hook_help`, `hook_cron`
(→ `entity_scan_queue->queueAllEntities()`), `hook_entity_insert`/`_update` (→ `queueEntity()`),
`hook_entity_predelete` (→ `deleteEntityLinks()`).

`src/Hook/ExternalLinkHooks.php` (OO, `#[Hook('cron')]` on `onCron()`; other methods are plain
handlers) also implements cron (queues the first 50 `getEntitiesToScan()` tasks as
`['entity_type', 'id']`) and the same insert/update/predelete behavior directly against the queue
and DB. Both procedural and OO cron/entity hooks run on a stock D11 site — expect double queueing.

## `LinkCheckerWorker` (`src/Plugin/QueueWorker/LinkCheckerWorker.php`)

`@QueueWorker(id = "external_link_checker_queue", cron = {"time" = 60})`. `processItem($data)`:

- if `$data['url']` is set → `linkManager->checkLink(url, entity_id, entity_type)`;
- elseif `$data['type']` + `$data['id']` are set → loads the entity and calls
  `linkManager->scanEntity()`.

Note the item shapes queued by the services (`entity_type`/`entity_id` or `entity_type`/`id`) do
not match the `type`/`id` or `url` branches this worker expects, and the queue name differs from the
plugin id (see start.md gotchas) — the reliable path to populate the registry is the manual scan
form's Batch run, which calls `scanEntity()` directly.
