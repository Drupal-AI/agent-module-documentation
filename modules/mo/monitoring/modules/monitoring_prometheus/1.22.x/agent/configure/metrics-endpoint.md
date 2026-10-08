# Monitoring Prometheus — the `/metrics` endpoint & config

## Endpoint

- Route: `monitoring_prometheus.metrics`, path **`/metrics`**, method **GET**.
- Registered dynamically in `\Drupal\monitoring_prometheus\Routing\Routes::routes()` so every enabled
  authentication provider is attached (`_auth`).
- Controller `\Drupal\monitoring_prometheus\Controller\MetricsController::metrics()` runs sensors and
  serialises results via the `monitoring_prometheus.serializer` service (from `PNX\Prometheus`),
  outputting Prometheus text-exposition format.

## Access control (both apply)

1. Permission `access monitoring prometheus metrics`.
2. IP allowlist — `MetricsController::ipAccess()`:
   `allowedIf(empty($allowed_ips) || in_array($request->getClientIp(), $allowed_ips))`.
   So an **empty** `allowed_ips` allows any IP (permission still required); a non-empty list restricts
   scraping to those client IPs.

## Configuration — `monitoring_prometheus.settings`

| Key | Type | Meaning |
|---|---|---|
| `allowed_ips` | sequence of strings | client IPs allowed to scrape (empty = any) |
| `custom_labels` | sequence of strings | extra labels added to every exported metric |

No admin form ships for these — set them via config:

```bash
drush cget monitoring_prometheus.settings allowed_ips
drush cset monitoring_prometheus.settings allowed_ips.0 10.0.0.5
drush cset monitoring_prometheus.settings custom_labels.env production
```

Or edit `monitoring_prometheus.settings.yml` and import. Defaults (from `config/install`) are empty maps
for both keys.
