# Commerce Ajax Add to Cart — manual setup guide

**Commerce Ajax Add to Cart** (`commerce_ajax_atc`) makes Drupal Commerce's
"Add to cart" button submit over AJAX. Instead of reloading the whole page when a
shopper adds a product, the cart block refreshes in place and a confirmation
appears — giving a classic Commerce storefront a smoother, single‑page‑app feel
without any decoupling.

You turn the behavior on **per product display**: the module adds an **"Enable
Ajax"** checkbox to the Add to cart field's formatter on a product type's *Manage
display* screen. That lets you use AJAX on some displays or view modes while
keeping the standard form on others.

Once AJAX is on, a single global settings form controls what the shopper sees
after adding an item. You choose the confirmation style — a lightweight inline
message, a modal dialog, or a Colorbox pop‑up — customize the success text (with a
`[variation_title]` token), and optionally add **View cart**, **Checkout**, and
**Continue shopping** buttons. Commerce's own default "added to your cart" message
is automatically suppressed so only your pop‑up shows.

The module requires Commerce Cart. It also has optional integrations with Colorbox
Load (for the Colorbox pop‑up), Commerce Variation Cart Form, and Commerce VADO.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Cart.
2. [Configuration](configuration/index.md) — turn AJAX on for a display, then tune
   the global pop‑up settings.

## Where it lives in the admin menu

Two places. You switch AJAX on for each product display under **Commerce →
Configuration → Product types → (a type) → Manage display**, in the settings of the
**Variations** field. The global pop‑up settings live at **Commerce →
Configuration → Ajax → Ajax add to cart pop‑up settings**
(`/admin/commerce/config/ajax-settings`).

## How to use it

Enable the checkbox on the display you want, pick a pop‑up type on the settings
form, and you're done — no theming needed. The full walkthrough is in
[Configuration](configuration/index.md).
