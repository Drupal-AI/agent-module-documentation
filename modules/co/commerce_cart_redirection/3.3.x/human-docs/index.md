# Commerce Cart Redirection — manual setup guide

**Commerce Cart Redirection** (`commerce_cart_redirection`) sends a Drupal
Commerce shopper somewhere useful the moment they add a product to their cart —
straight to the **checkout**, to the **cart page**, or to any **custom URL** you
choose — instead of leaving them sitting on the product page. It is the classic
way to build a "buy now" or express‑checkout experience without writing a custom
event subscriber.

You control exactly which products trigger the jump. On its settings form you
pick which product variation types (bundles) cause a redirect — for example only
"event ticket" variations — or you can flip a "negate" switch to redirect
*everything except* the ones you pick. The redirect target is up to you:
checkout, the cart, or a custom URL such as a thank‑you page, an upsell page, or
an external hosted payment page.

Two extra touches round it out. An advanced **clear the cart** option empties any
other items from the cart before adding the new one, so the shopper checks out
with just that single product — perfect for a kiosk, a donation flow, or a
"one product at a time" store. And you can relabel the **Add to cart** button
(to "Buy now", say) for exactly the products that will skip the cart, so the
button text matches what actually happens.

Out of the box nothing is redirected until you configure it. The module requires
Drupal Commerce (the core **Commerce** and **Commerce Product** modules) and adds
a permission so you can let a store manager self‑serve these rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce.
2. [Configuration](configuration/index.md) — the settings form, field by field:
   which products redirect, where they go, clearing the cart, and the button
   label.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Commerce → Configuration → Orders →
Cart redirection** (`/admin/commerce/config/commerce_cart_redirection`), gated by
the **Configure commerce cart redirection** permission.

## How to use it

Open the settings form, choose which product variation types should trigger a
redirect and where they should go, optionally turn on cart‑clearing and set a
custom button label, and save. From then on, adding one of those products jumps
the shopper straight to your chosen destination. See
[Configuration](configuration/index.md) for the details.
