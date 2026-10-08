# Commerce Escrow — manual setup guide

**Commerce Escrow** (`commerce_escrow`) integrates Drupal Commerce with
**Escrow.com**, so a store can settle high‑value or trust‑sensitive orders through
Escrow.com's escrow service — where the funds are held by the escrow provider
until delivery is confirmed. It supports both **Escrow Pay** and **Escrow Offer**,
implemented as off‑site payment gateways, and keeps Commerce payments in sync with
Escrow.com through a webhook for real‑time updates.

Beyond payment, the module adds an **Escrow Item** trait for product variation
types (giving them escrow‑specific fields such as brokered sale, broker/escrow fee
split, item type, and inspection period) and an **Escrow Workflow** for order
types, so an order's and payment's states can be driven automatically by
Escrow.com's webhook. You can also alter the transaction payload or stop the
automated workflow via event subscribers, and the module ships an `EscrowClient`
you can use directly from custom code. It depends on Commerce's **Payment** and
**Order** modules (`commerce_payment`, `commerce_order`), and requires Commerce
Core 3.

> **Enable `commerce_product` too.** As shipped (1.0.2) the module references a
> `commerce_product` class in a hook without declaring `commerce_product` as a
> dependency, so it will fatal unless the **Commerce Product** module is also
> enabled. Enable `commerce_product` alongside it — see Installation.

Configuration happens across the payment gateway (API key, account‑holder email,
live/test mode), your order type (choose the Escrow Workflow), your product
variation type (apply the Escrow Item trait), and Escrow.com itself (set the
webhook URL). Store your Escrow.com API credentials securely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus `commerce_product`).
2. [Configuration](configuration/index.md) — the gateway, order type, product
   variation type and Escrow.com webhook.

## Where it lives in the admin menu

The payment gateway is added under **Administration → Commerce → Configuration →
Payment gateways**. The order‑type workflow is set under **Commerce →
Configuration → Order types**, and the Escrow Item trait under **Commerce →
Configuration → Product variation types**.
