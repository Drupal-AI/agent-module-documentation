<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Telemetry & Performance Insights (content_telemetry) — agent index

Self-contained, privacy-safe performance telemetry for Drupal. Instruments front-end HTML
requests at the PHP level (`hrtime`), samples a configurable share, writes insert-only raw
samples, rolls them up via cron into hourly/daily aggregates, and derives deterministic
rule-based **health insights** shown in an admin UI and a JSON API. **No external service calls,
no JS trackers, no PII** — all data stays in the local database. Package `Performance`.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.1.3. Depends on core **`node`**,
**`views`**, **`system`**.

## Solution docs

- **Collection pipeline, rollup, data model, insight rules & scoring** → [insights/engine.md](insights/engine.md)
- **Settings form, config object + schema, install defaults, cron** → [config/settings.md](config/settings.md)
- **Dashboard, drilldowns, tabs, routes & permissions** → [ui/dashboard.md](ui/dashboard.md)
- **JSON insight API** → [api/insights-api.md](api/insights-api.md)

## What it provides

- **Permissions** (`content_telemetry.permissions.yml`): `view content telemetry` (all reports +
  API), `administer content telemetry` (settings form), `clear content telemetry` (declared but
  **not referenced by any route/controller** in this release).
- **Services** (`content_telemetry.services.yml`): `content_telemetry.collector`
  (`Service/TelemetryCollector`), `.aggregator` (`Service/TelemetryAggregator`),
  `.rollup_manager` (`Service/TelemetryRollupManager`), `.entity_performance_provider`
  (`Service/EntityPerformanceProvider`), `.block_collector` (`Service/BlockTelemetryCollector`),
  `.threshold_config` (`Service/ThresholdConfig`), `.insight_service` (`Service/InsightService`),
  `.sparkline_renderer` (`Service/SparklineRenderer`), plus event subscribers
  `.request_subscriber` (`EventSubscriber/RequestSubscriber`) and `.view_subscriber`
  (`EventSubscriber/ViewSubscriber`).
- **Routes** (`content_telemetry.routing.yml`): dashboard, settings, per-node/view/block
  performance, route/view/block reports, route/view drilldowns, two JSON API endpoints, and a
  `/ctpi-test` diagnostic route (gated `administer site configuration`). See reports doc.
- **Hooks** (`content_telemetry.module`, `content_telemetry.block.inc`): `hook_help`,
  `hook_cron` (runs rollup + prunes raw > 14 days), `hook_block_view_alter` (optional block timing
  via a `#post_render` callback).
- **Database** (`content_telemetry.install`, `hook_schema`): `content_telemetry_hourly` (raw),
  `content_telemetry_agg_hourly`, `content_telemetry_agg_daily`. Updates 9001-9004.
- **Config**: object `content_telemetry.settings` (schema in `config/schema/`, defaults in
  `config/install/` and seeded in `hook_install`).
- **No custom entities, no plugin types** (insight rules are a plain internal interface, not a
  Drupal plugin manager). CSS-only library `content_telemetry/entity-performance`.

## Notes (from source)

- `db_ms` and `cache_hit_ratio` in raw samples are **not measured** — `TelemetryCollector::finish()`
  writes `db_ms = render_ms * 0.35` and a fixed `cache_hit_ratio = 0.5`. Render time is the only
  truly measured metric.
- Users with `administer site configuration` are always sampled (`shouldSample()`), independent of
  the sampling rate.
- Only front-end `text/html` responses are recorded; `/admin` paths are excluded in both the
  request collector and the block subscriber.
