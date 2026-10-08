# Commerce MAIB — manual setup guide

**Commerce MAIB** (`commerce_maib`) is a Drupal Commerce payment gateway for
**MAIB (Moldova Agroindbank)**. It lets a Commerce store accept card payments
through MAIB: the customer is redirected to the bank to pay, and the module then
confirms the outcome by querying MAIB's API server-side — so the payment result
comes from the bank, not from anything the browser hands back.

Unlike gateways that authenticate with a simple API key, MAIB uses **client-
certificate authentication**. You extract a certificate and private key from the
PFX file the bank issues you, and the module presents that certificate (together
with RSA keys and the PFX password) when it talks to MAIB. This makes secure
handling of those key files the most important part of setup.

The module supports two working modes — **Test** (for development) and **Live**
(for production) — and two ways of taking money: **Capture** (funds move to the
merchant instantly when the customer pays, the recommended mode) and
**Authorize** (funds are held on the customer's account until you confirm the
transaction later, useful when shipping takes a long time). It depends only on
Drupal Commerce's Payment module and the `maib/maibapi` PHP library, which
Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the MAIB payment gateway, pick
   test/live and capture/authorize, and load your bank certificate securely.

## Where it lives in the admin menu

Commerce MAIB adds no top-level admin page of its own. Like every Commerce
payment gateway, you configure it under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway of type
**MAIB** and enter its settings.
