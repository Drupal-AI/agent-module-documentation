Self-hosted real-user Core Web Vitals (LCP, INP, CLS, FCP, TTFB) tracking for Drupal that correlates every measurement with backend signal and stays entirely in your own database.

---

CWV attaches a bundled beacon JS library to front-end pages, samples a fraction of pageviews, and POSTs each captured Web Vitals metric to an in-Drupal endpoint at `/cwv/beacon`; measurements persist to the `cwv_beacons` table and cron-driven synthetic checks to `cwv_probes`. No data leaves the site — there are no calls to Google PageSpeed, CrUX, or any external analytics service. A report at `/admin/reports/cwv` renders panels that join each metric to Drupal-side context: page/dynamic cache HIT vs MISS, backend cache miss count, render-tree cache-tag size, per-request database query count, per-route p50/p75/p95 percentiles, and daily counts overlaid with operator-recorded deploy events. Capture is off after install and sampling defaults to 0.1; per-IP flood protection, a `max_rows` table ceiling, server-side sampling enforcement, and ingest-time outlier filtering harden the public beacon endpoint, and three URL-storage policies (hash / path / full) let operators bound PII exposure. The module is architected as a substrate: a tagged-service collector contract with four shapes (synchronous, async-decoration, probe, panel-contribution) lets sibling modules add context fields and report panels through a single `cwv_collector`-tagged service.

---

- Measure real-user LCP, INP, CLS, FCP, and TTFB from actual visitor browsers rather than lab/synthetic tools only.
- Keep all Web Vitals data self-hosted in your own database with no third-party RUM vendor and no external JS endpoints.
- Answer "does the page cache hit rate predict LCP on this route?" from the cache HIT-vs-MISS comparison panel.
- Find whether slow INP outliers cluster on logged-in (authenticated) pageviews via the `user_state` dimension.
- Track whether the count of "poor" beacons shifted after a specific deploy using deploy-event annotations on the time-series panel.
- Rank routes by worst p75 TTFB (or any metric) from the per-route p50/p75/p95 summary panel.
- Sample only a fraction of traffic (default 10%) to bound table growth on high-traffic sites, tunable 0.0–1.0.
- Capture more of a browser-support-limited metric (typically INP) with per-metric sampling overrides without raising the global rate.
- Keep low-volume metrics from vanishing into the sampling floor with adaptive sampling that bumps the rate to 1.0 when throughput drops below a floor.
- Bound stored PII by choosing hash-only, path-only, or full-URL storage per the site's GDPR/CCPA posture.
- Drop obvious non-RUM noise (backgrounded tabs, bots, broken pages) at ingest with per-metric outlier thresholds.
- Rate-limit the public beacon endpoint per IP with a configurable flood threshold and window.
- Cap the `cwv_beacons` table with a `max_rows` FIFO ceiling as a backstop when cron-based retention pruning is unreliable.
- Correlate metrics with backend cache hit/miss counts by enabling per-request backend cache instrumentation.
- Correlate metrics with render-tree size (cache-tag count) by enabling render-tree instrumentation.
- Correlate metrics with per-request database query count, total time, and slow-query count.
- Snapshot OPcache health (hit rate, wasted memory, OOM restarts) on cron and chart it over time (requires HTTP-context cron).
- Snapshot APCu health (hit rate, fragmentation, expunges) on cron and chart it over time.
- Probe edge-cache state (LSCache, Cloudflare, Varnish, Fastly, CloudFront, plus Drupal page/dynamic cache) by HEAD-requesting configured canonical URLs on cron.
- Correlate a slow measurement back to an upstream/CDN log line by capturing a request-ID header (cf-ray, x-amzn-trace-id, x-request-id, etc.).
- Push page-cache and dynamic-cache state to `window.dataLayer` for GTM/GA4 custom-dimension breakdowns of Web Vitals.
- Record deploy, config-change, and infrastructure-switch events as labelled timestamps that overlay the time-series charts.
- Extend the dataset from a sibling module by tagging a service `cwv_collector` to add new `context_data` fields and/or a new report panel.
- Turn capture on or off without uninstalling by toggling the single `enabled` setting.
