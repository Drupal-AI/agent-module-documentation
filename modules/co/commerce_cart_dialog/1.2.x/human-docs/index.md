# Commerce Cart Dialog — manual setup guide

**Commerce Cart Dialog** (`commerce_cart_dialog`) shows the Drupal Commerce
shopping cart inside a **modal or off‑canvas (slide‑in) dialog**, so shoppers can
view and edit their cart without leaving the page they're on. Quantities update
and line items are removed over Ajax right inside the dialog, giving a mini‑cart
feel with no custom JavaScript to write. It depends on Commerce Cart
(`commerce_cart`).

It works by adding a dedicated `/cart/dialog` route whose controller renders
exactly the standard Commerce cart page — the same cart, just on a separate route
so the module can attach Ajax behaviour to the update and remove buttons.
Submitting inside the dialog refreshes or closes it automatically, depending on
the dialog type you choose. The module also provides a **cart trigger block** you
can place in any region, and you can link to `/cart/dialog` from any menu to open
the cart in a dialog.

A note on the `/cart/dialog` route: it is open to everyone (`_access: TRUE`), just
like core Commerce's own cart page. That's expected and safe here — the route
takes **no cart or order ID** and simply renders the standard cart page, which
always resolves the cart for the **current** session/user through Commerce's cart
provider. There's no way to address another user's cart (no IDOR) and no operation
beyond the normal, session‑scoped cart actions. The settings form itself is gated
behind an admin permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Cart.
2. [Configuration](configuration/index.md) — choose the dialog type and place the
   cart trigger.

## Where it lives in the admin menu

The settings form is at **Administration → Commerce → Configuration → Cart
Dialog** (`/admin/commerce/config/ccd`, behind the *access commerce
administration pages* permission). The cart trigger block is placed via **Structure
→ Block layout**, and you can also link to `/cart/dialog` from any menu.
