# Commerce GNU Taler — manual setup guide

**Commerce GNU Taler** (`commerce_gnu_taler`) adds an *off-site* Drupal Commerce
payment gateway for [GNU Taler](https://www.drupal.org/project/commerce_gnu_taler),
the privacy-preserving electronic-payment system. At checkout the shopper is sent
to their Taler wallet to confirm the payment; on return, the module confirms the
transaction with the Taler merchant backend and completes the order.

The gateway talks to a Taler **merchant backend** over its REST API. It creates a
redirect order on the backend at checkout, and when the shopper comes back it
re-fetches the order status from the backend and only records a **completed**
payment when the backend reports the order as `paid` — using the amount from the
backend's own contract terms rather than any value supplied by the browser. It also
supports **refunds**: an administrator can issue a full or partial refund, which
sends a refund request to the backend and emails the customer a Taler refund URI to
confirm.

It depends only on Commerce Payment, has no third-party PHP libraries, and runs on
Drupal 10 and 11. The default configuration ships pointing at the public **demo**
backend with a demo token — you must replace both with your own before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the gateway and enter your Taler
   backend URL, API key, and refund delay.

## Where it lives in the admin menu

Like every Commerce gateway, GNU Taler is added under **Administration → Commerce
→ Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md) for the fields.
