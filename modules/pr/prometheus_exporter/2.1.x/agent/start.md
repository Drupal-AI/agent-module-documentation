<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prometheus Exporter — agent index

Exposes Drupal metrics in Prometheus text format at `/metrics`. Metrics come from
`MetricsCollector` plugins that are all **disabled by default**; the endpoint is gated by
the `access prometheus metrics` permission. Configure at `/admin/config/system/prometheus_exporter`
(`administer prometheus exporter settings`). Depends on the `previousnext/php-prometheus` lib.

- **The `/metrics` route, access control, settings form, enabling/ordering collectors, config keys** →
  [configure/settings.md](configure/settings.md)
- **The `metrics_collector` plugin type and how to write a collector** →
  [plugins/metrics_collector.md](plugins/metrics_collector.md)
- **`drush prometheus:export`** → [drush/commands.md](drush/commands.md)
- **The two permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `prometheus_exporter_comment` (adds `comment_count`) → [../../modules/prometheus_exporter_comment/2.1.x/agent/start.md](../../modules/prometheus_exporter_comment/2.1.x/agent/start.md)
- `prometheus_exporter_update` (adds `update_status`) → [../../modules/prometheus_exporter_update/2.1.x/agent/start.md](../../modules/prometheus_exporter_update/2.1.x/agent/start.md)
- `prometheus_exporter_token_access` (token instead of permission) → [../../modules/prometheus_exporter_token_access/2.1.x/agent/start.md](../../modules/prometheus_exporter_token_access/2.1.x/agent/start.md)

Key facts:
- Route `prometheus_exporter.metrics` = `/metrics`, GET only, `_permission: access prometheus metrics`.
  Not granted to any role by default → closed until you grant it (or enable token_access).
- Built-in collectors (all `enabled: false`): `user_count`, `node_count`, `revision_count`,
  `queue_size`, `active_user_count`, `anonymous_session_count`, `authenticated_session_count`, `phpinfo`.
- Config object `prometheus_exporter.settings` → `collectors.<id>.{enabled,weight,settings}`.
