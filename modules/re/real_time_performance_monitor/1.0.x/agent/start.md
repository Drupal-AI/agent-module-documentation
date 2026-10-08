<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Real-time Performance Monitor (real_time_performance_monitor) — agent index
**Monitors SQL/duplicate-query/PHP/frontend metrics with per-URL-throttled watchdog, email and Slack alerts.**

- **Version:** 1.0.x  **Core:** ^9 || ^10 || ^11  (module machine name `realtime_performance_monitor`)
- **Config route:** `realtime_performance_monitor.config_form` (`/admin/config/development/real-time-performance-monitor`) — perm `administer site configuration`.
- **Telemetry route:** `/api/real-time-performance-monitor/telemetry` — `_access: 'TRUE'` (anonymous), handled by `MonitorConfigForm::handleTelemetry`.
- **Backend:** `PerformanceMonitorSubscriber`. **Alerts:** watchdog / email (`hook_mail`) / Slack webhook, throttled via `State`.
- **Security:** config form is permission-gated. The telemetry endpoint is intentionally anonymous and interpolates client-supplied JSON (`url`, `browser`, `os`, …) into an HTML alert body written to dblog and emailed/Slacked to admins — see start note; treat those alerts as untrusted input. Reported to caller.
