<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce cashpresso (commerce_cashpresso) — agent index
**Off-site Commerce payment gateway for cashpresso instalment financing.**

- **version:** 2.2.x
- **core:** ^10 || ^11
- **depends on:** commerce:commerce_payment
- **plugin:** `CashpressoGateway` (id `cashpresso`, `OffsitePaymentGatewayBase`), config keys `api_key`, `secret`, `order_valid_time`, `interest_free_days_merchant`.
- **route:** `/cashpresso/direct-checkout/{entity_type}/{entity_id}` — `_custom_access` = `DirectCheckoutController::access` (requires `access checkout` + entity view access); price resolved server-side.
- **callback:** `onNotify()` verifies SHA-512 `secret;status;remoteId;orderId` before applying a Commerce transition.
- **Security (reviewed sound):** callback is hash-verified; charged amount comes from `$payment->getAmount()` (order-derived), not client input; TLS via Guzzle defaults. No disabled TLS, no unverified callback.

See [configure/gateway.md](configure/gateway.md)
