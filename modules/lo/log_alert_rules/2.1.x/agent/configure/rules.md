<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Log Alert Rules

## Where (all require `administer log alert rules`)
- Rules: `/admin/config/system/log-alert-rules` (`entity.log_alert_rule.collection`).
- Add/edit/delete/test/export a rule via the entity routes; single export at `/{log_alert_rule}/export`.
- Enable/disable: `/{log_alert_rule}/enable` and `/disable` — **CSRF-token protected** (`_csrf_token: TRUE`).
- Bulk export/import: `/export`, `/import`.
- Notification targets: `/admin/config/system/log-alert-rules/targets` (CRUD + enable/disable, CSRF-protected toggles).

## How evaluation works
1. `AlertRuleLogger` (service `log_alert_rules.logger`, tagged `logger`, priority 100) sees each watchdog entry and queues matches. It **must not** depend on anything that depends on `logger.factory` (circular-reference constraint documented in `services.yml`), so it only queues.
2. `DeferredEvaluatorSubscriber` drains the queue at `kernel.terminate` (after the response is sent).
3. `AlertEvaluator` counts occurrences via `TrackingStorage`, applies the per-rule cooldown, and dispatches to enabled notification targets.
4. `RuleValidator` validates definitions; `ContextVariableSanitizer` sanitises log context used in messages.

## Import/export
`AlertRuleTransferController` returns a `text/yaml` attachment download (bulk or single); import is the permission-gated `AlertRuleImportForm`. `AlertRuleTransferManager` does the (de)serialisation; the load query uses `accessCheck(TRUE)`.
