# Commerce Rave (Flutterwave) — manual setup guide

**Commerce Rave (Flutterwave)** (`commerce_rave`) is a Drupal Commerce **payment
gateway for Flutterwave Rave**, the payment platform widely used across Africa for
accepting card and mobile-money payments. It lets a Commerce store take payments
through Flutterwave's Rave, supporting both the **Standard (iFrame)** and the
**Hosted Payment Page** workflows.

The reason to reach for it is regional coverage: if your customers pay with
Flutterwave, this is the module that plugs that gateway into Commerce's normal
checkout and payment flow. It depends only on Commerce's Payment module
(`commerce_payment`) and runs on Drupal 9, 10 and 11.

Like every payment gateway, it does nothing until you add and configure it with
your Rave credentials. Its result handling is sound: when the customer returns
from paying, the module **verifies the transaction server-side** against Rave's
API (`verifyTransaction`) and completes the payment based on that authoritative
result — it does not simply trust the browser redirect, so a shopper cannot
self-report a paid order. (Note that a webhook is marked as a to-do in the code;
the module relies on the verified return flow instead.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — add the Rave gateway, choose the
   payment flow, and enter your public/secret keys safely.

## Where it lives in the admin menu

Commerce Rave has no standalone settings page. Like all Commerce payment methods,
you configure it as a **payment gateway** under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`).
Click **Add payment gateway** and choose the Rave plugin.
