<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Message GC Notify sends messages via the GC Notify (Government of Canada) service.

---

Message GC Notify **sends messages via GC Notify** — integrating the Government of Canada Notify (GC Notify)
service to send email/SMS notifications, with a Notifier plugin for Message Notify. It provides its own
permissions, in the Message package.

Use it to send notifications via GC Notify. It is a messaging/integration feature. Security/data handling: it
**sends recipient data (email/phone = PII) and message content to the GC Notify API** (egress — disclose per
privacy policy) and authenticates with a **GC Notify API key** (store as a secret — env/Key — over HTTPS). It has
no access-control role beyond its permission. Configure the GC Notify key.

---

- Send messages via GC Notify.
- Integrate the GC Notify API.
- Provide a Notifier plugin.
- Provide its own permissions.
- Serve messaging/integration.
- Send email/SMS.
- Send recipient PII + content to GC Notify (egress; disclose).
- Store the GC Notify API key as a secret (env/Key, HTTPS).
- Have no access-control role beyond permission.
- Configure the GC Notify key.
- Handle GC Notify.
- Send notifications.
- Configure the client.
- Deliver messages.
- Handle the integration.
- Notify recipients.
- Configure Message.
- Handle the sending.
- Secure the key.
- Provide GC Notify messaging.
