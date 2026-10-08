<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emergency Alerts (emergency_alerts) — agent index

**Configurable site-wide emergency alert: a placeable block plus an optional full-page banner with severity levels.**

- **Version:** 8.x-2.x
- **Core:** ^8 || ^9 || ^10 || ^11 · **Package:** NewCity
- **Config route:** `emergency_alerts.settings` → `/admin/config/emergency_alerts` (permission `administer emergency_alerts`).
- **Config object:** `emergency_alerts.settings` (`alert_title`, `alert_message` rich text, `alert_level`, `override`).
- **Block:** `EmergencyAlert` plugin (place in any region, e.g. `emergency_alert`).
- **Library:** `emergency_alerts/persist_close` (dismiss + remember closed).
- **Theme:** `hook_theme` `emergency_alert`; `hook_theme_suggestions_html_alter` adds `html__emergency_alert` when `override` is on (non-admin routes only). Templates `emergency-alert.html.twig`, `html--emergency-alert.html.twig`.

**Security:** Single admin config route gated by `administer emergency_alerts`; no anonymous or mutating endpoints. The message is admin-authored rich text rendered as markup — restrict the admin permission (trusted-content XSS surface only, no user input). Override deliberately excluded from admin routes.

See [configure/settings.md](configure/settings.md)