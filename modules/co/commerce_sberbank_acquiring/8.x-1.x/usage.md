<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sberbank Acquiring provides a payment gateway for Sberbank Acquiring.

---

Sberbank Acquiring provides a Drupal Commerce payment gateway for Sberbank's acquiring service — so a
store can process card payments through Sberbank (register order + confirm payment via Sberbank's API). It
depends on Drupal Commerce, in the Commerce package.

Use it to accept Sberbank Acquiring payments. Security notes: store the Sberbank **API credentials
(username/password or token) as secrets**, operate over HTTPS, and confirm the payment status by querying
Sberbank's authenticated API server-side (server-authoritative) rather than trusting a client return.
Confirm test vs live mode. It is an e-commerce/payment feature. Configure the Sberbank credentials.

---

- Provide a Sberbank Acquiring gateway.
- Process card payments via Sberbank.
- Register order + confirm via API.
- Depend on Drupal Commerce.
- Store Sberbank credentials as secrets.
- Operate over HTTPS.
- Confirm payment server-side via Sberbank's API.
- Not trust a client return.
- Confirm test vs live mode.
- Have no access-control role.
- Configure the Sberbank credentials.
- Handle Sberbank payments.
- Process payments securely.
- Configure the gateway.
- Handle credentials securely.
- Accept card payments.
- Integrate Sberbank.
- Configure payments.
- Handle the gateway.
- Confirm Sberbank payments.
