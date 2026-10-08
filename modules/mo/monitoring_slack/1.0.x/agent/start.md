<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monitoring Slack (monitoring_slack) — agent index

**Posts Monitoring sensor status-change notifications to a Slack incoming webhook.**

- **Version:** 1.0.x (1.0.0-alpha2)
- **Core:** ^10.6 || ^11
- **Depends:** monitoring
- **Config route:** `monitoring.settings` (Slack fieldset injected via `hook_form_monitoring_settings_alter`), permission `administer monitoring`.
- **Config:** `monitoring_slack.settings` (`webhook_url`, `severities`, `channel`, `username`, `icon_emoji`).
- **Service:** `SlackNotifier` (Guzzle POST, 5s timeout). Trigger: `hook_monitoring_run_sensors`.
- **Security:** admin-gated via Monitoring's settings form; no anonymous/mutating endpoints; posts over HTTPS (default TLS verify). Webhook URL stored in **plain config** (`monitoring_slack.settings`) — sensitive on config export.

See [configure/settings.md](configure/settings.md).
