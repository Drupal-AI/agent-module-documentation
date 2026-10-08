# Commerce Cart Skip — manual setup guide

**Commerce Cart Skip** (`commerce_cart_skip`) lets you define rules that **bypass
the shopping cart entirely** for certain products or situations, creating an order
directly and sending the buyer straight toward a confirmation. In other words, it
turns the usual "Add to cart" step into a one‑click "buy now" for the cases where a
cart just gets in the way — a free product used for registration sign‑ups, a
single‑item sale, a donation, or an event ticket.

It works by altering the add‑to‑cart form for product variations that match your
rules: instead of adding the item to a cart, the matching submit behaviour creates
an order immediately. Each rule can match on any combination of **product type**,
**product variation type**, **product variation price**, and **whether the user is
currently authenticated**. For each rule you also define what order and order item
get created, and the wording shown to the buyer — the button label, a terms‑and‑
conditions link, the success message, and so on.

Cart‑skip rules are **configuration entities**, managed through a standard admin
list with add/edit/delete forms, so they become part of your site's exported
configuration. After a rule fires, the buyer is routed to a "purchased"
confirmation page for the order that was created; that page requires order‑view
access, so buyers only ever see their own order. Only administrators holding the
module's permission can create or change rules, and there are no anonymous
management routes.

Commerce Cart Skip depends on Commerce **Cart** (`commerce_cart`) and works on
Drupal 8, 9, and 10. It is marked minimally maintained and is not covered by
Drupal's security advisory policy, so test rule matching on a staging store before
enabling it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Cart.
2. [Configuration](configuration/index.md) — creating cart‑skip rules, the
   conditions they match on, and the buyer‑facing text.

## Where it lives in the admin menu

Cart‑skip rules are managed at **Commerce → Configuration → Products → Commerce
Cart Skip** (`/admin/commerce/config/products/commerce_cart_skip`). Managing rules
requires the **`administer commerce cart skip rules`** permission.
