<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Slack integrates Drupal with Slack.com via an Incoming Webhook: configure a webhook URL, default channel, bot name and icon, then send messages to Slack from code, from the Rules module, or through a queue.

---

The module posts messages to Slack using an **Incoming Webhook** URL you create in Slack and store in Drupal. Configuration lives in the `slack.settings` config object, edited at *Configuration → Services → Slack → Configuration* (`/admin/config/services/slack/config`, route `slack.admin_settings`, permission `administer site configuration`): the `slack_webhook_url`, a default `slack_channel` (e.g. `#general` or `@user`), the bot `slack_username`, an icon (`slack_icon_type` none/emoji/url with `slack_icon_emoji`/`slack_icon_url`), `slack_link_names`, and `slack_queue_messages` to send asynchronously. A **"Send a test message"** form (`/admin/config/services/slack/test`) verifies the setup. Programmatic sending goes through the `slack.slack_service` service (`Slack`/`SlackInterface`): `deliverMessage()` (respects the queue setting), `sendMessage()` (posts immediately via the webhook), and `queueMessage()` (enqueues to the `slack_message` queue worker, processed on cron). Each method accepts an optional per-call channel, username and webhook URL to override the defaults. The module also ships a Rules action `rules_slack_send_message` ("Send message to Slack", category Slack) so site builders can post to Slack from Rules reactions without code (dev dependency `drupal/rules`). It defines no permissions of its own, no Drush commands, and no plugin types; the webhook URL is required for anything to be delivered.

---

- Post a notification to a Slack channel when new content is published.
- Send an alert to `#ops` when a form submission or error occurs.
- Notify a team channel from custom code via the `slack.slack_service` service.
- Queue Slack messages so they are sent asynchronously on cron instead of during the request.
- Send an immediate Slack message with `sendMessage()` bypassing the queue.
- Override the default channel per message (e.g. route errors to `#alerts`).
- Send a direct message to a user with `@username` as the channel.
- Post as a custom bot name and emoji/icon per the configured defaults.
- Use the Rules action "Send message to Slack" to notify Slack without writing code.
- Verify the integration with the built-in "Send a test message" form.
- Alert editors in Slack when a node moves to a moderation state (via Rules).
- Send build/deploy or cron completion notices to a Slack channel.
- Notify a sales channel when a commerce order is placed (from custom code).
- Route different event types to different channels using per-call overrides.
- Link @-names/#-channels in messages with the link-names option.
- Centralize Slack credentials in one webhook config used site-wide.
- Send moderation or spam alerts to a private Slack group.
- Post user-registration notifications to an onboarding channel.
- Use a secondary webhook URL for a specific message by passing it per call.
- Throttle bursts of notifications by enabling message queueing.
- Send scheduled digest messages from a custom cron hook.
- Integrate Slack alerts into an existing Rules-based workflow.
- Notify support staff in Slack when a contact form is submitted.
- Broadcast site-status or maintenance notices to a team channel.
- Test channel/username/icon settings before wiring up automated messages.
