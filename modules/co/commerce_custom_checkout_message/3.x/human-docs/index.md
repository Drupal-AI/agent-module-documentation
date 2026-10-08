# Commerce Custom Checkout Message — manual setup guide

**Commerce Custom Checkout Message** (`commerce_custom_checkout_message`) adds a
configurable **message panel** (a checkout pane) to the Drupal Commerce checkout
flow, so you can show customers an extra piece of text at checkout without writing
any code.

Checkout is often where a store needs to say something specific — a delivery note,
a running promotion, terms the customer should see before paying, or a simple
reminder. This module gives you a pane whose content you control, and the message
supports **tokens**, so you can weave in dynamic values (order details, site
information) rather than only static text.

It is a checkout **UX feature**. The message is admin‑configured content, so there
is no unusual security surface. It depends on **Drupal Commerce 3+**
(`commerce`) and **Commerce Checkout** (`commerce_checkout`), and supports Drupal
10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate settings page** for this module. You configure the message
inside the checkout flow editor, described in "How to use it" below.

## Where it lives in the admin menu

The pane is configured within the checkout flow editor at **Commerce →
Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`).

## How to use it

1. Go to **Commerce → Configuration → Checkout flows** and edit the checkout flow
   you want to change.
2. In the flow editor, find the **Custom message** pane among the available panes
   and drag it into the checkout **step** where it should appear.
3. Open the pane's settings and enter your **message** text. You can use any
   available **tokens** to include dynamic values.
4. Save the checkout flow.

> **Verify:** run through checkout as a customer and confirm the message renders at
> the step you placed it on, with any tokens resolved to their real values.
