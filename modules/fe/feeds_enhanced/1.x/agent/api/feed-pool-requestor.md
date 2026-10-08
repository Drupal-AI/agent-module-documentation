<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced — FeedPoolRequestor plugin type (programmatic imports)

A new plugin type for running programmatic Feeds imports against a **pool of reusable Feed
entities**, so many concurrent imports of the same Feed Type do not clobber one another. Built on
`dx_toolkit`'s plugin base/manager.

## Pieces (src/Plugin/, src/Annotation/)

- Manager service `plugin.manager.feed_pool_requestor` = `FeedPoolRequestorManager` (parent
  `default_plugin_manager`; discovers `Plugin/FeedPoolRequestor`, annotation
  `@FeedPoolRequestor`, alter hook `feed_pool_requestor_info`, cache bin key
  `feed_pool_requestor_plugins`).
- `FeedPoolRequestorInterface` — `clear()`, `execute($parameters, ?$async)`, `locked()`, `idle()`,
  `prunePool(?$max_idle)`, `getPoolStats()`.
- `FeedPoolRequestorBase` (abstract) — implements the interface; inject Feed storage, Feed-Type
  storage, `feeds.lock`, and the processor target-entity storage.
- Annotation `@FeedPoolRequestor` props: `feedTypeId` (required), `maxIdle` (default 3),
  `async` (default FALSE), `deriver` (null — **the module ships no default deriver**; consumers
  provide one requestor per Feed Type, typically via a deriver).

## Behavior (FeedPoolRequestorBase)

- `execute($parameters, $async = NULL)`: `acquireFeed()` (reuse first idle Feed of this type or
  `createFeed()` a new one) → `configureParameters()` stores `$parameters` under the fetcher config
  and, if `$parameters['source']` is set, `$feed->setSource(...)` → runs `startBatchImport()` when
  async else `import()`. Returns the Feed.
- `clear()`: acquires/reuses the Feed, deletes target entities whose `feeds_item.target_id` = the
  Feed id (query `accessCheck(FALSE)`), `clearStates()`, saves.
- `acquireFeed()` / `idle()` / `locked()`: lock status via `feeds.lock`
  (`lockMayBeAvailable("feeds_feed:{id}")`). Feed acquisition is **deferred** to
  `execute()`/`clear()` (not the constructor) to avoid creating orphan Feeds when a requestor is
  merely instantiated (e.g. for cron pruning).
- `__destruct()`: unlocks the reserved Feed to return it to the pool, guarded against a
  pruned/deleted Feed.
- `prunePool($max_idle = maxIdle)`: keeps `$max_idle` idle Feeds, deletes the rest (0 ⇒ delete all
  idle). `getPoolStats()` returns `['total', 'locked', 'idle']`.

## Cron

`feeds_enhanced_cron()` iterates every `plugin.manager.feed_pool_requestor` definition,
`createInstance()`s it, and calls `prunePool()` — so idle pooled Feeds are trimmed to `maxIdle`
automatically.

## Usage sketch

```php
$manager = \Drupal::service('plugin.manager.feed_pool_requestor');
$pool = $manager->createInstance('feed_pool:article_importer'); // a consumer-derived id
$pool->clear();                                   // drop this Feed's prior items
$feed = $pool->execute(['source' => 'https://example.com/feed.xml']);
$stats = $pool->getPoolStats();                   // ['total'=>3,'locked'=>1,'idle'=>2]
$pool->prunePool();                               // reclaim excess idle Feeds
```

Notes: this is a code-level API — no route, permission, form or Drush command exposes it. Because it
imports content, callers are trusted (site code); the internal storage queries use
`accessCheck(FALSE)` deliberately for pool bookkeeping.
