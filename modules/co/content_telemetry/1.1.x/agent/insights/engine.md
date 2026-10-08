<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection pipeline, data model & insight engine

How CTPI gets from a page request to a scored insight. All classes live under `src/`.

## Collection (per request)

`EventSubscriber/RequestSubscriber` (service `content_telemetry.request_subscriber`) subscribes to
`KernelEvents::REQUEST` (priority 1000) and `KernelEvents::RESPONSE` (priority -1000), main request
only.

- `onRequest()` → `TelemetryCollector::start()`: sets a monotonic `hrtime(TRUE)` start and decides
  `shouldSample()`.
- `onResponse()` → `TelemetryCollector::finish()`: returns a sample array or `NULL`, and if non-null
  calls `TelemetryAggregator::aggregate()`.

`TelemetryCollector::shouldSample()` returns TRUE if config `force_sample` is on, OR if the current
user has permission **`administer site configuration`** (admins are always sampled), else
`random_int(1,100) <= sampling_rate` (default 5).

`TelemetryCollector::finish()` returns `NULL` unless the request was active+sampled AND the response
`content-type` contains `text/html` AND the path does **not** start with `/admin`. It then computes
`render_ms = round((hrtime-start)/1e6)` and classifies the entity:
- a request attribute `node` present → `entity_type = 'node'`, `entity_id = node id`;
- else route name starting `view.` → `entity_type = 'view'`, `entity_id = crc32(route) & 0x7fffffff`;
- else → `entity_type = 'route'`, `entity_id = crc32(route) & 0x7fffffff`.

**Important — synthetic metrics:** the sample's `db_ms` is set to `render_ms * 0.35` and
`cache_hit_ratio` is a **hardcoded 0.5**. These are *not measured*. Render time is the only real
metric. (Consequence: `LowCacheHitRule` never fires at its default 0.50 warn threshold because
0.5 is not `< 0.5`.)

### Block-level (optional)

`content_telemetry.block.inc` `hook_block_view_alter()` adds a `#post_render` callback that times a
block with `hrtime` and calls `BlockTelemetryCollector::record($route, $plugin_id, $render_ms)`.
`record()` is a no-op unless config `enable_block_telemetry` is TRUE (default FALSE) and `render_ms > 0`.
The block sample stores `route = "{route}|{plugin_id}"`, `entity_type = 'block'`,
`entity_id = crc32(plugin_id) & 0x7fffffff`. Admin paths are skipped in the hook.

### Views

`EventSubscriber/ViewSubscriber` (service `content_telemetry.view_subscriber`) listens on
`ViewEvents::VIEW_POST_EXECUTE` (guarded by `class_exists` so it is inert without Views) and records
a sample with `route = "view.{id}"`, `entity_type = 'view'` — but **`render_ms = 0` and
`cache_hit_ratio = 0.0`** (coarse attribution only; view render time is not actually timed).

## Write path

`Service/TelemetryAggregator::aggregate()` does a single `INSERT` into
`content_telemetry_hourly` (insert-only, no locks, no runtime aggregation). Uses the DB abstraction
layer with typed casts.

## Rollup (cron)

`content_telemetry_cron()` calls `TelemetryRollupManager::run()` then deletes raw rows older than
14 days (`hour < floor((time()-14d)/3600)`).

