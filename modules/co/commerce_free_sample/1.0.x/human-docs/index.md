# Commerce Free Sample — manual setup guide

**Commerce Free Sample** (`commerce_free_sample`) lets a Drupal Commerce store
offer customers one free product sample during checkout. A "Select a Free Sample"
dropdown appears on the **Order information** step; when the customer picks a
sample it is added to their order as a normal line item, and if they change their
mind the previous sample is swapped out automatically. There are no coupon codes
and no extra steps — the whole flow happens inside checkout.

It is a nice way to drive product discovery: a food or spice shop introducing new
flavors, a cosmetics store handing out trial sizes, or any "try before you buy"
promotion. You curate a pool of sample products once, optionally restrict which
orders qualify, and the module manages the rest — one sample per order, enforced
automatically.

The module needs a little setup before it does anything: you must create the
sample products, tell the module which products to offer, and confirm the widget's
placement in checkout. It depends on Drupal Commerce (Order and Product) and on
the **Commerce Checkout Order Fields** module, and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — create your sample products, choose
   the sample pool, and set optional eligibility rules.

## Where it lives in the admin menu

The module's settings form sits at **Commerce → Free Samples**
(`/admin/commerce/free-samples`), and it is reachable by users with the
**Administer commerce_product** permission. That is where you curate which
products are offered as samples. The customer-facing part lives in the checkout
form itself, on the Order information step.
