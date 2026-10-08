<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Mattermost posts webform submissions to a Mattermost channel via webhook.

---

Webform Mattermost provides a Webform handler for posting messages to Mattermost — so when a webform is submitted, a configurable message is sent to a Mattermost channel (via an incoming webhook), useful for notifying teams of new submissions in their chat.

The Mattermost webhook URL is a secret and should be stored securely (env-backed), never committed. Depends on `webform`; supports Drupal 8 through 11.

---

- Post submissions to Mattermost.
- Provide a Webform handler.
- Notify a Mattermost channel.
- Use an incoming webhook.
- Alert teams of new submissions.
- Store the webhook URL securely.
- Keep the webhook env-backed.
- Never commit the webhook.
- Depend on `webform`.
- Support Drupal 8 through 11.
- Configure the message.
- Integrate Mattermost.
- Send chat notifications
- Handle submissions
- Support team awareness.
- Post to chat.
- Notify on submit.
- Integrate Webform
