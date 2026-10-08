# Drush commands

Provided by `Drupal\ohdear_integration\Drush\Commands\OhdearIntegrationCommands`
(Drush 11+). Every command calls the Oh Dear API, so a valid API key and monitor id must
be configured (see [../configure/settings.md](../configure/settings.md)). The optional
`monitorId` argument defaults to the configured monitor but lets you target another site
reachable with the same API key.

| Command | Aliases | Purpose |
|---|---|---|
| `ohdear:maintenance` | `ohdear-maintenance`, `ohdear-m`, `ohdear:m` | List / start / stop Oh Dear maintenance windows |
| `ohdear:info [monitorId]` | `ohdear-info`, `ohdear-i`, `ohdear:i` | Print monitor id, url and summarized check result |
| `ohdear:broken-links [monitorId]` | `ohdear-broken-links`, `ohdear-bl`, `ohdear:bl` | List broken links found by Oh Dear |
| `ohdear:uptime [monitorId]` | `ohdear-uptime`, `ohdear-u`, `ohdear:u` | Daily uptime % (last 7 days by default) |

## `ohdear:maintenance` options
- `--start` / `--stop` — start or stop a maintenance window (mutually exclusive; using both warns and aborts).
- `--with-drupal` — also toggle Drupal's `system.maintenance_mode` state (on with `--start`, off with `--stop`).
- `--time-length=<seconds>` — window length (default 3600).
- `--label=<text>` — window label.
- `--number=<n>` — how many recent windows to list (default 5).

Example: `drush ohdear:maintenance --start --label="Deploy XYZ" --time-length=900`.
With neither `--start` nor `--stop`, it just lists the recent windows.

## `ohdear:info` options
- `--checks` — also print the site's health checks.
- `--list-sites` — list all monitor ids/labels available to the API key.

## `ohdear:uptime` options
- `--from` / `--to` — range in `Y-m-d H:i:s` format.
- `--split=hour|day|month` — bucket size (default `day`).
