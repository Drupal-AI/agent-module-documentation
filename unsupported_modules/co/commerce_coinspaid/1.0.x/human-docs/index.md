# CoinsPaid Commerce — manual setup guide

**CoinsPaid Commerce** (`commerce_coinspaid`) is an **off‑site cryptocurrency
payment gateway** for Drupal Commerce, powered by **CoinsPaid**. It lets customers
pay in cryptocurrency: at checkout the shopper is redirected to CoinsPaid to
complete payment, and the order is finalized when CoinsPaid sends a signed callback
back to your site.

> **Composer note:** the module's machine name is `commerce_coinspaid`, but its
> Drupal.org project — and therefore its Composer package — is **`drupal/coinspaid`**.
> Install it with `composer require drupal/coinspaid` (see Installation), then enable
> the `commerce_coinspaid` module.

Security here follows the correct, defensive pattern. The callback handler
**verifies an HMAC‑SHA512 signature** — it checks the `X‑Processing‑Signature`
header against the callback body using your configured secret key and **throws on
any mismatch**, so no payment is recorded for an invalid signature. And it records
the payment using the **order's own total**, not any amount supplied in the
callback, which prevents a tampered callback from changing what's charged. Store
your CoinsPaid public and secret keys securely (see
[Configuration](configuration/index.md)).

CoinsPaid Commerce depends on Commerce **Payment** (`commerce_payment`) and works
on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the `drupal/coinspaid` package
   with Composer and enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — adding the gateway, entering your
   public/secret keys, and how the signed callback is verified.

## Where it lives in the admin menu

Like every Commerce payment method, CoinsPaid is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
CoinsPaid plugin.
