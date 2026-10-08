Threshold-based alert rules for API Orchestrator that watch request metrics over a time window and notify Slack/Discord (and the Drupal log) with per-alert severity and cooldowns.

---

The Alerts submodule adds an `api_orchestrator_alert` config entity that defines an alerting rule: an alert type (error rate, average duration, no-requests, success-rate drop), a threshold value + operator, a time window, optional service/endpoint scope, severity (info/warning/critical), a cooldown period, and enabled notification channels. On cron, `AlertMonitoringService` evaluates every active alert using `AlertMetricsCalculator` (parameterized aggregate SQL over the request table); when a threshold is breached it dispatches through `AlertNotificationService` to the built-in Drupal log plus pluggable `AlertChannel` plugins — Slack and Discord webhooks ship in-box, both with token-aware config (`{{env:…}}` webhook URLs) and full alert-context message fields. Alerts are managed at `/admin/config/services/api-orchestrator/alerts`; a CSRF-protected POST API can evaluate or clear active alerts on demand. Requires `api_orchestrator`.

---

- Alert when a service's error rate exceeds a percentage over the last N minutes.
- Alert when average response duration rises above a millisecond threshold.
- Alert when no requests have been recorded for a service in a time window (dead-integration detection).
- Alert on a drop in success rate below a target percentage.
- Scope an alert to a specific service and/or endpoint, or leave it global.
- Assign severity (info/warning/critical) that maps to Slack/Discord colors and Drupal log levels.
- Suppress repeat noise with a per-alert cooldown period.
- Route alerts to Slack incoming webhooks with mentions and detail fields.
- Route alerts to Discord webhooks with rich embeds and role/user mentions.
- Always mirror alerts to the Drupal log (watchdog) at a matching severity.
- Keep webhook URLs out of config using `{{env:SLACK_WEBHOOK_URL}}` / `{{state:…}}` tokens.
- Trigger a full alert evaluation on demand via the CSRF-protected evaluate endpoint.
- Clear a single active alert or all active alerts via the POST API.
- Send a test message to verify a channel's webhook configuration.
- Add custom alert channels by implementing the `AlertChannel` plugin.
