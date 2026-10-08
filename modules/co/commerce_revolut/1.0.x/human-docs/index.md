# Commerce Revolut — manual setup guide

**Commerce Revolut** (`commerce_revolut`) is a Drupal Commerce **payment gateway**
that connects a store to Revolut's payment solutions — Revolut Pay, card payments,
and payment links. It supports Strong Customer Authentication (such as 3D Secure)
and secure card tokenisation, and can run either as a hosted checkout page or
embedded within Commerce's core checkout. Card data never touches your server
because it uses Revolut's Checkout Widget library.

The module creates a Revolut order/payment link, sends the customer to pay, and
records the result back in Commerce. Payments stay synchronised with Revolut, and
you can void, capture, and refund from the order management interface. It depends
on Commerce's Payment and Order modules (`commerce_payment`, `commerce_order`) and
runs on Drupal 10 and 11. Notably, this project is **covered by Drupal's security
advisory policy**.

Like every payment gateway, it does nothing until you add and configure it with
your Revolut credentials. Its result handling is sound: when the customer returns,
the module **re-fetches the Revolut order from Revolut's API server-side** and
sets the payment state from the API's own status — it never trusts a status
supplied in the browser redirect, so a customer cannot self-report a paid order. A
`completed` state completes the payment; `pending`/`processing` raise a payment
failure. The webhook handler (`onNotify()`) is currently a no-op, so fulfilment
relies on this verified return.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce.
2. [Configuration](configuration/index.md) — add the Revolut gateway and enter
   your API credentials safely.

## Where it lives in the admin menu

Commerce Revolut has no standalone settings page. You configure it as a **payment
gateway** under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — click **Add payment gateway** and
choose the Revolut plugin.
