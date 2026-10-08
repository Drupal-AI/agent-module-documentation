<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Log Alert Rules (log_alert_rules) — agent index

**Threshold-based alerting on watchdog log entries with cooldown suppression and pluggable notification channels (email + Slack/webhook submodule).**

- **Version:** 2.1.x (2.1.0) · **Core:** ^10.6 || ^11 · **Depends:** dblog · **Package:** System
- **Configure:** `entity.log_alert_rule.collection` → `/admin/config/system/log-alert-rules`.
- **Config entities:** `log_alert_rule`, `notification_target` (CRUD + enable/disable + test + import/export routes).
- **Engine:** `AlertRuleLogger` (tagged `logger`, prio 100) queues matches → `DeferredEvaluatorSubscriber` (`kernel.terminate`) → `AlertEvaluator` + `TrackingStorage` (counts + cooldown) → `log_alert_notification_channel` plugin manager. Channel: `EmailNotification`.
- **Submodules:** `log_alert_rules_webhook` (Slack/webhook; URL stored via **Key** module), `log_alert_rules_monolog` (Monolog → engine).
- **Security:** ALL routes require `administer log alert rules` (`restrict access: true`); enable/disable/toggle routes also require `_csrf_token: TRUE`. Export uses `accessCheck(TRUE)`. Webhook POST uses Guzzle default TLS (no `verify=>false`), `http_errors=>FALSE`, 5s timeout, bounded retries (`log_alert_rules_webhook/src/Notification/Plugin/WebhookNotificationBase.php:109`). No anonymous or log-disclosure endpoints; exposes alert config, not raw logs. No security findings.

See [configure/rules.md](configure/rules.md) and [plugins/channels.md](plugins/channels.md)
