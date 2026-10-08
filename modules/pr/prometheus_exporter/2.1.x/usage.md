<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prometheus Exporter publishes Drupal runtime metrics in the Prometheus text exposition format at a `/metrics` route so a Prometheus scraper (and Grafana) can graph node/user counts, queue sizes, session counts and PHP info. Which metrics are exported is chosen per pluggable "metrics collector"; every collector ships **disabled** and the endpoint is gated by the `access prometheus metrics` permission.

---

The module registers a dynamic route `/metrics` (`prometheus_exporter.metrics`, GET only, permission `access prometheus metrics`, all authentication providers allowed) whose controller iterates every enabled `MetricsCollector` plugin, serializes each `PNX\Prometheus\Metric` via `previousnext/php-prometheus`, and returns `text/plain; version=0.0.4`. Collectors are a config-driven plugin type (`plugin.manager.metrics_collector`, attribute `#[MetricsCollector]`): the eight built-ins are `user_count`, `node_count` (per bundle), `revision_count`, `queue_size`, `active_user_count` (window in seconds), `anonymous_session_count`, `authenticated_session_count`, and `phpinfo`. All eight default to `enabled: false` in `config/install`, so a freshly enabled module exports nothing until an admin enables collectors on the settings form (`/admin/config/system/prometheus_exporter`, permission `administer prometheus exporter settings`) where they can also reorder (tabledrag weight) and set per-collector settings. A Drush command `prometheus:export` prints the same output on the CLI without hitting the route. Three submodules add collectors/behaviour: `prometheus_exporter_comment` (`comment_count`), `prometheus_exporter_update` (`update_status` from the Update Manager), and `prometheus_exporter_token_access` (lets a query-string / `Authorization: Bearer` token stand in for the permission). The README warns that metrics can reveal module versions and other operational detail, so access should be restricted (firewall, basic auth, or the permission) to trusted scrapers.

---

- Expose Drupal metrics at `/metrics` for a Prometheus server to scrape.
- Graph total user count in Grafana.
- Track node counts broken down per content type (bundle).
- Monitor node revision counts per bundle.
- Alert on growing queue sizes (background/cron backlog).
- Count active users within a configurable recent window (e.g. last 15 minutes).
- Report the number of anonymous sessions currently open.
- Report the number of authenticated sessions currently open.
- Export PHP runtime info (`phpinfo` collector) as metrics.
- Add comment-count metrics via the `prometheus_exporter_comment` submodule.
- Export Drupal Update Manager status (available security updates) via `prometheus_exporter_update`.
- Enable only the collectors you need and keep everything else off by default.
- Reorder collectors so their metrics appear in a preferred order.
- Restrict scrape access with the `access prometheus metrics` permission.
- Allow a Prometheus scraper to authenticate with a static token (query string or Bearer header) via `prometheus_exporter_token_access`.
- Pull metrics from the CLI/cron with `drush prometheus:export` instead of an HTTP scrape.
- Feed a Grafana dashboard tracking site growth over time.
- Provide observability for a multi-site fleet by scraping each site's `/metrics`.
- Add a custom metric by implementing a `MetricsCollector` plugin (e.g. orders placed, webform submissions).
- Detect a stuck queue worker by watching `queue_size` trend upward.
- Correlate traffic spikes with authenticated vs anonymous session counts.
- Wire metrics into alerting rules (Alertmanager) for capacity planning.
- Keep the endpoint off the public internet while still exposing it to an internal scraper.
