<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# heartbeat.sh (heartbeat_sh) — agent index

**Sends a cron heartbeat ping to the heartbeat.sh dead-man's-switch monitoring service.**

- **Version:** 2.0.x
- **Core:** `^9 || ^10`
- **Permission:** `administer heartbeat_sh` (restrict access).
- **Configure:** `admin/config/services/heartbeat_sh/settings_form` (`heartbeat_sh.settings_form`) → `heartbeat_sh.settings` (`subdomain`, `cron_beat_name`, `warning_timeout`, `error_timeout`, `cron_enabled`).
- **Runtime:** `heartbeat_sh_cron()` → `heartbeat_sh_beat()` POSTs `https://<subdomain>.heartbeat.sh/beat/<name>` (Guzzle, default TLS on).

**Security:** Single admin-gated settings form; only a cron-triggered outbound HTTPS request (TLS verification at default = enabled). No anonymous or mutating public endpoints.