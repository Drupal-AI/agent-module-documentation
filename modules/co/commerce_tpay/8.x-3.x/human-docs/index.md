# Commerce Tpay — manual setup guide

**Commerce Tpay** (`commerce_tpay`) integrates the Polish payment provider
**Tpay** into Drupal Commerce as an **offsite‑redirect payment gateway**. At
checkout the customer is redirected to Tpay to pay (Polish bank transfer, BLIK, and
the other methods Tpay offers); Tpay then confirms the payment with an asynchronous
server‑to‑server notification (IPN), and the module creates a completed Commerce
payment attached to the right order.

Use it to accept Tpay payments in a Polish‑market Commerce store. It supports an
optional on‑site **bank selection** step before the redirect, which is pluggable —
developers can add their own selection logic through the
`CommerceTpayBankSelection` plugin type. When a payment is received the module also
dispatches a `TpayPaymentEvent`, so custom code can react (fulfilment, notifications
and so on).

It depends on **Commerce Payment** and is configured as a standard Commerce
payment gateway. Note that at the time of writing this module is **not covered by
Drupal's security advisory policy**, so review it before relying on it in
production.

**On the security of the payment confirmation (good news):** the notification
handler verifies Tpay's **checksum** against your merchant secret before recording
any payment, and it binds the confirmation to the order via Tpay's signed **CRC**
field (order id + currency). It also de‑duplicates by remote transaction id, so a
repeated notification is ignored. In other words, a forged notification cannot mark
an order paid. (One caveat: it does not compare the paid amount against the order
total, so a partial‑payment edge case is theoretically possible — this is not a
forgery risk, but worth verifying against your Tpay settings.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Tpay payment gateway and
   enter your merchant credentials securely.

## Where it lives in the admin menu

Like every Commerce payment method, Tpay is added under **Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
