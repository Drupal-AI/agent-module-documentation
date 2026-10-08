<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NoFraud provides the NoFraud service integration.

---

NoFraud **integrates the NoFraud fraud-screening service with Drupal Commerce** — sending order/payment
details to NoFraud for fraud scoring/decisioning, so risky orders can be flagged/held. It depends on Commerce
Payment, in the Commerce package.

Use it to add fraud screening to checkout. It is an e-commerce/security integration. Security/data handling: it
**sends order and customer/payment details (PII) to the NoFraud API** (external egress — disclose per your
privacy policy) and authenticates with a **NoFraud API key** (store as a **secret** — env/Key — over HTTPS). The
fraud decision affects order processing, so treat NoFraud as a trusted integration and verify the flow. It has
no access-control role. Configure the NoFraud credentials.

---

- Integrate NoFraud fraud screening.
- Score orders for fraud.
- Flag/hold risky orders.
- Depend on Commerce Payment.
- Serve e-commerce security.
- Screen checkout.
- Send order/customer/payment PII to NoFraud (egress).
- Disclose it per privacy policy.
- Store the NoFraud API key as a secret over HTTPS.
- Treat NoFraud as a trusted integration.
- Have no access-control role.
- Configure the NoFraud credentials.
- Handle fraud screening.
- Score orders.
- Configure the integration.
- Screen orders.
- Handle the integration.
- Detect fraud.
- Secure the key.
- Provide fraud screening.
