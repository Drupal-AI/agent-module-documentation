<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Datatrans integrates the Datatrans payment platform as a Drupal Commerce off-site payment gateway, confirming payments on the browser return and, optionally, via an HMAC-signed server-to-server webhook.

---

Commerce Datatrans provides a Drupal Commerce payment gateway for Datatrans (a Swiss
payment service provider), built on the Datatrans JSON/v1 API. At checkout the customer is
redirected to a Datatrans-hosted payment page; the module creates the transaction with
`initializePayment()` and redirects the browser to the URL Datatrans returns. The result is then
confirmed in two ways: on the browser **return** (`Datatrans::onReturn()`, which reads the
authoritative transaction status from Datatrans over an authenticated API call) and, when enabled,
via an asynchronous **webhook** (`PaymentNotificationController`).

The webhook handler is HMAC-authenticated and fails closed: it requires the `sign2` key to be
configured (returning `403` if it is not), reads the `Datatrans-Signature` header, recomputes the
HMAC over the raw request body, and **rejects** the request (`403`) if the header is missing or the
signature does not match. Only after the signature validates does it process the payment, and only
for whitelisted statuses (`settled`, `transmitted`, `authorized`). Because a caller cannot produce a
valid signature without the `sign2` secret, a forged notification cannot be processed.

Configure three Datatrans credentials on the gateway: the **merchant ID** and the **API password**
(used as HTTP Basic auth to the Datatrans API) and the **`sign2` webhook signing key** (required only
if you use the webhook). The gateway also supports automatic settlement, refunds
(`transactions/{id}/credit`), and card/alias tokenisation for recurring payments (the
`datatrans_alias` payment method type).

---

- Accept payments via Datatrans in Drupal Commerce.
- Redirect customers to a Datatrans-hosted payment page.
- Create the Datatrans transaction with `initializePayment()`.
- Confirm the result on the browser return via an authenticated API read.
- Optionally verify Datatrans webhook notifications with an HMAC signature.
- Require the `sign2` key before the webhook is active.
- Reject webhook calls with a missing signature header.
- Reject webhook calls with an invalid signature.
- Recompute the HMAC over the raw request body to verify.
- Process only whitelisted statuses (settled/transmitted/authorized).
- Return 403 from the webhook when `sign2` is not configured.
- Configure the Datatrans merchant ID, API password, and `sign2` key.
- Switch between Datatrans test (sandbox) and production hosts.
- Create Commerce payments against orders at the order total.
- Map Datatrans status to Commerce payment state.
- Refund Datatrans payments (full or partial).
- Tokenise cards/aliases for recurring payments (`datatrans_alias`).
- Authorize merchant-initiated payments from a stored alias.
- Automatically settle payments (configurable).
- Use with commerce_payment as the gateway plugin.
- Alter outgoing initialize/authorize data via provided hooks.
