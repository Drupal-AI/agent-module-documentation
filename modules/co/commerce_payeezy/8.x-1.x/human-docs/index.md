# Commerce Payeezy — manual setup guide

**Commerce Payeezy** (`commerce_payeezy`) integrates **Payeezy** (First Data) with
Drupal Commerce so your store can accept credit-card payments. It offers two
integration methods: a **hosted (offsite)** gateway, where the shopper is redirected
to Payeezy and back, and an **on-site** gateway, where the card is entered on your
own checkout.

It depends on **Commerce**, **Commerce Payment**, and **Commerce Order**. You
configure your Payeezy API credentials on the gateway, then attach it to your
checkout flow. Create a Payeezy developer account to obtain your API keys.

> **Good operating practice for any payment gateway.** As with every store that
> takes real money, reconcile your Commerce orders against your Payeezy merchant
> dashboard before you fulfil them, rather than trusting the on-screen result alone.
> Keep your Payeezy credentials (transaction key, response key, API secret, merchant
> token) out of version control, and restrict who can administer payment gateways.
> Note that this project is listed as **not covered** by Drupal's security advisory
> policy and is in *maintenance fixes only* status, so watch its issue queue and keep
> it updated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and configure the Payeezy payment
   gateway, and store its credentials safely.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway and choosing the Payeezy plugin (hosted or on-site). Older
documentation refers to `/admin/commerce/config/payment-methods`. You then attach it
to your checkout flow.
