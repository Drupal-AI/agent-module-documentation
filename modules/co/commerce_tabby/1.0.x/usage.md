<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Tabby provides Commerce integration for Tabby Payments.

---

Commerce Tabby **provides the Tabby Payments (buy-now-pay-later) gateway** for Drupal Commerce — the customer
is redirected to Tabby to pay and returned to the store, and Tabby also confirms the outcome via a webhook. It
depends on Commerce Payment.

Use it to accept Tabby BNPL payments. It is an **offsite payment gateway**. On both the return leg
(`onReturn()`) and the webhook (`onNotify()`) the module reads the Tabby **payment `id`** from the request and
then **re-fetches that payment from Tabby's API server-side** (`GET v2/payments/{id}` via an authenticated
request with the secret key); it proceeds only when that authenticated API response reports the payment as
`CLOSED` or `AUTHORIZED`. The local payment is resolved via `meta.payment_id`, state transitions are lock-guarded,
and repeat deliveries no-op once the payment leaves `new`. The webhook URL is auto-registered with Tabby when the
gateway is saved. Store the Tabby **secret/public API keys as secrets** (env/Key) and serve over HTTPS. It has no
access-control role. Configure the Tabby API credentials on the gateway.

---

- Provide a Tabby BNPL offsite gateway.
- Redirect the customer to Tabby, and return them to the store.
- Confirm the outcome on the return leg and via webhook.
- Depend on Commerce Payment.
- Read the payment id from the return query / webhook body.
- Re-fetch the payment from Tabby's authenticated API (GET v2/payments/{id}).
- Proceed only on API status CLOSED/AUTHORIZED.
- Resolve the local payment via meta.payment_id and lock-guard transitions.
- Auto-register the webhook URL with Tabby on gateway save.
- Store the Tabby API keys as secrets (env/Key), HTTPS.
- Have no access-control role.
- Configure the Tabby credentials.
- Handle Tabby payments (authorize, auto-capture, capture, refund).
- Accept payments.
- Configure the gateway.
- Verify via the Tabby API.
- Redirect customers.
- Authorise payments.
- Store the credentials.
- Provide a Tabby gateway.
