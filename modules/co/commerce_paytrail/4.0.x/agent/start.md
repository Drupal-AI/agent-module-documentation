<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paytrail — agent index

Integrates **Paytrail** (Finnish payment aggregator: banks, card schemes, mobile methods) with
**Drupal Commerce** as an off-site payment gateway. Version **4.0.0-beta3**, core `^10 || ^11`.
Wraps the official **`paytrail/paytrail-php-sdk` `^2.0`** library. EUR only.

Key facts:
- **No global settings page, no routing.yml, no permissions, no hooks.** Everything is configured
  on the `commerce_payment_gateway.<id>` config entity. The module only registers services + two
  Commerce payment-gateway plugins.
- Two gateway plugins: **`paytrail`** (redirect: shopper picks a bank/card method on Paytrail) and
  **`paytrail_token`** (tokenized/stored credit card — MIT authorize/capture, voids, refunds).
- Config keys on the gateway entity: `account` (merchant ID), `secret` (merchant HMAC secret),
  `language` (automatic/FI/SV/EN), `collect_billing_information`, plus core `mode`; `paytrail_token`
  adds `capture` (transaction mode). Schema: `config/schema/commerce_paytrail.schema.yml`.
- Callbacks use Commerce's core routes: async `commerce_payment.notify` (`onNotify`) and browser
  `commerce_payment.checkout.return|cancel` (`onReturn`). The module defines **no** routes itself.
- Requests/responses are altered via a single **`ModelEvent`** dispatched at many lifecycle points
  (payment create, status get, refund, token add-card / MIT authorize / commit / charge / revert).
- Ships two event subscribers: `BillingInformationCollector` (adds invoicing address when
  `collect_billing_information` is on) and `ShippingEventSubscriber` (adds shipment line items,
  only registered when `commerce_shipping` is installed).

**Security posture (correct):** the return/notify handler **recomputes the Paytrail HMAC-SHA256
signature server-side** over the returned `checkout-*` params (SDK `Signature`, keyed by the
merchant secret) and rejects any mismatch; it also **binds the callback to this order**
(`checkout-reference` must equal the order id; the token flow adds a random per-order stamp) and
then **re-fetches the payment status from Paytrail's authenticated API** rather than trusting
request-supplied status. The charged amount is taken server-side from the order balance. Store the
merchant **secret** as a real secret and run over HTTPS.

Subdocs:
- **Gateway plugins & payment-method types** → [plugins/payment-plugins.md](plugins/payment-plugins.md)
- **Configure a Paytrail gateway (config keys, modes, credentials)** → [configure/gateway.md](configure/gateway.md)
- **Request builders, HTTP client & signature validation flow** → [api/services.md](api/services.md)
- **Altering API requests/responses via `ModelEvent`** → [hooks/events.md](hooks/events.md)

> Live API calls need real Paytrail credentials. For local work, ground on the gateway **config
> entity** (`commerce_payment_gateway.<id>`) in `test` mode; the SDK ships Paytrail's public sandbox
> merchant as the default account/secret.
