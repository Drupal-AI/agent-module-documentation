<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Prometheus Exporter that adds an `update_status` metrics collector reporting Drupal Update Manager status (available module/core updates, including security updates) as scrapeable metrics.

---

Depends on `prometheus_exporter` and core `update`. It registers one `MetricsCollector` plugin,
`update_status` (`src/Plugin/MetricsCollector/UpdateStatusCollector.php`), which reads the Update
Manager's computed project status and exposes it as Prometheus metrics so a scraper can alert when a
security update is available. Like all collectors it is **disabled by default** and exported only once
enabled on the parent settings form or via config (`collectors.update_status.enabled: true`). No config
UI, permission, schema, or Drush of its own. Enable with `drush en prometheus_exporter_update`.

---

- Alert when a Drupal core or contrib security update is available.
- Export the count of projects with available updates as a metric.
- Graph patch-currency of a site over time.
- Feed a fleet-wide "sites needing updates" Grafana panel.
- Trigger an Alertmanager notification on any not-current project status.
- Track update status without logging into each site's Available Updates report.
- Combine update status with other exporter metrics on one dashboard.
- Keep the collector off until update observability is wanted.
- Pull update status from CLI via `drush prometheus:export` after enabling.
- Monitor security posture across many sites from one Prometheus server.
- Alert specifically when a core security release is available.
- Track the number of outdated contrib modules over time.
- Enable the collector via config in a deployment pipeline.
- Reorder the update collector relative to other collectors.
- Detect a site that has stopped receiving update data (stale cron fetch).
- Drive a "patch compliance" SLA dashboard from the metric.
- Keep update metrics behind the same `access prometheus metrics` gate.
- Combine update status with queue/user metrics for a single ops overview.
