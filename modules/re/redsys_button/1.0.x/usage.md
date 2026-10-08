<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redsys Button to Drupal provides a Redsys payment button form, integrating the Redsys payment gateway with HMAC-SHA256 signatures.

---

Redsys Button to Drupal provides a Redsys payment-button form — integrating the Redsys payment gateway
(widely used in Spain) so a site can present a pay-with-Redsys button that redirects the customer to Redsys
for payment. It ships a `commerce_redsys_button` submodule (Drupal Commerce integration) and is configured
at `redsys_button.redsys_config_form`, in the Moon package.

Use it to accept Redsys payments. The security-relevant handling is correct: it signs the merchant request
with **HMAC-SHA256** (`hash_hmac('sha256', ...)` via Redsys' 3DES-derived key) and includes a Validators
component for verifying — the standard Redsys signature scheme. When adopting: store the Redsys **merchant
secret key** as a secret (not in exported config), operate over HTTPS, and ensure the **payment
notification/return is validated by signature** (so forged "paid" callbacks are rejected) — confirm the
signature check on the notification path in your configuration. It is an e-commerce/payment feature.
Configure the Redsys merchant credentials.

---

- Provide a Redsys payment button.
- Integrate the Redsys gateway.
- Redirect customers to Redsys.
- Ship a Drupal Commerce submodule.
- Sign requests with HMAC-SHA256.
- Use Redsys' standard signature scheme.
- Store the merchant secret key as a secret.
- Operate over HTTPS.
- Validate payment notifications by signature.
- Reject forged paid callbacks.
- Configure at the config form.
- Handle Spanish payments.
- Accept Redsys payments.
- Confirm the notification signature check.
- Configure merchant credentials.
- Sign merchant requests.
- Integrate Redsys.
- Provide a pay button.
- Handle payment redirection.
- Configure Redsys.
