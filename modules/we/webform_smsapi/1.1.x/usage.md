<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform SMSAPI sends SMS from webform submissions via the SMSAPI module.

---

Webform SMSAPI **sends SMS on webform submission** — a webform handler that sends text messages (e.g.
notifications/confirmations) via the SMSAPI module/service when a form is submitted. It depends on the Webform and
SMSAPI modules.

Use it to send SMS from webforms. It is a webform/integration feature. Security/data handling: it **sends recipient
phone numbers (PII) and message content to the SMSAPI service** (egress — disclose per privacy policy) and relies on
the SMSAPI module for **credentials** (store as secrets — env/Key — over HTTPS). It has no access-control role.
Configure the SMS handler.

---

- Send SMS on webform submit.
- Use the SMSAPI service.
- Send notifications/confirmations.
- Depend on Webform + SMSAPI.
- Serve webform/integration.
- Deliver SMS.
- Send recipient phone numbers (PII) + content to SMSAPI (egress; disclose).
- Store SMSAPI credentials as secrets (env/Key, HTTPS).
- Have no access-control role.
- Configure the SMS handler.
- Handle webform SMS.
- Send SMS.
- Configure the handler.
- Deliver texts.
- Handle the integration.
- Message recipients.
- Configure Webform.
- Handle the sending.
- Secure the credentials.
- Provide webform SMS.
