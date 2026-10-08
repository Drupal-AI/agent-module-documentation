<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Watches available disk space on the server filesystem and warns when it falls below a threshold.
- Runs automatically on cron and can also be checked on demand from an admin page.
- Sends notifications and surfaces current usage in the admin UI so admins can act before the disk fills.

---

## Install & configure

- Enable the module (depends on core `system` and `user`).
- Configure at `/admin/config/system/disk-space-alert` (route `disk_space_alert.settings`, permission `administer site configuration`): set threshold and notification options.
- View current status at `/admin/disk-space`; trigger an immediate check at `/admin/config/system/disk-space-alert/manual-check`.

---

## Usage & behaviour

- Cron handler (`Drupal\disk_space_alert\Cron\DiskSpaceAlertCron`) evaluates disk usage on each cron run.
- The core measurement service (`DiskSpaceAlertService`) uses PHP `disk_free_space()` / `disk_total_space()` on the site path.
- Three routes exist, all gated by `administer site configuration`: status endpoint, settings form, and manual check.
- The module ships a `permissions.yml`, so custom permissions may exist in addition to the core gate; review before delegating access.
- Notifications are typically emailed to the site admin address and written to the log channel.
- Threshold is configured as a percentage or size; crossing it triggers the alert on the next check.
- Use it on VPS / container hosts where a full disk would take the site (or database) down.
- The manual-check route is useful after clearing logs or files to confirm recovered space.
- The `/admin/disk-space` report is a quick dashboard tile for ops staff.
- No external services are contacted; all measurement is local.
- Combine with a real infra monitor (Nagios/Datadog) — this is a lightweight in-Drupal safety net, not a replacement.
- Alerts are rate-limited by cron frequency; tune cron so you are not spammed.
- Safe to run on multisite; each site measures its own filesystem view.
- Disabling the module stops checks and removes the routes.
- Keep the threshold well above zero so you get warned with time to act.
- Review who holds `administer site configuration` since that grants access to the settings and check endpoints.
