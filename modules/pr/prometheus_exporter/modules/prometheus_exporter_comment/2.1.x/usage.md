<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Prometheus Exporter that adds a single `comment_count` metrics collector so comment totals can be scraped alongside the other Drupal metrics.

---

Depends on `prometheus_exporter` and core `comment`. It registers one `MetricsCollector` plugin,
`comment_count` (`src/Plugin/MetricsCollector/CommentCollector.php`), that reports the number of
comments. Like all collectors it is **disabled by default** and only exported once enabled on the
Prometheus Exporter settings form (`/admin/config/system/prometheus_exporter`) or via config
(`prometheus_exporter.settings` → `collectors.comment_count.enabled: true`). There is no config UI,
permission, or schema of its own — it plugs into the parent's endpoint, access control, and Drush
command. Enable with `drush en prometheus_exporter_comment`.

---

- Export the total comment count as a Prometheus metric.
- Graph comment volume over time in Grafana.
- Monitor a spike in comments (possible spam) via an Alertmanager rule.
- Add comment metrics without touching the core exporter configuration.
- Include comment counts in a site-health dashboard.
- Scrape comment totals over the same `/metrics` endpoint as node/user counts.
- Keep the collector off until you actually need comment observability.
- Track engagement by correlating comment counts with authenticated session counts.
- Pull the metric from CLI with `drush prometheus:export` after enabling.
- Provide comment observability across a multi-site fleet.
- Reorder the comment collector relative to other collectors on the settings form.
- Alert when comment volume drops to zero (broken commenting).
- Compare comment counts across environments (prod vs staging).
- Add comment metrics via config (`collectors.comment_count.enabled: true`) in a deployment.
- Correlate comment growth with node growth on one dashboard.
- Capacity-plan moderation workload from comment trend data.
- Keep comment metrics behind the same `access prometheus metrics` gate as the rest.
