# Commerce GMO LinkTypePlus — manual setup guide

**Commerce GMO LinkTypePlus** (`commerce_gmo_linktypeplus`) adds an *off-site*
Drupal Commerce payment gateway for the **GMO Payment Gateway (Mul-Pay)** using
its **LinkTypePlus** hosted payment page. It is aimed at stores selling into
Japan, where GMO/Mul-Pay is a common acquirer, and it supports credit card, CVS
(convenience store), Pay-easy and PayPay payment methods.

At checkout the shopper is redirected to GMO's hosted LinkPlus page to pay, then
returned to your site. GMO reports the result to three routes the module exposes:
a browser-facing return that decodes the payment status and drives the order
transition, a server-to-server response saver, and a recurring-credit webhook. The
module ships its own **order workflow** (`linktypeplus order workflow`, draft →
pending → completed/canceled) that you must assign to the order type.

It depends only on Commerce Payment (no third-party libraries) and runs on Drupal
10.1+ and 11.

> **Security caveat — review before production.** The module's public
> documentation notes that the GMO response-handling routes have a **permissive
> access posture**: the browser return trusts a base64-encoded `result` POST for
> the payment status **without a signature/HMAC check**, the custom access
> callback on the response routes grants access unconditionally, and the
> recurring-credit webhook is gated only by the *access content* permission — which
> is effectively anonymous. On the positive side, the amount used when creating
> the payment is taken from the **loaded order**, not from the request, so the
> charged figure cannot be tampered with through the callback. Even so, because
> the payment *status* is trusted from an unverified callback, treat this gateway
> as one to review and harden before running real transactions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the gateway, assign the order
   workflow, and register the GMO return/notification URLs.

## Where it lives in the admin menu

Like every Commerce gateway, LinkTypePlus is added under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You must also assign its custom order
workflow at **Commerce → Configuration → Order types**
(`/admin/commerce/config/order-types`). See
[Configuration](configuration/index.md).
