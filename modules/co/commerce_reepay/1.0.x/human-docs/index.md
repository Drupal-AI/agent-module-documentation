# Billwerk+ Payments (Reepay) — manual setup guide

**Billwerk+ Payments (Reepay)** integrates the Billwerk+/Reepay hosted checkout
with Drupal Commerce as an **off-site redirect payment gateway**. Shoppers pay in
Billwerk+'s checkout window or modal, and the gateway supports the full payment
lifecycle — authorize, settle (capture), refund (including partial), and void —
plus a webhook that Billwerk+ calls to notify your store of payment events.

There is an important naming quirk to get right up front: the **project and
Composer package are `commerce_reepay`**, but the **module you actually enable is
`commerce_reepay_checkout`**. Get this wrong and `drush en` will fail. It depends
on Commerce's Payment module (`commerce_payment`).

Billwerk+ (formerly Reepay) gives your customers a wide range of payment methods —
cards, MobilePay, Klarna and more — through a PCI-compliant hosted checkout, so
sensitive card data never touches your server. Like every payment gateway, the
module does nothing until you add and configure it with your API keys.

> **Important security caveat — read before going live.** In this release the
> webhook that Billwerk+ calls (`onNotify()`) does **not** verify a signature on
> the incoming request, and it **places/completes the Commerce order before (and
> independently of) re-checking the payment with Billwerk+**. In practice that
> means a crafted anonymous POST to the notify endpoint referencing a draft
> order at the payment step could move that order to *complete* without a real
> payment. The customer-return path (`onReturn`) does re-fetch the invoice and is
> sound for the payment entity itself. Treat this gateway with caution: review the
> callback handling, restrict/monitor the notify endpoint, and reconcile orders
> against Billwerk+ before fulfilment until you have confirmed the behaviour on
> your version. See the configuration guide for detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   correctly-named module.
2. [Configuration](configuration/index.md) — add the Billwerk+ gateway, enter your
   keys safely, and understand the webhook behaviour.

## Where it lives in the admin menu

The gateway has no standalone settings page. You configure it as a **payment
gateway** under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — click **Add payment gateway** and
choose the Billwerk+ Payments plugin.
