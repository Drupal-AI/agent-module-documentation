# Commerce Paybox Payment — manual setup guide

**Commerce Paybox Payment** (`commerce_paybox_payment`) is a Drupal Commerce
**payment gateway** for **Paybox** (now part of Verifone), a payment service widely
used in France. It implements the Paybox *Service* method: at checkout the shopper
is redirected to Paybox's hosted payment page, pays there, and is returned to your
site, where the module verifies the signed response before recording the payment.

The security model is the reassuring part. The customer return route is guarded by a
custom access checker that runs **before** any payment is recorded: it rejects
authenticated sessions on the return URL, requires the expected `Ref`, `Mt`,
`Signature`, and `Error` parameters to be present, refuses to reprocess a payment
that's already completed, and — critically — verifies the signature with
`openssl_verify()` against Paybox's public key, only proceeding when verification
passes. In other words, a forged or missing signature cannot trigger order
fulfilment. Staff-facing admin routes for adding a payment are separately gated by
*create payment* access.

Setup involves supplying your Paybox credentials (site, rank, identifier), the
secret/HMAC material used to sign requests, and the **Paybox public key** used to
verify the return signature — so this module needs PHP's **OpenSSL** extension
enabled.

It depends only on Commerce's **Payment** module (`commerce_payment`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and configure the Paybox payment
   gateway.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway and choosing the **Paybox** plugin. You then attach it to your
checkout flow.
