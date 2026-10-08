<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Payment Elavon provides a payment gateway for the Elavon Virtual Merchant payment service.

---

Commerce Payment Elavon provides a Drupal Commerce payment gateway for Elavon — the Converge / Virtual
Merchant payment service — so a store can process card payments through Elavon. It depends on Drupal Commerce,
in the Commerce package.

Use it to accept payments via Elavon. Security notes for the payment integration: store the Elavon **API/
merchant credentials as secrets** (not in exported config), operate over HTTPS, and ensure the payment
result is validated server-side (the gateway should confirm/capture the charge against Elavon's authenticated
API rather than trusting a client-side result). Confirm the gateway mode (test vs live). It is an e-commerce/
payment feature. Configure the Elavon credentials.

---

- Provide an Elavon payment gateway.
- Process card payments via Elavon.
- Support Converge/Virtual Merchant.
- Depend on Drupal Commerce.
- Store Elavon credentials as secrets.
- Operate over HTTPS.
- Validate the payment result server-side.
- Confirm the charge against Elavon's API.
- Confirm test vs live mode.
- Have no access-control role.
- Configure the Elavon credentials.
- Handle Elavon payments.
- Process payments securely.
- Configure the gateway.
- Handle credentials securely.
- Accept card payments.
- Integrate Elavon.
- Configure payments.
- Handle the gateway.
- Process Elavon charges.
