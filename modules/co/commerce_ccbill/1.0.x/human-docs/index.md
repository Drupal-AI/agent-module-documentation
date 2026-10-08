# Commerce CCBill — manual setup guide

**Commerce CCBill** (`commerce_ccbill`) integrates the **CCBill** payment service
into Drupal Commerce as an **off‑site payment gateway**. At checkout the shopper is
redirected to a CCBill **FlexForm** hosted page to pay; CCBill then confirms the
result to your site through a background post‑back (a webhook), at which point the
module records the payment and completes the order. It currently supports one‑time
payments.

The redirect carries the order total, currency, email, billing address, and a
**form digest** (an MD5 hash of price/period/currency and your shared salt) so
CCBill can trust the request. On the way back, CCBill's post‑back is validated
before anything is recorded — the module checks the request against CCBill's
published IP ranges (optional but on by default) and validates the MD5 digest, and
only on a `NewSaleSuccess` event does it create a completed payment and complete
the order. For developers, it fires a `CCBILL_PAYMENT_RECEIVED` event after a
payment so you can trigger follow‑up actions.

There is one **security caveat you should be aware of** before going live, spelled
out in [Configuration](configuration/index.md): the MD5 digest that gets verified
covers the *subscription* price/currency fields, but the amount the module actually
records comes from a different, **unsigned** set of post‑back fields — so the amount
that is verified is not strictly the amount that gets stored. Keep IP validation
enabled, keep your salt secret, and reconcile recorded amounts against CCBill's own
reporting.

Commerce CCBill depends on Commerce (`commerce`) and Commerce **Payment**
(`commerce_payment`) and works on Drupal 8.8, 9, and 10. It is not covered by
Drupal's security advisory policy, so keep it updated and test on staging.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce and Commerce Payment.
2. [Configuration](configuration/index.md) — adding the CCBill gateway, wiring up
   the FlexForm and background post‑back, and the security caveat to respect.

## Where it lives in the admin menu

Like every Commerce payment method, CCBill is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways/add`). You add a gateway there and choose
the **CCBill** plugin. The background post‑back (webhook) URL defaults to
`/payment/notify/{payment_gateway}`.
