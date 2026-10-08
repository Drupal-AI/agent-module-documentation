<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Monitoring Slack sends a Slack message to an incoming-webhook URL whenever a Monitoring sensor's status transitions between runs (e.g. `OK → WARNING`), for the severities you choose.
---
It hooks `hook_monitoring_run_sensors`: for each non-cached result whose new status is in the configured `severities` and differs from the previous status, `SlackNotifier::notify()` POSTs a Slack `attachments` payload (color by status, sensor label + link, message, `old → new` status and value) to the configured `webhook_url` via Guzzle with a 5s timeout. Legacy-webhook-only overrides for `channel`, `username` and `icon_emoji` are appended when set. If Monitoring's `sensor_call_logging` is `none`, transitions cannot be detected and nothing is sent. A settings fieldset is injected into the Monitoring settings form (`monitoring.settings`), including a "Send test notification" button that posts an ad-hoc message.

The webhook URL is a secret-bearing value stored in the `monitoring_slack.settings` config object (plain config, not a Key entity) — treat it as sensitive when exporting config. The settings live behind Monitoring's own admin form (permission `administer monitoring`); there are no anonymous or mutating public endpoints, and posting is over HTTPS with default TLS verification. Setup: create a Slack incoming webhook, paste its URL on the Monitoring settings page, pick severities, and optionally send a test.
---
- Alert a Slack channel when a monitoring sensor turns critical.
- Notify on `OK → WARNING` sensor transitions.
- Choose which severities trigger a Slack post.
- Post to a specific channel via the legacy webhook channel override.
- Set a bot display name for the notifications (legacy webhooks).
- Set a bot icon emoji for the notifications (legacy webhooks).
- Send a test notification to verify a webhook before saving.
- Link each alert back to the sensor details page.
- Include the sensor value and old→new status in the message.
- Route ops alerts into a ChatOps channel.
- Skip notifications for cached sensor results.
- Disable notifications by clearing the webhook URL.
- Colour-code alerts (good/warning/danger) by status.
- Integrate site health monitoring with Slack.
- Warn admins that logging must be on for transitions to fire.
- Store the webhook URL in site configuration.
