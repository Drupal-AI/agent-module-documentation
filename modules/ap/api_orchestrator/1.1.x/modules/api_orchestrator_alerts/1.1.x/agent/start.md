<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Alerts (api_orchestrator_alerts) — agent index

Threshold alerting for API Orchestrator request metrics. Depends on `api_orchestrator`. All routes require `administer api orchestrator`.

## Provides
- Config entity `api_orchestrator_alert` (`ApiAlert`, config_prefix `api_orchestrator_alert`, schema in `config/schema/api_orchestrator_alerts.schema.yml`): `alert_type`, `service_id`, `endpoint_id`, `threshold_value`, `threshold_operator`, `time_window`, `cooldown_period`, `notification_channels`, `severity`, `last_triggered`, `trigger_count`. Alert types: error rate, avg duration, no-requests, success-rate drop. Severities `SEVERITY_INFO|WARNING|CRITICAL`. Form `ApiAlertForm`, list builder `ApiAlertListBuilder`.
- Plugin type **AlertChannel** (`Attribute\AlertChannel`, manager `plugin.manager.api_orchestrator_alert_channel`, base `AlertChannelBase`): `SlackAlertChannel` (id `slack`), `DiscordAlertChannel` (id `discord`). Base provides `sendWebhook()` (Guzzle, `WEBHOOK_TIMEOUT=10`, TLS on), token replacement (`{{env:}}/{{config:}}/{{state:}}` + alert-context tokens), `buildAlertContext()`.
- Services: `api_orchestrator.alert_monitoring` (`AlertMonitoringService` — evaluate/clear), `api_orchestrator.alert_notification` (`AlertNotificationService` — log + channel dispatch), `api_orchestrator.alert_metrics_calculator` (`AlertMetricsCalculator` — parameterized SQL).
- `ApiOrchestratorAlertsHooks::hook_cron()` evaluates active alerts (state `api_orchestrator.last_alert_check`).

## Routes (`api_orchestrator_alerts.routing.yml`)
- Alert CRUD: `entity.api_orchestrator_alert.collection|add_form|edit_form|delete_form` under `/admin/config/services/api-orchestrator/alerts`.
- POST APIs (CSRF-protected via `CsrfProtectionTrait`, `AlertController`): `…/alerts/evaluate`, `…/alerts/{alert_id}/clear`, `…/alerts/clear-all`.

Add a channel: implement `AlertChannelInterface` (extend `AlertChannelBase`) with the `#[AlertChannel]` attribute and `getConfigurationFields()` + `sendAlert()`.
