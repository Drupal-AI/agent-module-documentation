# Commerce Sezzle Pay — manual setup guide

**Commerce Sezzle Pay** (`commerce_sezzle_pay`) integrates **Sezzle's
buy-now-pay-later (BNPL)** checkout with Drupal Commerce as an **offsite**
payment gateway. When a customer chooses Sezzle, they are redirected to Sezzle to
arrange interest-free instalments; on return, the module authenticates to the
Sezzle API with a fresh token, re-fetches the order's real status, and only
completes the Commerce payment when Sezzle reports the order **captured /
approved**. That "re-fetch from the gateway" model is the correct, secure shape —
the paid/not-paid decision comes from Sezzle, not from the browser.

It is aimed at stores that want to offer instalment payments. It depends on
Commerce's **Payment** module (`commerce_payment`), supports refunds and partial
refunds, and can register a Sezzle **webhook** automatically when you save the
gateway. It also offers an optional checkout pane that skips the review step, and
a **decoupled (headless)** mode for JavaScript front-ends.

Note the project is currently **seeking a new maintainer**, so factor ongoing
support into your decision.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Sezzle Pay gateway, enter
   your API keys, and set the options, field by field.

## Where it lives in the admin menu

There is no separate settings page. You configure it by adding a payment gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and choosing the Sezzle Pay plugin.
See [Configuration](configuration/index.md).
