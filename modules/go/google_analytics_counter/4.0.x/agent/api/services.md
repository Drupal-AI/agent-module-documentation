# Services, data pipeline & public methods

## Services

| Service id | Class | Role |
|---|---|---|
| `google_analytics_counter.app_manager` | `GoogleAnalyticsCounterAppManager` (impl. `GoogleAnalyticsCounterAppManagerInterface`) | Builds/runs GA4 queries, writes path + node counts, returns display counts. |
| `google_analytics_counter.cron` | `GoogleAnalyticsCounterCron` (impl. `GoogleAnalyticsCounterCronInterface`) | The `hook_cron` orchestrator; fills the queue. |
| `google_analytics_counter.custom_field_generator` | `GoogleAnalyticsCounterCustomFieldGenerator` | Adds/removes the `field_google_analytics_counter` field. |
| `google_analytics_counter.message_manager` | `GoogleAnalyticsCounterMessageManager` | Dashboard helpers (top-twenty, date labels). |
| `plugin.manager.google_analytics_counter_result_processor` | `GoogleAnalyticsCounterResultProcessorPluginManager` | Result-processor plugin manager. See [../plugins/result-processors.md](../plugins/result-processors.md). |
| `logger.channel.google_analytics_counter` | (logger channel) | Log channel `google_analytics_counter`. |

Also `GoogleAnalyticsCounterHelper` — a static utility class (not a service): `getBaseQuery()`,
`queryNextNodeToProcess()`, `addToQueue()`, `buildQueryDates()`, `getCount()`, `cacheTime()`,
`gacDeleteState()`, `gacRemoveQueuedItems()`, `gacSaveTypeConfig()`.

## The data pipeline (what cron does)

`hook_cron` → `google_analytics_counter.cron::googleAnalyticsCounterCron()`:

1. Throttle: returns early unless `now >= state('google_analytics_counter.last_fetch') + cron_interval*60`
   (set `cron_interval` to 0 to bypass). Also returns early if the worker queue still has items.
2. Optionally `TRUNCATE google_analytics_counter` (only when none of the `node_last_x_days` /
   `node_last_x_nid` / `node_not_newer_than_x_days` limits are set — a full refresh).
3. `appManager->queryTotalPaths()` — one GA4 call to learn the row total; saves state
   `google_analytics_counter.total_paths`; records `last_fetch`.
4. Enqueues into queue `google_analytics_counter_worker`: one `{type:'fetch', index}` item per
   `chunk_to_fetch` chunk, plus the first `{type:'count', nid,…}` item
   (`GoogleAnalyticsCounterHelper::queryNextNodeToProcess()` + `addToQueue()`).
5. Worker `google_analytics_counter_worker` (`GoogleAnalyticsCounterQueue` /
   `GoogleAnalyticsCounterQueueBase::processItem()`):
   - `fetch` → `appManager->gacUpdatePathCounts($index)` — runs the chunk query, passes rows through the
     active result processor, and `merge`s `pagepath`→`pageviews` into `google_analytics_counter`.
   - `count` → `appManager->gacUpdateStorage($nid,$bundle,$vid)`, then enqueues the next node (respecting
     `node_last_x_nid`). Any exception throws `SuspendQueueException` to abort the run cleanly.

`google_analytics_counter_worker`'s per-cron run time comes from `general_settings.queue_time` via
`hook_queue_info_alter`.

## Key `app_manager` methods

```php
$app = \Drupal::service('google_analytics_counter.app_manager');

// Formatted pageview count for the CURRENT request context
// (front page / node route / path). Used by the block and [gac] token.
$count = $app->gacDisplayCount(); // e.g. "1,234"

// Run one chunk query and merge path→pageviews into google_analytics_counter.
$app->gacUpdatePathCounts($index = 0, $currentTimestamp = NULL);

// Compute a node's total (via the result processor) and write it to
// google_analytics_counter_storage + node__field_google_analytics_counter.
$app->gacUpdateStorage($nid, $bundle, $vid);

// Total path count from GA (also saved to state google_analytics_counter.total_paths).
$total = $app->queryTotalPaths();

// Low-level: RunReportResponse for a chunk.
$feed = $app->reportData($step, [], [], $currentTimestamp);
```

Internally `buildQuery()` assembles the GA4 request (`property`, `dateRanges`, `dimensions`, `metrics`,
`offset`, `limit`), dispatches the `google_analytics_counter.query_alter` event
(see [../events/query-alter.md](../events/query-alter.md)), then `gacGetFeed()` calls
`BetaAnalyticsDataClient::runReport()` (library `google/analytics-data`) and caches the result under cid
`google_analytics_counter_<md5>` with tag `google_analytics_counter_data`.

## Storage / DB tables (`hook_schema`)

| Table | Key columns | Written by |
|---|---|---|
| `google_analytics_counter` | `pagepath_hash` (md5 PK), `pagepath` (varchar 2048), `pageviews` (bigint unsigned) | `gacUpdatePathCounts()` (`merge`) |
| `google_analytics_counter_storage` | `nid` (PK), `pageview_total` | `updateCounterStorage()` (`merge`) |
| `node__field_google_analytics_counter` | field table | `updateCounterStorage()` (`upsert`) |

`sumPageviews()` (on the plugin base) reads `google_analytics_counter` by `IN (md5 hashes)` to total a
node's aliases. Node totals also invalidate the entity cache entry `values:node:{nid}`.
