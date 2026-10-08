<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
heartbeat.sh sends a periodic cron heartbeat ping to the heartbeat.sh dead-man's-switch monitoring service.

---

heartbeat.sh integration pings the external heartbeat.sh dead-man's-switch service on every Drupal cron run, so heartbeat.sh raises an alert if the site's cron stops firing.

A settings form at `admin/config/services/heartbeat_sh/settings_form` (`administer heartbeat_sh`) is generated dynamically from the config schema and stores the account `subdomain`, a `cron_beat_name`, optional `warning_timeout`/`error_timeout`, and a `cron_enabled` toggle in `heartbeat_sh.settings`. On cron, `heartbeat_sh_cron()` (when enabled) calls `heartbeat_sh_beat()` which POSTs to `https://<subdomain>.heartbeat.sh/beat/<name>` with the timeouts as query parameters over HTTPS (default TLS verification) and logs the response.

Setup: create a beat on heartbeat.sh, enter the subdomain and beat name, enable cron beats, and ensure Drupal cron runs on a schedule. It has no public endpoints — only the admin form and a cron-triggered outbound request.

---
- Alert when Drupal cron stops running.
- Ping heartbeat.sh on every cron run.
- Configure the heartbeat.sh account subdomain.
- Set the beat name to signal.
- Set warning and error timeouts for the beat.
- Enable or disable cron beats with a toggle.
- Monitor site liveness via a dead-man's switch.
- Log the heartbeat response for debugging.
- Integrate uptime monitoring without extra infrastructure.
- Detect a stalled cron queue.
- Signal a scheduled job's health.
- Use per-environment beat names.
- Send timeouts as query parameters.
- Gate monitoring behind an admin permission.
- Confirm cron execution externally.
- Trigger escalation when beats stop.