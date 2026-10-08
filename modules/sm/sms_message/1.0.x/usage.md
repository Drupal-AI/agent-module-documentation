<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS Message is an SMS API module.

---

SMS Message is an **SMS API module for sending text messages** — a service/API layer to send SMS via a
gateway, usable by other modules (notifications, OTP, alerts). It depends on core Telephone, provides its own
permissions, in the Custom package.

Use it as the SMS-sending layer for other features. It is an integration/messaging feature. Security/data
handling: it sends messages through an **SMS gateway** — store the gateway **API credentials** as **secrets**
(env/Key) over HTTPS, and because SMS sending **costs money and can be abused** (spam/bombing), gate its
permission to trusted code/roles and rate-limit senders. Phone numbers are personal data. It has no
access-control role beyond its permission. Configure the SMS gateway.

---

- Send SMS text messages.
- Provide an SMS API layer.
- Serve notifications/OTP/alerts.
- Depend on core Telephone.
- Provide its own permissions.
- Send via a gateway.
- Store gateway credentials as secrets over HTTPS.
- KNOW SMS costs money + can be abused.
- Gate the permission + rate-limit senders.
- Treat phone numbers as personal data.
- Have no access-control role beyond permission.
- Configure the SMS gateway.
- Handle SMS sending.
- Send SMS.
- Configure the gateway.
- Send messages.
- Handle the API.
- Text users.
- Secure the credentials.
- Provide SMS sending.
