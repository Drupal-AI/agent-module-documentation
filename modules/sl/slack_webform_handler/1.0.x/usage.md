<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Slack Webform Handler sends a Slack message when a webform is submitted.

---

Slack Webform Handler **posts to Slack on webform submission** — a Webform handler that sends a message to a
Slack channel (via an incoming webhook) when a form is submitted, for notifications. It depends on the Webform
module.

Use it to get Slack notifications for form submissions. It is an integration/notification feature. Security/data
handling: it **sends submission data to Slack** (external egress — submissions can include **PII**; only send what's
needed and disclose per policy) via a **Slack incoming-webhook URL**, which is itself a **secret** (anyone with the
URL can post to your channel) — store it as a secret (env/Key), not in committed config, and use HTTPS. It has no
access-control role. Configure the Slack webhook URL.

---

- Post to Slack on webform submit.
- Send submission notifications.
- Use a Slack incoming webhook.
- Depend on the Webform module.
- Serve integration/notification.
- Notify a Slack channel.
- Send submission data to Slack (egress; can include PII).
- Treat the Slack webhook URL as a secret (env/Key, not committed).
- Send only needed data + disclose per policy + HTTPS.
- Have no access-control role.
- Configure the Slack webhook URL.
- Handle Slack notifications.
- Notify Slack.
- Configure the handler.
- Send messages.
- Handle the integration.
- Post submissions.
- Alert Slack.
- Secure the webhook URL.
- Provide Slack webform notifications.
