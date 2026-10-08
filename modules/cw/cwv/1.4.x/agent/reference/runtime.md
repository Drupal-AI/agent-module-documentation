<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CWV runtime: endpoint, storage, routes, report, cron

## Beacon flow

1. `cwv_page_attachments()` (`cwv.module`) attaches library `cwv/beacon` + `drupalSettings.cwv`
   (`beaconUrl`, `samplingRate`, `dataLayerEnabled`) to front-end responses when `enabled` is on.
   **Skips admin routes** (`router.admin_context`) and **AJAX** requests; adds cache tag
   `config:cwv.settings`. The same HTML is served whether or not a visitor is sampled (the JS
   decides), so page caching is unaffected.
2. `js/cwv.js` uses the web-vitals approach, applies `samplingRate` client-side, and POSTs JSON
   `{metric, value, rating, url, server_timing…}` to `/cwv/beacon`.
3. `BeaconController::receive()` → `doReceive()` (`src/Controller/BeaconController.php`) persists a
   row via `cwv.beacon_storage`.

## Routes & permissions (`cwv.routing.yml`, `cwv.permissions.yml`)

| Route | Path | Requirement | Handler |
|---|---|---|---|
| `cwv.settings` | `/admin/config/development/performance/cwv` | `administer cwv` | `CwvSettingsForm` |
| `cwv.report` | `/admin/reports/cwv` | `view cwv reports+administer cwv` | `ReportController::build` |
| `cwv.events.list` | `/admin/reports/cwv/events` | `view cwv reports+administer cwv` | `EventListController::build` |
| `cwv.events.add` | `/admin/reports/cwv/events/add` | `administer cwv` | `AddEventForm` |
| `cwv.events.delete` | `/admin/reports/cwv/events/{event_id}/delete` | `administer cwv` | `DeleteEventForm` (ConfirmForm) |
| `cwv.beacon` | `POST /cwv/beacon` | `_access: 'TRUE'` | `BeaconController::receive` |

Permissions: `administer cwv` (`restrict access: true`) and `view cwv reports`. The `+` in a
requirement is Drupal's OR — either permission grants access.

## `/cwv/beacon` request handling (source-accurate)

The endpoint is anonymous by design (real users are mostly anonymous). `doReceive()` in order:
dropped-on-204 `if (!enabled)`; **per-IP flood check** via `flood->isAllowed('cwv.beacon', …)`
keyed on `getClientIp()` (honours trusted proxies); JSON body parse (400 on non-array);
**metric allow-list** `['LCP','INP','CLS','FCP','TTFB']` (400 otherwise); numeric-value check (400);
**outlier filter** (drop 204 + info log when over threshold); **server-side sampling** re-applied via
`random_int()` (cryptographic, resists direct-POST prediction) with per-metric overrides + adaptive
bump; flood `register()` only after acceptance; rating normalised against
`['good','needs_improvement','poor']`; URL reduced by `url_storage` policy (`urlForStorage()` also
strips userinfo/fragment even on `full`); route resolved best-effort via alias manager +
`router.no_access_checks`; synchronous collectors run; async-decoration data merged by `request_id`
(from `Server-Timing: cwv-rid`) out of `AsyncContextStore`; row written; sampled `enforceMaxRows()`.
Any throwable is caught → **204** (never 5xx, to avoid JS retry storms). Storage uses the
`insert()->fields()` query builder (parameterised).

## Storage services

- **`BeaconStorage`** (`cwv.beacon_storage`) — `write()`, `recent(limit≤1000, metric?, rating?)`,
  `pruneOlderThan()`, `enforceMaxRows()` (approx `information_schema` count then exact COUNT +
  FIFO delete-by-id), and aggregation methods powering panels: `distributionByMetricRating()`,
  `perRouteSummary()` (PHP type-7 percentiles), `cacheStateComparison()`,
  `correlateByBackendCacheMisses()`, `correlateByRenderTreeSize()`,
  `correlateByDatabaseQueryCount()`, `dailyCounts()`.
- **`ProbeStorage`** (`cwv.probe_storage`) — write/prune `cwv_probes`.
- **`EventStorage`** (`cwv.event_storage`) — `record()`, `recent()`, `load()`, `delete()` for
  `cwv_events`.

## Schema (`cwv.install`, `hook_schema`)

- `cwv_beacons`: `id`, `received_at`, `metric`, `metric_value`, `rating`, `url_hash` (md5, always),
  `url_path` (policy-dependent, nullable), `route_name`, `user_state` (anon/auth), `context_data`
  (JSON from collectors), `request_id`. Indexed for recent/per-metric/per-route/per-rating/url_hash.
- `cwv_probes`: `probe_id`, `observed_at`, `collector_key`, `target`, `observations` (JSON),
  `source` (cron/drush/manual).
- `cwv_events`: `id`, `recorded_at`, `label`, `source`, `notes`.

## Report panels (`/admin/reports/cwv`)

`ReportController::build()` is a thin composition over
`CollectorRegistry::getPanelContributors()` (weight-sorted), rendered `max-age: 0`. Query filters
`metric` / `rating` are validated against the same allow-lists. Built-in panels by weight:
Cache HIT-vs-MISS comparison (lead) → per-metric distribution → per-route p50/p75/p95 →
backend-cache / render-tree / DB-query correlation → daily counts (with deploy-event markers) →
OPcache/APCu health time-series → recent measurements. Panel tables render row values through
Drupal's table theme (auto-escaped).

## Cron (`cwv_cron`)

Prunes `cwv_beacons`/`cwv_probes` by `retention_days`, FIFO-prunes to `max_rows`, and — when
`probe_enabled` — calls `ProbeRunner::run('cron')` to iterate probe collectors' targets and write
observations. `ProbeRunner` rejects targets > 500 chars and catches per-collector/per-target
failures without aborting the run.
