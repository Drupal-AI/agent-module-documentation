<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Updates to slack sends a formatted summary of pending Drupal core and contrib updates to a Slack incoming webhook on a configurable cron interval.
---
On cron, `updates_to_slack_cron()` checks the stored `last_run` against a configurable `cron_duration` (default 86400s) and, when due, calls the `updates_to_slack` service. That controller reads Drupal's update status (`update_get_available(TRUE)` + `update_calculate_project_data()`), builds Slack Block Kit blocks marking security (🔴), minor (🟠) and unavailable (⚫) updates, and POSTs the JSON payload to the configured incoming-webhook URL via the core `http_client`. Link markup is converted to Slack link syntax and other HTML stripped.

The admin form at `/admin/config/systems/updates-to-slack` (permission `administer updates to slack`, `restrict access: TRUE`) stores the webhook URL, channel, bot username, and icon settings in `updates_to_slack.settings`. The controller uses PHP `extract()` on `update_calculate_project_data()` output and per-project arrays — this operates on trusted, locally-computed update-status data, not on request input, and the only web-facing route is the admin-only settings form. The webhook URL is a secret stored in config (plaintext) and used for outbound POST only.

Typical setup: create a Slack incoming webhook, enter its URL and channel on the settings form, set the notification interval, and let cron deliver periodic update digests.
---
- Notify a Slack channel when security updates are available.
- Post a periodic digest of pending module updates.
- Configure the incoming-webhook URL on the settings form.
- Set the default Slack channel (e.g. `#drupal-updates`).
- Choose the bot display name for the messages.
- Pick an emoji or image icon for the bot.
- Tune the notification frequency via `cron_duration`.
- Reset `last_run` to force the next cron to send.
- Highlight security vs minor updates with colour emojis.
- Include the site name in the Slack message header.
- Route messages to a private channel or DM.
- Skip notifications when everything is up to date.
- Integrate update monitoring into a team Slack workspace.
- Rely on core update status data (no extra fetching config).
- Restrict the settings permission to administrators only.
- Send an ad-hoc update summary by triggering cron.
