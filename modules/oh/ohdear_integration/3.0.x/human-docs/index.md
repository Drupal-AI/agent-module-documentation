# Oh Dear Integration — manual setup guide

**Oh Dear Integration** (`ohdear_integration`) connects your Drupal site to the
[Oh Dear](https://ohdear.app) monitoring service, and the traffic goes both ways.

Outbound, it publishes a **health‑check endpoint** at
`/json/oh-dear-health-check-results` that reports the results of the
[Monitoring](https://www.drupal.org/project/monitoring) module's sensors in Oh
Dear's health‑check format. That means cron failures, disk pressure, database
problems, and available security updates surface in the same Oh Dear dashboard as
uptime and performance. Inbound, it pulls Oh Dear's own data — site info, broken
links, and uptime — back into the Drupal admin under **Reports**. It also supports
cron monitoring via Oh Dear's Scheduled Tasks feature, and adds Drush commands for
maintenance windows, uptime, broken links, and site info.

The health‑check endpoint is declared publicly accessible at the route level, but the
controller authenticates every caller itself: a request must present the correct
**health‑check secret** (in the `oh-dear-health-check-secret` header, matched
exactly) or hold the `monitoring reports` permission — otherwise it is refused with a
`403` and *"Access denied!"*. This was verified: anonymous requests, with or without a
wrong secret, are denied.

> **Important:** Oh Dear Integration **below 3.x is no longer compatible with the Oh
> Dear API** — this is the 3.0.x release, which you should be on. Update older
> installs promptly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the Oh
   Dear PHP SDK and the Monitoring module) and enable it.
2. [Configuration](configuration/index.md) — set the health‑check secret, configure
   monitoring sensors, and connect cron monitoring.

## Where it lives in the admin menu

- Module settings (health‑check secret): **Configuration → System → Oh Dear
  settings** (`/admin/config/system/ohdear-settings`).
- Monitoring sensors: **Configuration → System → Monitoring**
  (`/admin/config/system/monitoring/settings`).
- Oh Dear reports pulled into Drupal: **Reports → Oh Dear**
  (`/admin/reports/ohdear/{info,broken-links,uptime}/{monitor_id}`), behind the
  `access ohdear info` permission.
