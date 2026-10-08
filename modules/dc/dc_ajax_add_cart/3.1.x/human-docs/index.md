# Commerce AJAX Add to Cart — manual setup guide

**Commerce AJAX Add to Cart** (`dc_ajax_add_cart`) makes Drupal Commerce's "Add to cart"
button work over AJAX. When a shopper clicks it, the product is added and the mini-cart
block and status messages ("Added *X* to your cart") refresh in place — no full page
reload, so the customer stays right where they were on the catalog or product page. It's
the polished shopping experience you'd otherwise have to hand-write JavaScript for.

You turn it on by choosing a **display formatter**, not through a settings page — there is
no admin configuration form. On a product type's *Manage display*, you set the **Variations**
field to use the module's "Ajax add to cart form" formatter, and the add-to-cart form for
that product type starts submitting over AJAX. It reuses Commerce's own add-to-cart settings
(quantity input, default quantity, combining identical items), so nothing about the form
itself changes except that it no longer reloads the page.

The module depends on **Commerce Product** and **Commerce Cart** (Commerce 2.4+ or 3.x). It
ships two optional submodules: **AJAX Add to Cart Popup** (`dc_ajax_add_cart_popup`) shows a
modal "added to cart" confirmation, and **AJAX Add to Cart Views** (`dc_ajax_add_cart_views`)
adds AJAX remove and update-quantity actions to the cart form.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   pick the submodules you need.

## Where it lives in the admin menu

The module has **no settings page**. You configure it in two places:

- **Commerce → Configuration → Product types → [your type] → Manage display** — where you
  choose the AJAX formatter for the Variations field.
- **Structure → Block layout** — where you make sure the **Cart** block and a **status
  messages** block are placed (both are needed for the live refresh; see below).

## How to use it

### 1. Switch the Variations field to the AJAX formatter

1. Go to **Commerce → Configuration → Product types → [your type] → Manage display**.
2. For the **Variations** field, choose the **Ajax add to cart form** formatter.
3. Save.

The add-to-cart form on that product type now submits over AJAX. Repeat for each product
type (and each view mode) you want to ajaxify.

### 2. The formatter settings (inherited from Commerce)

Because the AJAX formatter builds on Commerce's standard add-to-cart formatter, it exposes
the same settings when you configure it:

- **Show quantity** — whether to show a quantity input on the form.
- **Default quantity** — the quantity the form starts with.
- **Combine** — merge additions of the same variation into a single cart line instead of
  adding separate lines.

### 3. Make sure the cart and messages blocks are placed

For the live refresh to have something to update, two blocks need to be present on the page:

- The **Cart** block (from Commerce Cart) — this is the mini-cart that gets rebuilt with the
  new item count.
- A **status messages** block for your active theme — this is where the "added to cart"
  message reappears after each add.

Place both under **Structure → Block layout** if they aren't already. Without the Cart block
there's nothing to refresh in place; without a messages block the confirmation message can't
be shown.

### 4. Optional: popup and Views actions

- Enable **AJAX Add to Cart Popup** for a modal "added to cart" confirmation dialog.
- Enable **AJAX Add to Cart Views** to let customers remove line items and change quantities
  in the cart form over AJAX.

### For developers

The module's `RefreshPageElementsHelper` service (`dc_ajax_add_cart.refresh_page_elements_helper`)
builds the cart-refreshing AJAX response and is reusable from your own AJAX callbacks — call
`updatePageElements($form)->getResponse()` to refresh the build id, messages, and cart block,
or `updateCart()->getResponse()` to refresh just the cart after a custom cart change.
