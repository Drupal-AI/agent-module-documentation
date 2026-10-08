<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cron Timing (cron_timing) — agent index
**Adds custom automatic-cron interval options (in seconds) to core's Cron settings dropdown.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Configure route:** `cron_timing.cron_timing` → `/admin/config/system/cron_timing` (permission: `access administration pages`).
- **Config:** `cron_timing.crontiming:cron_timing` — comma-separated seconds (default `300,900`); validated by regex `^[0-9]+(,[0-9]+)*$`.
- **Mechanism:** `hook_form_alter` merges the values into the `system_cron_settings` interval select.

**Security:** Single admin config form, permission-gated; input strictly validated to digits/commas; no anonymous, mutating, or web-service endpoints.