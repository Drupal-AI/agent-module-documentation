<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Monitoring Slack

The settings are added to the Monitoring settings form at `/admin/config/system/monitoring` (permission `administer monitoring`). Config object `monitoring_slack.settings`:

| Key | Notes |
|---|---|
| `webhook_url` | Slack incoming webhook (required to send). Stored in plain config — treat as a secret. |
| `severities` | Sequence of status labels that trigger a post. |
| `channel` / `username` / `icon_emoji` | Optional overrides — honored only by *legacy* webhooks; modern Slack-App webhooks ignore them. |

Behaviour:
- `MonitoringSlackHooks::monitoringRunSensors()` skips cached results, only fires when the new status is in `severities` and differs from the previous status, and does nothing if `monitoring.settings` `sensor_call_logging === 'none'`.
- `SlackNotifier::notify()` / `sendTest()` POST to the webhook via Guzzle (`timeout: 5`), logging failures to the `monitoring_slack` channel.
- The **Send test notification** button posts using the current (unsaved) form values.

```bash
drush cset monitoring_slack.settings webhook_url 'https://hooks.slack.com/services/T.../B.../...' -y
```
