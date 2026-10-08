# Commerce Unzer — manual setup guide

**Commerce Unzer** (`commerce_unzer`) provides a payment gateway for the **Unzer**
provider (formerly Heidelpay) in Drupal Commerce. The customer pays through Unzer
and the module records the resulting payment against the order. It began life as a
port of the older `commerce_heidelpay` module to Unzer's current SDK.

There are two flavours: an **on‑site** gateway that supports credit‑card payment
(a straightforward port from Heidelpay), and an **off‑site** redirect gateway
under active development that is intended to support additional payment methods
beyond cards. It depends on **Commerce Payment** and is configured as a standard
Commerce payment gateway.

**On the security of payment confirmation (good news):** the module does not trust
the browser for the payment result. On the off‑site return its `onReturn()` handler
**re‑fetches the paypage and payment from the Unzer API server‑side**
(`fetchPaypageV2()` → `fetchPayment()`, using your private key) and records the
payment only when Unzer reports its state as **completed** — so the payment status
always comes from Unzer's authenticated API, never from forgeable request
parameters. On‑site card charges likewise run server‑side and are recorded only on
success. Your part is to keep the Unzer **private key** out of committed
configuration and to serve the site over HTTPS.

One important environment note: Unzer's SDK can throw rounding‑error exceptions for
some amounts unless PHP's `serialize_precision` is set to `-1`. Set that in your PHP
configuration before going live (details in [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, set
   `serialize_precision`, and enable the module.
2. [Configuration](configuration/index.md) — add the Unzer payment gateway and
   enter your keys securely.

## Where it lives in the admin menu

Unzer is added under **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
