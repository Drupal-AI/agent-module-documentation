<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Decoupled Checkout provides REST API endpoints for a decoupled Drupal Commerce experience.

---

Commerce Decoupled Checkout lets a separate front end — a JavaScript SPA, a mobile app, or any HTTP
client — drive a Drupal Commerce purchase over REST instead of using Commerce's built-in checkout
flow. It exposes four endpoints: create an order (together with the user account, customer profile,
and order items, and optionally process payment in the same request), create/initialize a payment
for an existing draft order, capture a previously initialized payment, and void an un-captured
payment. It depends on Drupal Commerce (`commerce_payment` and `commerce_checkout`) and works with
on-site payment gateways; the maintainers report it has been used with PayPal Express Checkout,
Stripe, Global Payments (Realex), and Direct Debits. The project is minimally maintained.

The endpoints are standard Drupal core REST resources, so they do nothing until you enable each one,
choose its request format and authentication provider, and grant the matching `restful post …`
permission to the roles that may call it. A public headless store commonly grants these to the
anonymous role. Operate the API over HTTPS and review the access model for your deployment.

---

- Drive a Commerce purchase from a headless front end over REST.
- `POST /commerce/order/create` — create user, profile, order, order items (payment optional).
- `POST /commerce/payment/create/{order_id}` — create/initialize a payment on a draft order.
- `POST /commerce/payment/capture/{order_id}/{payment_id}` — capture a payment.
- `POST /commerce/payment/void/{order_id}/{payment_id}` — void an un-captured payment.
- Works only with on-site payment gateways; payment amount comes from the order total server-side.
- Enable each REST resource and grant its `restful post …` permission before use.
- Choose an authentication provider per resource; serve over HTTPS.
- Extend behaviour with the module's alter hooks (prepare data, add promotions/coupons, order errors).
- Depends on Drupal Commerce (`commerce_payment`, `commerce_checkout`).
