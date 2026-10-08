<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Decoupled Stripe integrates Stripe with Commerce Decoupled Checkout.

---

Commerce Decoupled Stripe integrates **Stripe** with **Commerce decoupled (headless) checkout** — the
front end collects payment with Stripe.js/PaymentIntents and this backend gateway records the Commerce payment,
with standard and recurring (SetupIntent) gateways. It depends on Commerce Payment, in the Commerce (contrib)
package.

Use it for headless Stripe checkout on Drupal Commerce. Its payment trust boundary is **implemented correctly**
(verified): the gateway does **not** trust a client-supplied "paid" status — `capturePayment()` calls
**`PaymentIntent::retrieve()`** (authenticated with the Stripe **secret key**) to read the intent's real status
from Stripe's API server-side, and only sets the payment to `completed`/`authorization` based on that
authoritative status (canceled/requires-payment-method → voided). Because the PaymentIntent amount is set
server-side at creation (`createPayment()` uses the order's own amount), amount tampering isn't a vector either. Handle the Stripe **secret key** as a secret
(env/Key), use HTTPS. It has no access-control role. Configure the Stripe keys.

---

- Integrate Stripe with decoupled checkout.
- Support standard and recurring gateways.
- Record the Commerce payment.
- NOT trust a client-supplied paid status.
- Retrieve the PaymentIntent from Stripe (server-side).
- Set state from the authoritative status.
- Rely on the Stripe secret key.
- Know the intent amount is server-side.
- Store the Stripe secret key as a secret.
- Use HTTPS.
- Have no access-control role.
- Configure the Stripe keys.
- Handle Stripe payments.
- Verify payments.
- Configure the gateway.
- Confirm via retrieval.
- Handle the integration.
- Process payments.
- Secure the keys.
- Provide decoupled Stripe.
