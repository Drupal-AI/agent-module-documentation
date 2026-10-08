<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Adyen CC provides Commerce integration with Adyen.

---

Commerce Adyen (Credit Card) provides a **Drupal Commerce payment gateway for Adyen** — accepting card
payments through the Adyen payment platform. It depends on Commerce, in the Commerce (contrib) package.

Use it to accept Adyen card payments. It is an e-commerce/payment feature. Trust boundary: ensure payment
outcomes are **confirmed server-side with Adyen** (via Adyen's API and, for asynchronous results, its
**signed/HMAC notification webhooks** — Adyen signs notifications; verify the HMAC before acting) rather than
trusting a client return, and handle the Adyen **API key/HMAC key** as secrets over HTTPS. (This is a dev
release — review the gateway's notification/verification flow for your version.) It has no access-control role.
Configure the Adyen credentials.

---

- Accept Adyen card payments.
- Use the Adyen platform.
- Confirm outcomes server-side with Adyen.
- Verify Adyen's signed/HMAC notifications.
- NOT trust a client return.
- Depend on Commerce.
- Store the Adyen API/HMAC key as secrets.
- Use HTTPS.
- Review the notification/verification flow.
- Have no access-control role.
- Configure the Adyen credentials.
- Handle Adyen payments.
- Verify payments.
- Configure the gateway.
- Process payments.
- Confirm via API/webhook.
- Handle the integration.
- Take card payments.
- Secure the credentials.
- Provide Adyen payment.
