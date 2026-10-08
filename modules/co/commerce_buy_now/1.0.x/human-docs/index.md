# Commerce Buy Now — manual setup guide

**Commerce Buy Now** (`commerce_buy_now`) adds a **"Buy Now"** button to Drupal
Commerce that adds a product to the cart and sends the customer **straight to
checkout** in one step, skipping the cart page. For single‑item or impulse
purchases, the trip through the cart page is just friction — this button removes
it and can help conversion. It depends on Commerce, Commerce Cart, Commerce Store,
Commerce Checkout, and Commerce Product.

Under the hood it simply chains Commerce's standard add‑to‑cart and checkout flow,
so there's no unusual security surface — it reuses the normal, session‑scoped cart
and checkout. Because "Buy Now" bypasses the cart page, where shoppers usually
choose options and quantities, confirm it behaves the way you want with products
that require attribute selection or a quantity choice before you rely on it in
production.

This is a small UX enhancement with minimal setup — enable it, add the button
where you want it, and test.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.

There is **no dedicated configuration page** for this module; it plugs into the
standard add‑to‑cart and checkout flow.

## Where it lives in the admin menu

Commerce Buy Now adds no admin settings page of its own. The "Buy Now" button
surfaces alongside the standard add‑to‑cart experience on your products. Test the
flow on a product page after enabling the module, paying particular attention to
products that need options or a quantity chosen.
