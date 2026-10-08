<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collector: `update_status`

- Class: `Drupal\prometheus_exporter_update\Plugin\MetricsCollector\UpdateStatusCollector`
  (`#[MetricsCollector(id: 'update_status', ...)]`), extends the parent's `BaseMetricsCollector`.
- Reads Drupal's Update Manager project status and emits it as Prometheus metrics (available updates,
  security updates) via `collectMetrics()`.
- `enabled: false` by default; `applies()` guards on the core `update` module.

Enable:
```bash
ddev drush en prometheus_exporter_update -y
ddev drush cset prometheus_exporter.settings collectors.update_status.enabled true -y
```
Then it appears in `/metrics` and `drush prometheus:export`. Update data freshness depends on the core
Update Manager's own cron fetch. See the parent's
[plugins/metrics_collector.md](../../../../../2.1.x/agent/plugins/metrics_collector.md).
