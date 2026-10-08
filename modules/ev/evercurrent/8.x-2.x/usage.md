<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reports a Drupal site's available core, module, theme and profile updates to the external Evercurrent dashboard at app.evercurrent.io on cron.

---

Evercurrent is a monitoring-integration module (depends on core `update`) that pushes update status to the Evercurrent service so you can track pending updates for many sites from one dashboard and receive email alerts. On each cron run, when sending is enabled and the configured interval has elapsed, the `evercurrent.update_helper` service (`UpdateHelper::sendUpdates()`) calls Drupal's Update Manager (`update_get_available()` / `update_calculate_project_data()`), then POSTs the results — along with the list of enabled modules and themes, the installation profile, the site's base URL, and the site's API key — as JSON to `<target_address>/evercurrent/post-update`. The API key is a 32-character hexadecimal string obtained from the Evercurrent server; it is stored in the `evercurrent.admin_config` config object, or (recommended for multi-environment setups) in `settings.php` as `$config['evercurrent_environment_token']`. The settings form lives at `/admin/config/evercurrent` behind the `access evercurrent settings` permission, and the module contributes status entries to Drupal's status report page (`hook_requirements`). An optional listening mode exposes `/api/rmc/key` so the server can supply the API key to the site.

---

- Report a single Drupal site's available updates to the Evercurrent dashboard automatically on cron.
- Centralise update tracking for many Drupal sites in one Evercurrent account.
- Receive email notifications from Evercurrent when a security update is released for an installed project.
- See existing vs. recommended versions for outdated modules, themes and core on the dashboard.
- Send the list of enabled modules and themes so the dashboard can distinguish installed from available projects.
- Include installation-profile update status when the profile is tracked by the Update Manager.
- Configure the site's Evercurrent API key on the settings form at `/admin/config/evercurrent`.
- Store the API key in `settings.php` (`$config['evercurrent_environment_token']`) so only production reports and dev/stage stay silent.
- Override a settings.php-provided key from the UI using the "Override API key stored in settings.php" checkbox when needed.
- Pin the reporting environment URL with `$config['evercurrent_environment_url']` when `$base_url` is not reliably set (for example under Drush cron).
- Throttle how often reports are sent (every cron run, hourly, every 12 hours, or daily) when cron runs frequently.
- Temporarily stop reporting by unchecking "Enable sending update reports" without uninstalling the module.
- Trigger an immediate test report from the settings form via "Send update report when saving configuration".
- Point the module at a self-hosted or alternate Evercurrent endpoint by changing the "Server URL" field.
- Let the Evercurrent server deliver the API key to the site automatically via listening mode instead of pasting it manually.
- Monitor the last successful report time and runtime status from the site's status report page (`/admin/reports/status`).
- Log server-side reporting errors to Drupal's logger (channel `evercurrent`) for later review.
- Send an update report programmatically from custom code via the `evercurrent.update_helper` service.
- Add extra fields to the reported payload from another module using `hook_evercurrent_update_data_alter()`.
- Manage update reporting for multiple environments (dev, stage, production) by keying each to a different Evercurrent site.
- Reduce reliance on Drupal's per-site update emails by aggregating status in one external dashboard.
- Keep a lightweight, dependency-free reporting agent on production sites that only needs the core `update` module.
