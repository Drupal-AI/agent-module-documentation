<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eSewa Payment Gateway (esewa) — agent index

**Drupal Commerce off-site gateway for eSewa ePay v2 with HMAC-SHA256 response verification.**

- **Version:** 2.0.0 (dir 2.0.x)  •  **Core:** ^10 || ^11  •  **Requires:** commerce, commerce_order, commerce_cart, commerce_payment  •  **Configure:** `entity.commerce_payment_gateway.collection`
- **Plugin:** Commerce PaymentGateway `EsewaCheckoutCheckout` (off-site redirect). Controller `EsewaController`. Events `EsewaCheckoutPaymentEvent`.
- **Routes:** `esewa.payment_success` (`/esewa/success`), `esewa.payment_cancel` (`/esewa/cancel`) — both `_access: 'TRUE'` (eSewa redirects an unauthenticated browser here).
- **Security:** Open callbacks are **safe by verification**, not by access. `paymentSuccess()` (`Controller/EsewaController.php:101-138`) requires: SDK `verifyPayment()` HMAC-SHA256 signature check, session transaction-UUID match (replay protection), `status === COMPLETE`, and amount match (±0.01) before completing payment. No fulfilment occurs on an unverified/forged callback. Session-scoped order identification.

See [configure/gateway.md](configure/gateway.md)
