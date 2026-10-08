<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CWV (cwv) — agent index

Self-hosted **Real User Monitoring** for Core Web Vitals. Bundled beacon JS captures **LCP, INP,
CLS, FCP, TTFB** from visitor browsers and POSTs them to an in-Drupal endpoint; rows land in
`cwv_beacons`, cron probes in `cwv_probes`, operator deploy markers in `cwv_events`. A report at
`/admin/reports/cwv` joins each metric to Drupal-side signal (cache state, query count, render-tree
size, per-route percentiles). **No external service, no external JS calls** — all data stays in the
site database. Package `Performance and scalability`. Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.4.4.

- **No module dependencies.** `path_alias` (core) is used if present but injected nullable, not
  required. `composer.json` *suggests* `drupal/lscache` and `drupal/jelastic_info` for the planned
  `cwv_lscache` / `cwv_jelastic` submodules (**not shipped in this release**).
- **No formal plugin type** (no plugin manager/annotation): the collector "contract" is a
  **tagged-service** pattern (tag `cwv_collector`) materialised by `CollectorRegistry`.

## Solution docs

- **Settings, config object, every key, install/enable** → [config/settings.md](config/settings.md)
- **Beacon endpoint, storage, routes/permissions, report panels, cron** →
  [reference/runtime.md](reference/runtime.md)
- **Collector contract (4 shapes) — extend from a sibling module** →
  [api/collector-contract.md](api/collector-contract.md)

## What it provides (from source)

- **Routes** (`cwv.routing.yml`): `cwv.settings` (`/admin/config/development/performance/cwv`, perm
  `administer cwv`), `cwv.report` (`/admin/reports/cwv`, perm `view cwv reports+administer cwv`),
  `cwv.events.list` / `cwv.events.add` / `cwv.events.delete` (events UI), and `cwv.beacon`
  (`POST /cwv/beacon`, `_access: 'TRUE'` — anonymous by design; validates and rate-limits).
- **Permissions** (`cwv.permissions.yml`): `administer cwv` (restrict access), `view cwv reports`.
- **Config**: single object `cwv.settings` (install defaults `config/install/cwv.settings.yml`,
  schema `config/schema/cwv.schema.yml`). Settings form `CwvSettingsForm` (`ConfigFormBase`).
- **Storage services**: `cwv.beacon_storage` (`BeaconStorage`), `cwv.probe_storage`
  (`ProbeStorage`), `cwv.event_storage` (`EventStorage`) — all wrap the DB layer.
- **Registry / runner**: `cwv.collector_registry` (`CollectorRegistry`, from `!tagged_iterator
  cwv_collector`), `cwv.probe_runner` (`ProbeRunner`), `cwv.async_context_store`
  (`AsyncContextStore`, keyvalue.expirable).
- **Built-in collectors** (services tagged `cwv_collector`): `DrupalCacheCollector`,
  `UserStateCollector`, `UpstreamIdCollector` (synchronous); `KernelTimingDecorator`,
  `BackendCacheCollector`, `RenderTreeCollector`, `DatabaseCollector` (async decorators);
  `EdgeCacheProbeCollector`, `OpcacheHealthProbeCollector`, `ApcuHealthProbeCollector` (probes);
  `CacheComparisonPanel`, `DistributionPanel`, `PerRouteSummaryPanel`, `DailyCountsPanel`,
  `RecentMeasurementsPanel`, `HealthTimeSeriesPanel` (panels).
- **Event subscribers**: `CwvRequestIdSubscriber` (stamps `Server-Timing: cwv-rid`),
  `UpstreamIdSubscriber`, `CacheStateHeaderSubscriber`, plus the instrumentors
  `CacheInstrumentor`, `RenderTreeInstrumentor`, `DatabaseInstrumentor`, and the
  `InstrumentedCacheFactory` decoration of core `cache_factory`.
- **Schema** (`cwv.install`): tables `cwv_beacons`, `cwv_probes`, `cwv_events`; `hook_cron` prunes
  by retention + `max_rows` and drives probes; `hook_requirements` warns on trusted-proxy posture.
- **Library** (`cwv.libraries.yml`): `cwv/beacon` = `js/cwv.js` + `core/once`, `core/drupal`,
  `core/drupalSettings`. Attached by `cwv_page_attachments()` (skips admin routes and AJAX).
