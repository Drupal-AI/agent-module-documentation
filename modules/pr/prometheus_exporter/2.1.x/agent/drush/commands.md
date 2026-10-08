<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush

`Drush\Commands\PrometheusExportCommand` (Symfony console `#[AsCommand]`).

| Command | Args/opts | Effect |
|---|---|---|
| `prometheus:export` | none | Runs every **enabled** collector and writes the Prometheus text exposition output to stdout. |

- Same output as the `/metrics` route but bypasses HTTP and the `access prometheus metrics`
  permission — anyone with shell/drush access gets it. Useful for cron push-gateways or debugging.
- Respects the enabled/disabled state and weights in `prometheus_exporter.settings`; disabled
  collectors produce nothing.
- Requires Drush >= 13 (composer `conflict: drush/drush <13.7`).

```bash
ddev drush prometheus:export
```
