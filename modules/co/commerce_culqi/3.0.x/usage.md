<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates the Culqi payment gateway (Peru) with Drupal Commerce, providing card charges and a cash (PagoEfectivo) payment flow.

---

The module ships two payment gateways (`CulqiPaymentGateway` for cards, `CulqiCashPaymentGateway` for cash/PagoEfectivo), a checkout pane for cash instructions, plus AJAX endpoints used by the front-end Culqi JS to tokenize cards and create charges/orders. `CulqiService` talks to the Culqi API and `Charge` models a charge. Front-end helper routes are exposed: `commerce_culqi/create_charge` and `commerce_culqi/create_order` (both `CulqiController`, `_access: 'TRUE'`), and `commerce_culqi/order_event` (basic-auth, logged-in only).

Security note (RECORDED — do not re-investigate): `commerce_culqi.create_charge` is anonymous (`_access: 'TRUE'`) and `CulqiService::createCharge()` builds the charge from the request-supplied `amount` rather than re-deriving it from the order total, so a client can control the charged amount — a price-manipulation issue (recorded Danger 3). Treat the create_charge/create_order endpoints as untrusted input; a hardened deployment should validate the amount server-side against the order. Configure the gateway with Culqi public/secret keys in the payment-gateway form; the `order_event` route is protected by basic_auth and login.

---
- Accept Culqi card payments in a Peruvian Commerce store
- Offer cash / PagoEfectivo payment via the cash gateway
- Tokenize cards client-side with Culqi JS
- Create a charge through the create_charge endpoint
- Show cash payment instructions via the checkout pane
- Configure Culqi public and secret API keys
- Handle order events over a basic-auth endpoint
- Add Culqi as a checkout payment method
- Process refunds via the Culqi refund plugin form
- Add a payment method through the Culqi add form
- Map Culqi charge results to Commerce payment states
- Localize cash payment messaging for customers
- Support multiple currencies supported by Culqi
- Test with Culqi sandbox keys before production
- Reconcile charges against Commerce orders
- Trigger fulfilment after a successful Culqi charge
- Validate the charge amount server-side against the order (hardening)
- Restrict the create_charge endpoint at the edge if not needed