`Service/TelemetryRollupManager` (service `content_telemetry.rollup_manager`, injects `@database`,
`@state`):
- `aggregateHourly()`: never processes the current hour; cursor in state key
  `content_telemetry.last_hourly_rollup`; always steps back one hour to catch late writes; bounded
  to 24 hours/run; idempotent (deletes the target hour's aggregate row before re-inserting). SQL is a
  parameterized `INSERT ... SELECT ... GROUP BY route, entity_type, entity_id, hour` into
  `content_telemetry_agg_hourly` (`samples = COUNT(*)`, `avg/max/avg/avg`).
- `aggregateDaily()`: never processes "today"; cursor `content_telemetry.last_daily_rollup`
  (a `Ymd` int); steps back one day; bounded to 7 days/run; idempotent per day; rolls
  `content_telemetry_agg_hourly` into `content_telemetry_agg_daily`.

Table names come from class constants; all `hour`/`day`/`start`/`end` values are bound placeholders.

## Data model (`content_telemetry.install`, `hook_schema`)

- `content_telemetry_hourly` — raw samples. Cols: `id`, `route`, `entity_type`, `entity_id`,
  `hour`, `requests`, `avg_render_ms`, `p95_render_ms`, `avg_db_ms`, `cache_hit_ratio`. Indexes
  `route_hour_idx`, `entity_idx`.
- `content_telemetry_agg_hourly` — hourly aggregate. Cols include `hour`, `samples`, `avg_render_ms`,
  `max_render_ms`, `avg_db_ms`, `cache_hit_ratio`. Indexes `entity_hour_idx`, `route_hour_idx`.
- `content_telemetry_agg_daily` — daily aggregate, keyed on `day` instead of `hour`.

**All reporting reads the aggregate tables** (`content_telemetry_agg_hourly`), never the raw table
(except `BlockReportController` falls back to raw if the aggregate table is missing). Update hooks
9001-9003 backfill schema on old installs; 9004 seeds Phase-5 threshold defaults.

## Insight engine

`Service/InsightService` (service `content_telemetry.insight_service`; injects `@database`,
`@entity_performance_provider`, `@threshold_config`) registers six rules and runs each via
`InsightRuleInterface::evaluate(array $context): ?array`. Context = `summary`, `last24`, `baseline`
(from `EntityPerformanceProvider::load()`), `route`, and `thresholds` (`ThresholdConfig::toArray()`).

- `analyzeEntity($type, $id, $route=NULL)` — per-entity; memoized per request.
- `analyzeDashboard()` — site-wide (aggregates all `entity_type='node'` rows); passes `last24`,
  `baseline`, `route` as NULL, so only summary-based rules apply.

### The six rules (`src/Service/Insight/Rules/`)

| Rule | Scope | Warn / Poor thresholds |
|---|---|---|
| `PerformanceBudgetRule` | summary | avg_render ≥ budget / ≥ 2× budget (budget default 500 ms) |
| `HighDbRatioRule` | summary | avg_db/avg_render ≥ `db_ratio_warn` (0.40) / ≥ `db_ratio_poor` (0.60) |
| `LowCacheHitRule` | summary | cache_hit < `cache_hit_warn` (0.50) / < `cache_hit_poor` (0.30) |
| `RegressionRule` | last24 vs baseline | delta ≥ `regression_warn_pct` (10%) / ≥ `regression_poor_pct` (25%) |
| `HeavyBlockDominanceRule` | one route (needs `route`) | slowest block ≥ 50% / ≥ 70% of route render |
| `GlobalSlowBlockRule` | dashboard (route empty) | a block on ≥ 3 routes averaging ≥ 500 ms / ≥ 800 ms |

`HeavyBlockDominanceRule` and `GlobalSlowBlockRule` run their own aggregate-table queries (memoized
per route / per request). Thresholds are read from context with `ThresholdConfig::DEFAULT_*` fallbacks.

### Scoring

Each fired insight is tagged `score` from `SEVERITY_SCORE` (`poor=85, warn=50, good=10`) and sorted
poor→warn→good. `computeHealthScore()` starts at 100 and subtracts `SEVERITY_PENALTY`
(`poor=-30, warn=-15`), floored at 0. `healthScoreLabel()`: ≥80 **Good**, ≥50 **Needs attention**,
else **Critical**; `healthScoreClass()`: `good` / `warn` / `poor`.

`buildRenderArray()` renders the insight panel (severity-coloured cards + optional health-score
widget). `Service/SparklineRenderer` (service `content_telemetry.sparkline_renderer`) turns an hourly
series from `EntityPerformanceProvider::loadHourlySeries()` into an inline SVG (no JS library).
