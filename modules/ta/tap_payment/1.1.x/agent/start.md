<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tap Payment (tap_payment) — agent index

**A payment-gateway plugin API driving Tap Payments' hosted checkout; webhook-authoritative, no card data on site.**

- **Version:** 1.1.x · package Payment · PHP 8.3+
- **Core:** ^10.3 || ^11
- **Configure:** `tap_payment.settings` → `/admin/config/services/tap-payment`; ledger at `/admin/config/services/tap-payment/transactions`
- **Permissions:** `administer tap payment`, `view tap payment transactions` (both restrict access)
- **Service:** `tap_payment.payment` (`TapPaymentInterface`) — `createPayment()`, `verifyPayment()`, `loadByChargeId/IdempotencyKey/Context()`
- **Routes:** `tap_payment.webhook` (`POST /tap-payment/webhook`, `_access: TRUE`, HMAC-verified, flood-limited); `tap_payment.return` (`/tap-payment/return/{uuid}`, `_access: TRUE`, UUID-addressed, flood-limited); admin routes permission-gated
- **Entity:** `tap_payment_transaction` ledger · **Plugins:** payment gateways (`tap`), API adapters (`tap_payment_api_adapter`) · **Events:** `TapPaymentEvents`

**Security:** reviewed sound. The two open routes are open *by necessity* (serverside webhook / sessionless payer return) and authenticated by an HMAC signature / unguessable UUID respectively, both flood-limited; the webhook verifies its `hashstring` signature before believing any field. Idempotency + unique charge id prevent duplicate charges; a one-way state machine makes replays no-ops. Secret keys are write-only and log-sanitized; TLS left at Guzzle's secure default.

See [api/service.md](api/service.md) and [configure/setup.md](configure/setup.md)
