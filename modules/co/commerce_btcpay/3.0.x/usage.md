<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce BTCPay provides an off-site Drupal Commerce payment gateway for BTCPay Server.

---

Commerce BTCPay provides a **Drupal Commerce off-site payment gateway for BTCPay Server** — accepting
Bitcoin, Lightning Network, and altcoin payments through a self-hosted (or hosted) BTCPay Server using
its **Greenfield API**. It depends on Commerce Checkout and Commerce Payment, in the Commerce package,
and requires the `btcpayserver/btcpayserver-greenfield-php` PHP library plus the `bcmath` and `openssl`
PHP extensions. Version 3.x is a breaking rewrite from 1.x/2.x — uninstall the older version first.

At checkout the module creates a BTCPay invoice for the order's amount and redirects the buyer to the
BTCPay checkout page. Payment confirmation is done **correctly and server-side**: the webhook (IPN)
handler verifies the `BTCPay-Sig` **HMAC signature** over the raw request body, then **always
re-fetches the authoritative invoice** directly from BTCPay (`getInvoice`) and records the payment
from that verified status — the event type in the webhook body is never trusted to decide the outcome.
The same authoritative re-fetch runs on the customer-return leg. Every update cross-checks that the
invoice binds to the right payment, order, store, and **amount + currency** (precise decimal compare),
so a forged notification, a replayed/duplicate delivery, an underpayment, or a wrong-currency invoice
cannot mark an order paid. The notify route is public (`_access: TRUE`, standard for a Commerce IPN),
but is gated by the signature check and the authoritative re-fetch.

Pairing uses BTCPay's authorization flow: save a **disabled** gateway with your **HTTPS** BTCPay Server
URL, click **Generate API Key** to authorize a **least-privilege** API key on BTCPay, then explicitly
review and enable the verified gateway. The API key and webhook secret are stored **encrypted**
(AES-256-GCM) in Drupal's non-exportable key/value storage — never in exported configuration — and the
customer email is sent to BTCPay only if you opt in. This is an alpha release (reported stable by the
maintainers) — validate it for your version.

---

- Accept Bitcoin / Lightning / altcoin payments via BTCPay Server (Greenfield API).
- Use the off-site redirect flow (create invoice, redirect to BTCPay checkout).
- Support self-hosted or hosted BTCPay Server.
- Depend on Commerce Checkout and Commerce Payment.
- Verify the webhook HMAC signature (`BTCPay-Sig`) over the raw body.
- Re-fetch the authoritative invoice status from BTCPay and act on that.
- Never trust the posted event type or the return URL to decide payment state.
- Cross-check invoice binding to payment, order, store, amount, and currency.
- Reject duplicate/replayed webhook deliveries (idempotency + timestamp ordering).
- Enforce monotonic payment-state transitions.
- Pair via a least-privilege API-key authorization flow.
- Store the API key and webhook secret encrypted, outside exported config.
- Enforce HTTPS for the BTCPay Server URL.
- Send the buyer email to BTCPay only when opted in.
- Configure the gateway as a Commerce payment gateway (live-only).
- Validate for your (alpha) version.
