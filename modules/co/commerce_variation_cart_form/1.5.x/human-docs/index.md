# Commerce Variation Cart Form — manual setup guide

**Commerce Variation Cart Form** (`commerce_variation_cart_form`) gives each
Commerce product *variation* its own add-to-cart form. Normally a product page
shows a single add-to-cart form with a variation selector; this module lets you
render each variation standalone — with its own quantity field and *Add to cart*
button — so you can build grids, "quick order" pages, or Views listings where every
variation is independently addable to the cart.

It works by adding an **"Add to cart form"** pseudo-field to the product variation's
*Manage display*. This is a display element (not a real stored field), hidden by
default; when you make it visible, each rendered variation gains a working
add-to-cart form. The form itself is built from the Commerce cart's
`AddToCartForm` through a dedicated form mode, so you decide which order-item fields
appear in it — typically just a Quantity input, or nothing at all for a bare "Add
to cart" button that always adds one.

A per-display option, **Combine order items containing the same product
variation**, controls whether adding a variation that is already in the cart bumps
the existing line item's quantity or creates a separate line. The form is
automatically hidden (showing a friendly "unavailable" message) for unpublished
variations and is gated on the customer's *access checkout* permission. The module
requires Commerce with its Product, Order and Cart submodules.

This guide is written for a **human** clicking through the Commerce admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no central settings page; you switch the feature on across a few Commerce
display forms.

**1. Show the form on the variation display.** Go to **Commerce → Configuration →
Product variation types**, open **Manage display** for the variation type, and set
the **Add to cart form** row to a visible region (it is *Disabled* by default). On
that same form you will also see a checkbox, **Combine order items containing the
same product variation** — tick it to merge repeat adds into one cart line, or leave
it off to keep each add as its own line.

**2. Choose which fields appear in the form.** Go to **Commerce → Configuration →
Order item types**, open **Manage form display**, and switch to the **Variation
Cart Form** form mode. Show only **Quantity** to give customers a quantity input, or
hide everything for a plain "Add to cart" button that adds a quantity of one.

**3. Wire up the product display (typical setup).** To replace the default single
product add-to-cart form with per-variation forms: go to **Product types → Manage
display**, set the **Variations** field to **Rendered entity** using the variation
view mode you configured in step 1. Then, on the product type's **Edit** tab,
uncheck **Inject product variation fields into the rendered product** so the
variation fields are not duplicated.

Once configured, each variation renders with its own add-to-cart form wherever the
variation is displayed — a product page, a Views listing, or an embedded block.
Unpublished variations show a "This product is unavailable" message instead of a
form.

You can theme the form wrapper (and change that unavailable message) by overriding
the `commerce-variation-cart-form.html.twig` template — see the sibling
[`agent/theming/template.md`](../agent/theming/template.md) doc for the available
variables and template suggestions. Note that theming controls the wrapper only; the
form *fields* come from the order-item form mode in step 2.
