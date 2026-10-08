<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Log Alert Rules watches Drupal's watchdog (dblog) log stream and fires notifications when configurable thresholds are crossed, with cooldown suppression and pluggable delivery channels.

---

Administrators define `log_alert_rule` config entities (severity/channel/message criteria and a count threshold over a time window) and `notification_target` config entities at `/admin/config/system/log-alert-rules`; rules can be enabled/disabled, tested, and imported/exported as YAML. A custom logger, `AlertRuleLogger` (tagged `logger`, priority 100), captures matching entries; because a service on `logger.factory` must not depend on it transitively, evaluation is deferred: matched work is queued and drained by `DeferredEvaluatorSubscriber` at `kernel.terminate`, where `AlertEvaluator` counts occurrences via `TrackingStorage`, applies the cooldown, and dispatches through the `log_alert_notification_channel` plugin manager. The base module ships an `EmailNotification` channel; a `ContextVariableSanitizer` and `RuleValidator` sanitise/validate rule context and definitions. Two submodules extend it: `log_alert_rules_webhook` (Slack and generic webhook channels, posting to a URL **stored via the Key module**) and `log_alert_rules_monolog` (routes Monolog records into the alerting engine).

Security posture: every route requires the `administer log alert rules` permission (`restrict access: true`), and all state-changing toggle routes (enable/disable for rules and targets) additionally require a CSRF token. Export produces a YAML download and import is a permission-gated form; the entity query in export uses `accessCheck(TRUE)`. The webhook channel posts alert payloads with Guzzle defaults (TLS verification enabled — no `verify => false`), `http_errors => FALSE`, a 5s timeout and bounded retries, and stores the destination URL as a Key entity rather than plaintext config. No anonymous, unauthenticated, or log-disclosure endpoints were found — the module exposes alert *configuration*, not raw log contents, to permitted admins only.

---
- Alert when errors of a given severity exceed a threshold.
- Watch a specific log channel for a burst of messages.
- Suppress repeat alerts with a cooldown window.
- Send alert emails to an operations address.
- Post alerts to a Slack incoming webhook (submodule).
- Post alerts to a generic webhook endpoint (submodule).
- Store the webhook URL securely via the Key module.
- Route Monolog log records into the alerting engine (submodule).
- Create, edit, and delete alert rules in the admin UI.
- Enable or disable a rule (CSRF-protected toggle).
- Test a rule to preview whether it would fire.
- Export alert rules as YAML for deployment.
- Import alert rules from a YAML file.
- Export a single rule for sharing.
- Manage reusable notification targets.
- Enable/disable notification targets.
- Restrict all alert management to trusted admins.
- Tune per-rule count thresholds and time windows.
- Sanitise log context variables before notifying.
- Validate rule definitions before saving.
- Monitor a production site for spikes in warnings/errors.
- Integrate log alerting into an incident-response workflow.
- Add a custom notification channel plugin.
