<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Updates to slack — configuration

**Settings form:** `/admin/config/systems/updates-to-slack`
(`SettingsForm`, permission `administer updates to slack`, restrict access).

Config object `updates_to_slack.settings`:
- `slack_webhook_url` (required) — Slack incoming-webhook URL (stored plaintext).
- `slack_channel` — default channel (`#name`, `@user`, or private group).
- `slack_username` — bot display name.
- `slack_icon_type` — `emoji` or `image`.
- `slack_icon_emoji` / `slack_icon_url` — icon per the chosen type.
- `cron_duration` — seconds between notifications (default 86400).
- `last_run` — internal timestamp of the last send.

**Delivery:** on cron, when `now - last_run >= cron_duration`, the module builds
Block Kit blocks from core update status and POSTs them to the webhook via
`http_client`. Force an immediate send by clearing/resetting `last_run` and
running cron.
