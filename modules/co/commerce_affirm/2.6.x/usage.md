<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Affirm integrates Affirm into Drupal Commerce for point-of-sale consumer financing (buy-now-pay-later).

---

Commerce Affirm integrates Affirm into Drupal Commerce — providing an Affirm payment gateway for
point-of-sale consumer financing (buy-now, pay-later), so customers can finance a purchase through Affirm at
checkout. It depends on Commerce Payment, is configured at `commerce_affirm.settings`, in the Commerce
(contrib) package.

Use it to offer Affirm financing at checkout. Security notes for the payment integration: store the Affirm
**public and private API keys as secrets** (not in exported config), operate over HTTPS, and rely on Affirm's
**server-side authorization/capture** — the Drupal server confirms and captures the charge against Affirm's
authenticated API (using the private key and the returned checkout token) rather than trusting a client-side
"success", which is the correct server-authoritative pattern for a payment. Confirm the gateway is in the
right mode (sandbox vs live). It is an e-commerce/payment feature. Configure the Affirm credentials.

---

- Offer Affirm financing at checkout.
- Integrate Affirm buy-now-pay-later.
- Provide an Affirm payment gateway.
- Depend on Commerce Payment.
- Store Affirm API keys as secrets.
- Operate over HTTPS.
- Authorize/capture server-side via Affirm's API.
- Not trust a client-side success.
- Confirm sandbox vs live mode.
- Configure at commerce_affirm.settings.
- Handle consumer financing.
- Finance purchases via Affirm.
- Confirm charges against Affirm.
- Configure the Affirm credentials.
- Process financing payments.
- Handle the checkout token.
- Integrate Affirm.
- Configure the gateway.
- Accept Affirm payments.
- Offer point-of-sale financing.
