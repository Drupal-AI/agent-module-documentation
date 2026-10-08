# Commerce Shipping same as billing — manual setup guide

**Commerce Shipping same as billing** (`commerce_shipping_same_as_billing`) adds
the familiar **"shipping address same as billing"** option to Drupal Commerce
checkout. With a single checkbox the customer can reuse their billing address for
shipping instead of typing it again — a small but meaningful reduction in checkout
friction on stores that collect both addresses. It depends on **Commerce
Shipping** (`commerce_shipping`).

Drupal Commerce already ships the reverse behaviour out of the box (set the
*billing* address the same as the *shipping* address). This module flips that
around so the *shipping* address can be copied from the *billing* address, which
matches how many stores prefer to order the checkout — billing first, then
shipping. It simply copies address data within the order; it has no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings page of its own**. Once enabled, the option lives in
your checkout flow, described in "How to use it" below.

## How to use it

The "same as billing" option belongs to the checkout flow where shipping is
collected. After installing the module:

1. Make sure your checkout flow collects **both** a billing address and a
   shipping address (Commerce Shipping's checkout pane), with billing ordered
   before shipping so there is a billing address to copy from.
2. Go through checkout as a customer: on the shipping step you should see a
   **shipping same as billing** checkbox. Ticking it fills the shipping address
   from the billing address instead of asking the customer to re‑enter it.

Because the exact wiring depends on your checkout flow and theme, test a full
checkout after enabling to confirm the option appears where you expect. Note the
module is at an early (alpha) release, so verify the behaviour on your site.
