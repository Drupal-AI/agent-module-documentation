<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Telemetry & Performance Insights (CTPI) records request-level render-time telemetry for nodes, routes, views and blocks, aggregates it via cron, and turns it into deterministic, editor-friendly performance insights inside the Drupal admin UI.

---

CTPI instruments each front-end HTML request with a monotonic timer (`hrtime`), samples a configurable percentage of traffic, and writes an insert-only raw sample (route, entity type/id, render ms, estimated DB ms, cache-hit ratio) to `content_telemetry_hourly`. Drupal cron rolls raw samples up into bounded, idempotent hourly and daily aggregate tables and prunes raw data older than 14 days. A deterministic rule engine (six rules covering render budget, DB ratio, cache-hit ratio, week-over-week regression, heavy-block dominance and globally slow blocks) scores each entity and the whole site on a 0-100 health scale (Good / Needs attention / Critical). Reports, drilldowns, per-node/view/block performance tabs, inline SVG sparklines, and two JSON API endpoints expose the results — all gated by the `view content telemetry` or `administer content telemetry` permissions. Everything runs locally: no external services, no JS trackers, no PII. Requires core Node, Views and System; runs on Drupal 10 and 11.

---

- Monitor real front-end render times per node, route, view and block without an external APM service.
- Get a site-wide health score (0-100) and per-entity health badges on `admin/reports/content-telemetry`.
- See a per-node "Performance" tab at `/node/{id}/performance` with a 24-hour sparkline and metric tiles.
- Identify the slowest routes on the Route performance report and drill into a single route's trend.
- Identify slow Views displays on the View performance report and drill into the block-level breakdown.
- Find blocks that dominate a page's render time (Heavy block dominance rule).
- Find blocks that are slow across many routes site-wide (Global slow block rule).
- Get warned when a page's average render time exceeds a configurable render budget (SLO-style alerting).
- Detect week-over-week performance regressions (24h avg vs. 7-day baseline).
- Detect pages spending a high fraction of render time in the database (DB ratio rule).
- Detect pages with a low cache-hit ratio (Low cache-hit rule).
- Tune sampling rate (default 5%) to trade coverage against overhead on high-traffic sites.
- Force 100% sampling temporarily on a dev/staging site to gather data quickly.
- Enable optional block-level telemetry only while investigating a specific slowdown.
- Adjust every insight threshold (render budget, DB ratio, cache-hit, regression %) from a settings form.
- Poll `/api/content-telemetry/insights/dashboard` from a monitoring script or CI health check.
- Poll `/api/content-telemetry/insights/{entity_type}/{entity_id}` to fail a deploy when a page's score drops.
- Keep all performance data inside your own database for privacy/compliance reasons.
- Run performance reporting on Drupal 10 or 11 with only core Node/Views/System as dependencies.
- Give editors and site owners a plain-language read on which content is slow and why.
- Track whether a content or configuration change improved or regressed a page over time.
