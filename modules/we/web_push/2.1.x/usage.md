<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Push sends web push notifications to users, managing browser push subscriptions and dispatching notifications via VAPID.

---

Web Push sends browser push notifications to users — it manages the Web Push subscription flow
(users grant permission, the browser subscription is stored) and dispatches notifications to subscribed
users' browsers using the Web Push protocol (VAPID authentication). It depends on core REST,
Serialization and User, requires PHP 8.0, is configured at `web_push.settings`, and provides its own
permissions.

Use it to re-engage users with timely browser notifications (updates, alerts). The security-relevant
points are: the **VAPID keys** authenticate your server to the push service — store the VAPID private
key as a secret (never commit it), because it authorizes sending notifications as your origin; obtain
user consent for push (browsers require an explicit grant, and privacy/consent practice applies); and
the subscription endpoints handle user data, so ensure the REST resources are appropriately access-
controlled. Configure the VAPID keys and notification content.

---

- Send browser push notifications.
- Manage push subscriptions.
- Dispatch notifications via VAPID.
- Store the VAPID private key as a secret.
- Never commit VAPID keys.
- Depend on REST, Serialization, User.
- Require PHP 8.0.
- Configure at web_push.settings.
- Provide its own permissions.
- Obtain user consent for push.
- Re-engage users with alerts.
- Handle the subscription flow.
- Access-control the REST endpoints.
- Send timely updates.
- Authenticate to the push service.
- Protect subscription data.
- Notify subscribed browsers.
- Configure notification content.
- Manage VAPID keys.
- Send web push messages.
