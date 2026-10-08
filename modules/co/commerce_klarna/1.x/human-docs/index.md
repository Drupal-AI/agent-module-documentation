# Commerce Klarna — manual setup guide

**Commerce Klarna** (`commerce_klarna`) integrates the **Klarna** payment gateway
with Drupal Commerce. Klarna is the "buy now, pay later" provider that lets
shoppers **pay now, pay later, or pay over time**, and this module wires that into
your store's checkout. Beyond the basic gateway it supports Klarna's broader
toolkit: **Klarna Payments**, **Express Checkout** on the cart page, **On‑site
Messaging** (the "from X/month" promotions on product and cart pages), and the
**Merchant Card Service**.

The customer completes payment through Klarna, and the order is finalized on your
side through Klarna's **authenticated Order Management API**. It depends on
**Commerce Payment** (`commerce_payment`) and has no third‑party PHP
dependencies.

The security model is sound and worth understanding. The module's notification
handler (`onNotify()`) is a **no‑op** — the store never trusts a status posted in
a request body. Instead, order completion happens through **authenticated,
server‑side calls to Klarna's API** (HTTP Basic auth against Klarna's
authorizations and order‑management endpoints), so a forged callback cannot mark
an order paid. The module's own management routes require the `commerce_order`
update permission. Your responsibility is to store the **Klarna API credentials**
securely (environment‑backed, never committed) and to select the correct **Klarna
region** and **mode (test vs live)** for your account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the shipping submodule if you use express checkout with shipping).
2. [Configuration](configuration/index.md) — add the Klarna payment gateway,
   enter your credentials, choose region and mode, and enable optional features.

## Where it lives in the admin menu

Klarna is configured as a Commerce **payment gateway** under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Add a new gateway, choose the Klarna
plugin, and fill in the settings described in
[Configuration](configuration/index.md).
