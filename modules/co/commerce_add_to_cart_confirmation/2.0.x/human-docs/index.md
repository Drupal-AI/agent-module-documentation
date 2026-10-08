# Commerce add to cart confirmation — manual setup guide

**Commerce add to cart confirmation** (`commerce_add_to_cart_confirmation`)
replaces Drupal Commerce's plain "*item added to your cart*" status message with a
richer, more prominent confirmation shown right after a shopper adds a product.
Instead of a small message at the top of the page — which on a long product page is
often scrolled off‑screen, leaving the shopper unsure whether the click even
worked — the confirmation appears front and centre and gives them the two choices
that matter at that moment: keep shopping, or head to checkout.

The clever part is how the confirmation is built. The module ships a Views view
called **Commerce Add to Cart Confirmation**, so its contents are fully editable
in the Views UI. That means you can enrich the confirmation with related or
featured products, a cart summary, or a cross‑sell block — all without writing
code. It requires Commerce Cart (`commerce_cart`), Commerce Product
(`commerce_product`), and core **Views** (`views`).

There is no dedicated settings form: once enabled, the confirmation replaces the
default message automatically, and any customisation happens in the provided view.
A word of care on the customer experience — a confirmation should never get in the
way of the next action. Keep the "continue shopping" path to one obvious click,
and if you theme it as a modal make sure it can be dismissed with the keyboard
(Escape), traps focus while open, and returns focus to the add‑to‑cart button on
close, so the flow stays accessible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce/Views dependencies.

There is **no configuration page** for this module — it has no settings form. You
tailor the confirmation entirely in the Views UI, described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no settings page of its own. The confirmation is active as soon as
the module is enabled. To customise what it shows, edit its view at **Structure →
Views** (`/admin/structure/views`) — look for **Commerce Add to Cart
Confirmation**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Add a product to the cart on your storefront — the new confirmation appears in
   place of the default status message.
3. To enrich it, go to **Structure → Views**, open **Commerce Add to Cart
   Confirmation**, and add fields, related‑product blocks, or a cart summary as
   you would with any view. Save, and the confirmation updates.
4. Test the flow on a mobile screen and with the keyboard to make sure "continue
   shopping" is one easy click and the confirmation can be dismissed.
