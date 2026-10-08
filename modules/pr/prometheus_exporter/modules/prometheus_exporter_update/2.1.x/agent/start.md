<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Exporter - Update Manager — agent index

Adds one `MetricsCollector` plugin, `update_status`, exporting Drupal Update Manager status. No config
UI, permissions, schema, or Drush of its own — rides on the parent's `/metrics` route and settings form.
Depends on `prometheus_exporter` + core `update`.

- **The collector and how to enable it** → [plugins/update_status.md](plugins/update_status.md)

Parent module docs: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)
