# Commerce Klarna Checkout — manual setup guide

**Commerce Klarna Checkout** (`commerce_klarna_checkout`) integrates **Klarna
Checkout** — Klarna's *hosted* checkout experience — with Drupal Commerce.
Instead of your store rendering the full checkout, Klarna's checkout is embedded
in the page and handles collecting payment and customer details. This is a
different product from the Klarna *Payments* gateway; it replaces the checkout
step rather than being one payment option among several.

Note the branding history: the modern **3.x** branch (this version) points at the
**Kustom** API endpoints — Klarna Checkout was rebranded as *Kustom Checkout*. The
older `8.x-2.x` branch still used the legacy Klarna endpoints, which are scheduled
to stop working after **31 March 2026**, so new sites should be on 3.x. The module
depends on **Commerce Payment** (`commerce_payment`).

The security posture is the correct one for a hosted checkout. Payment status is
**confirmed by querying Klarna's authenticated API** (`getOrder`) rather than
trusting client‑side data or a raw notification payload — the notification handler
(`onNotify`) acts on the **authoritative order state fetched from Klarna**. As a
result, a forged callback cannot mark an order paid. Your job is to store the
**Klarna/Kustom API credentials** as secrets and confirm the correct
**region/environment (test vs live)**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Klarna Checkout gateway,
   enter your credentials, and choose the environment.

## Where it lives in the admin menu

Klarna Checkout is configured as a Commerce **payment gateway** under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Add a new gateway, choose the Klarna
Checkout plugin, and configure it as described in
[Configuration](configuration/index.md). Because it provides a hosted checkout,
you will also wire it into your Commerce **checkout flow**.
