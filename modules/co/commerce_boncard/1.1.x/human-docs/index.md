# Commerce Boncard — manual setup guide

**Commerce Boncard** (`commerce_boncard`) integrates **Boncard**, a Swiss
gift‑card / prepaid‑card provider, into Drupal Commerce so shoppers can redeem a
Boncard gift card during checkout. The card balance is applied to the order as an
adjustment and processed much like a payment. It depends on Commerce Checkout
(`commerce_checkout`), and you'll need a valid contract with Boncard AG to use it.

During checkout a redemption pane lets the shopper enter a card number and CVC.
Behind the scenes the module's client calls the Boncard REST API to **check the
balance**, **authorize**, **capture (submit)**, **refund**, and **cancel/void**
transactions. Each Boncard transaction is stored as a fieldable
`commerce_boncard` entity that moves through a workflow (New → Authorized →
Complete → Partially refunded → Refunded), and a **Giftcards** tab is added to the
order so staff can see and manage related transactions. A shopper can pay part of
an order with a gift card and the rest with another method — including an off‑site
card gateway.

On the security side this is an **outbound‑only** integration: your site calls
Boncard, and there's no inbound webhook that an attacker could forge. Every
outbound request is signed with an **HMAC‑SHA256** signature derived from the
request payload plus your configured API password, and admin/order operations are
protected by granular permissions (create/view/edit/cancel/refund/delete Boncard
transaction) and per‑operation entity access checks. The HTTP client uses normal
TLS verification. One data‑handling point to be aware of: the **card number and
CVC are stored on the transaction entity**, so protect access to those entities
and to your database accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Boncard credentials and
   add the redemption pane to your checkout flow.

## Where it lives in the admin menu

Boncard's own settings live at **Administration → Commerce → Configuration →
Boncard** (`/admin/commerce/config/boncard`, behind the *administer
commerce_boncard configuration* permission). You add the redemption pane through
**Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`), and you manage transactions from the
**Giftcards** tab on each order.
