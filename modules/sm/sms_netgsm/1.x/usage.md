<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Netgsm (SMS Framework) provides a Netgsm SMS gateway for the SMS Framework.

---

Netgsm (sms_netgsm) **provides a Netgsm SMS gateway** — letting the SMS Framework send text messages through
the Netgsm provider's API. It depends on the SMS Framework module and provides its own permissions.

Use it to send SMS via Netgsm. It is an SMS/integration feature. Security/data handling: it **sends message content
and recipient phone numbers (PII) to the Netgsm API** (external egress — disclose per policy) and authenticates
with **Netgsm credentials** (store as secrets — env/Key — over HTTPS; don't commit them). It has no access-control
role beyond its permission. Configure the Netgsm credentials.

---

- Provide a Netgsm SMS gateway.
- Send SMS via Netgsm.
- Extend the SMS Framework.
- Depend on the SMS Framework.
- Provide its own permissions.
- Serve SMS/integration.
- Send content + recipient numbers (PII) to Netgsm (egress; disclose).
- Store the Netgsm credentials as secrets (env/Key, HTTPS).
- Not commit the credentials.
- Have no access-control role beyond permission.
- Configure the Netgsm credentials.
- Handle Netgsm SMS.
- Send SMS.
- Configure the gateway.
- Deliver texts.
- Handle the integration.
- Send texts.
- Message users.
- Secure the credentials.
- Provide a Netgsm SMS gateway.
