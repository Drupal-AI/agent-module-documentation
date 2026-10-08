<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Exporter - Comment — agent index

Adds one `MetricsCollector` plugin, `comment_count`, to the parent Prometheus Exporter. No config UI,
permissions, schema, or Drush of its own — it rides on the parent's `/metrics` route and settings form.
Depends on `prometheus_exporter` + core `comment`.

- **The collector and how to enable it** → [plugins/comment_count.md](plugins/comment_count.md)

Parent module docs: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)
