# Commerce Limit Subscriptions — manual setup guide

**Commerce Limit Subscriptions** (`commerce_limit_subscriptions`) enforces a
simple but useful business rule: a customer who **already holds an active
subscription cannot buy another one**. It also stops a customer from **adding a
second subscription product to the cart** when one is already in there. If you sell
recurring subscriptions and want each customer to hold just one at a time, this
module quietly enforces that at the cart and checkout stage.

It builds on Drupal Commerce's subscription tooling, so it depends on **Commerce**
(`commerce`) and **Commerce Recurring** (`commerce_recurring`) — and works
alongside the cart. It is a **business‑rule** module: it constrains what can be
purchased based on the customer's existing subscription count. It has no
access‑control role and no external integrations.

There isn't much to configure. Once the module is enabled and you have subscription
products set up through Commerce Recurring, the restriction applies automatically —
a customer with an active subscription is prevented from purchasing or cart‑adding
another. Most of the work is on the Commerce Recurring side (defining the
subscription product variation types and the subscriptions themselves), which this
module then polices.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce Recurring dependency.

There is **no dedicated settings page** for this module — the one‑subscription rule
applies automatically once it's enabled, as described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin configuration page of its own. The relevant setup lives in
Drupal Commerce: your **subscription product variation types** and **subscriptions**
are defined through **Commerce Recurring**, and this module enforces the limit on
top of them at the **cart and checkout** stage.

## How to use it

1. **Enable Commerce and Commerce Recurring**, and set up your subscription
   products (a product variation type of type *subscription*, with the recurring
   configuration Commerce Recurring needs).
2. **Enable this module** (see [Installation](installation/index.md)).
3. That's it — the rule is now active. A customer who already has an **active
   subscription** is prevented from buying another, and cannot add a second
   subscription product to the cart while one is already there.
4. **Test it:** as a customer with an active subscription, try to add another
   subscription product to the cart or check out with one — the module should block
   it. Verify with a customer who has **no** active subscription that purchasing
   still works normally.
