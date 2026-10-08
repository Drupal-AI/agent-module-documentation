<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collector: `comment_count`

- Class: `Drupal\prometheus_exporter_comment\Plugin\MetricsCollector\CommentCollector`
  (`#[MetricsCollector(id: 'comment_count', ...)]`), extends the parent's `BaseMetricsCollector`.
- Reports the comment total via `collectMetrics()`.
- `enabled: false` by default like every collector; `applies()` guards on the `comment` module.

Enable:
```bash
ddev drush en prometheus_exporter_comment -y
ddev drush cset prometheus_exporter.settings collectors.comment_count.enabled true -y
```
Then it appears in `/metrics` and `drush prometheus:export`. See the parent module's
[plugins/metrics_collector.md](../../../../../2.1.x/agent/plugins/metrics_collector.md)
for the plugin type contract.
