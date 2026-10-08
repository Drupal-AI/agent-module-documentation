# Monitoring Prometheus — agent index

Exposes Monitoring sensor results at **`/metrics`** in Prometheus format. Depends on `monitoring`.

- **The endpoint, permission, IP allowlist, custom labels, settings** → [configure/metrics-endpoint.md](configure/metrics-endpoint.md)

Key facts:
- Route `monitoring_prometheus.metrics` → path `/metrics` (GET), controller `MetricsController::metrics`,
  registered by `Routes::routes()` with all auth providers attached.
- Permission: `access monitoring prometheus metrics`; plus IP check `MetricsController::ipAccess()`.
- Config `monitoring_prometheus.settings`: `allowed_ips` (sequence), `custom_labels` (sequence).
  No admin form — set via config.
