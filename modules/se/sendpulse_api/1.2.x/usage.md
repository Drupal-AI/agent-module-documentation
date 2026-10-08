<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sendpulse integrates the SendPulse marketing platform (email, SMS, push) via API.

---

Sendpulse **integrates the SendPulse platform** — managing email, SMS and push-notification marketing through
SendPulse's API from Drupal. It provides its own permissions, in the Sendpulse package.

Use it to send campaigns via SendPulse. It is an integration/marketing feature. Security/data handling: it **sends
contact data (PII) and messages to the SendPulse API** (external egress — disclose per privacy policy) and
authenticates with **SendPulse API credentials** (store as secrets — env/Key — over HTTPS). It has no access-control
role beyond its permission. Configure the SendPulse credentials.

---

- Integrate SendPulse.
- Manage email/SMS/push.
- Send campaigns via the API.
- Provide its own permissions.
- Serve integration/marketing.
- Use the SendPulse API.
- Send contact PII + messages to SendPulse (egress; disclose).
- Store the API credentials as secrets (env/Key, HTTPS).
- Have no access-control role beyond permission.
- Configure the SendPulse credentials.
- Handle SendPulse.
- Send campaigns.
- Configure the client.
- Send messages.
- Handle the integration.
- Manage marketing.
- Feed the platform.
- Secure the credentials.
- Provide SendPulse integration.
