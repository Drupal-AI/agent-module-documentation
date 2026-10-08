<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notifier integrates the Symfony Notifier component with Drupal.

---

Notifier integrates the **Symfony Notifier** component with Drupal — sending notifications over multiple
channels (SMS, chat/Slack/Telegram, email, push) through Notifier's transports. It requires PHP 8.3.

Use it to send multi-channel notifications. It is an integration/notifications feature. Security/data handling:
notification channels use **transport credentials** (SMS/chat provider API keys/DSNs) — store those as
**secrets** (env/Key), use HTTPS/secure DSNs — and notifications may carry user data (recipients, content), so
mind what you send and to where. It has no access-control role. Configure the Notifier channels/transports.

---

- Integrate Symfony Notifier.
- Send multi-channel notifications.
- Support SMS/chat/email/push.
- Require PHP 8.3.
- Use Notifier transports.
- Serve notifications.
- Store transport credentials as secrets.
- Use secure DSNs/HTTPS.
- Mind what notifications carry.
- Have no access-control role.
- Configure the channels/transports.
- Handle notifications.
- Send notifications.
- Configure Notifier.
- Notify users.
- Handle the integration.
- Send messages.
- Configure channels.
- Secure the credentials.
- Provide multi-channel notifications.
