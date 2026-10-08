<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Mercado Pago implements Mercado Pago on the site.

---

Commerce Mercado Pago **provides the Mercado Pago payment gateway** for Drupal Commerce — the customer pays via
Mercado Pago (Checkout Pro / popup), and the module records the payment. It depends on Commerce Payment.

Use it to accept Mercado Pago payments (Latin America). It is a **payment gateway**, and its result handling is
sound: the `onReturn()` handler **verifies the payment with the Mercado Pago API before trusting the return query
parameters** (its own comment notes this "prevents" trusting client-supplied status), and it also implements an
`onNotify()` IPN webhook that likewise **re-fetches the payment from the Mercado Pago API by id and binds it to
the order via `external_reference`** — so the payment outcome is derived from Mercado Pago's authenticated API,
not from forgeable request data. Security essentials: store the Mercado Pago **access token/client secret as
secrets** (env/Key), serve over HTTPS. It has no access-control role. Configure the Mercado Pago credentials.

---

- Provide a Mercado Pago gateway.
- Let the customer pay via Checkout Pro.
- Record the payment.
- Depend on Commerce Payment.
- VERIFY the payment with the Mercado Pago API before trusting return query params.
- Implement an onNotify() IPN webhook.
- Derive the outcome from MP's authenticated API (not forgeable request data).
- Store the Mercado Pago access token/credentials as secrets (env/Key).
- Serve over HTTPS + confirm the IPN validates via the MP API.
- Have no access-control role.
- Configure the Mercado Pago credentials.
- Handle Mercado Pago payments.
- Accept payments.
- Configure the gateway.
- Verify via API.
- Record payments.
- Handle the return.
- Handle the IPN.
- Secure the token.
- Provide a Mercado Pago gateway.
