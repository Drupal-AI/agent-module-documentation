# Commerce Cart Flyout — manual setup guide

**Commerce Cart Flyout** (`commerce_cart_flyout`) gives a Drupal Commerce store a
modern, JavaScript-driven cart experience. It replaces Commerce's default cart block
with a slide-in **off-canvas "flyout"** cart, and it provides an in-page **Add to
Cart** form that adds products without a full page reload. Both are powered by the
Commerce Cart API, so cart totals and item counts update live.

When you install it, the module automatically points the existing Commerce cart
block at its own flyout implementation — so a store that already displays a cart
block gets the flyout with no extra work. The flyout shows a cart icon with a live
item count, and clicking it slides out a panel listing the cart contents. It is
deliberately hidden on the checkout page, so an order cannot be edited outside of
checkout.

The Add to Cart formatter renders a client-side add-to-cart form on your product
pages: shoppers can pick variation attributes (as select lists, radios, or rendered
swatches) and add to the cart in place. Because the flyout surfaces cart state on
the page, the module also suppresses Commerce's usual server-side "added to cart"
message.

This is mostly a front-end layer with very little to configure — a single block
option and one field formatter to select. Theming is done by overriding the
module's Twig templates, which are rendered and handed to its Backbone views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Commerce
   dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — the flyout block and its one setting,
   plus applying the flyout Add to Cart formatter to your product display.

## Where it lives in the admin menu

There is **no dedicated settings page**. Setup happens in two familiar places:

- The cart flyout block is managed under **Structure → Block layout**
  (`/admin/structure/block`) — where you also find its single option.
- The Add to Cart formatter is selected on a product type's **Manage display** tab
  (**Commerce → Configuration → Product types → [type] → Manage display**).
