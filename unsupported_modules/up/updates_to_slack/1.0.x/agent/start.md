<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Updates to slack (updates_to_slack) — agent index
**Cron job that posts pending Drupal update status to a Slack incoming webhook.**

- **Version:** 1.0.x (dev checkout, composer.lock `dev-1.0.x`)
- **Core:** ^10 || ^11
- **Configure:** `updates_to_slack.admin_settings` — `/admin/config/systems/updates-to-slack`
- **Permission:** `administer updates to slack` (`restrict access: TRUE`).
- **Service:** `updates_to_slack` (`UpdatesToSlackController`) — args `config.factory`, `http_client`, `logger.factory`.
- **Cron:** `updates_to_slack_cron()` gates sends by `last_run` vs `cron_duration` (default 86400s).
- **Security:** Only web surface is the admin-only settings form. `getUpdates()` uses `extract()` on `update_calculate_project_data()` output — trusted, locally-computed update-status data, not request input (below bar). Webhook URL stored plaintext in config; outbound POST only.

See [configure/settings.md](configure/settings.md)
