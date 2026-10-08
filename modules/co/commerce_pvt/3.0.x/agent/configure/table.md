<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_pvt — configuring the table

There is **no admin settings page**. You configure two things: (1) turn the table on for a product
display, and (2) tune the shipped view `commerce_pvt_form`.

## 1. Enable the table on a product

Structure → Content types is not involved — this is a Commerce **product** display. On
`admin/commerce/config/product-types/<type>/edit/display` (the product's *Manage display*) enable the
**Product Variations Table** component (added by `CommercePvtHooks::entityExtraFieldInfo()`, weight
100). Any bundle that has this component enabled renders the embedded `commerce_pvt_form` view (via a
lazy builder) on the product's canonical page.

## 2. The `commerce_pvt_form` view

Shipped as config (`config/install/views.view.commerce_pvt_form.yml`); edit it at
`admin/structure/views/view/commerce_pvt_form`. Key facts:

- **Base table** `commerce_product_variation_field_data`; **contextual filter** = product id (passed
  by the lazy builder). **Filters:** `status = 1`, variation `type = default`. **Access: none** — the
  display is only ever embedded on a product page the visitor can already view (there is no page/path
  display), and add-to-cart is a normal public Commerce action.
- **Only `default` display exists** (embed). The default view lists variation type `default`; adjust the
  type filter for other variation bundles.

### Handler options (the module's custom fields/areas)

- **Edit Quantity** field (`commerce_pvt_variation_edit_quantity`): *Combine* identical variations;
  *Allow decimal* + *Step*; *Use AJAX*; *Enhance widget* (+/- buttons) → *Read only*, *Delay the ajax
  calls* + *Update delay* (ms). The default view ships with AJAX + enhanced widget + read-only + delay
  500ms enabled.
- **Variation subtotal** field (`commerce_pvt_variation_subtotal`): currency display, strip trailing
  zeroes, empty markup (shown at qty 0).
- **Table summary** area (`commerce_pvt_table_summary`, footer): currency display, strip trailing
  zeroes.
- **Empty cart button** / **GoTo cart button** areas (footer): each has a *Button label*. Both go AJAX
  automatically when the quantity field's *Use AJAX* is on.

## 3. Optional: the summary block

Place the **Commerce PVT summary** block (`pvt_table_summary_block`) in a region via
`admin/structure/block`. For the AJAX refresher to update it after a cart change, the block instance
must have machine name **`commercepvtsummary`** (`PvtTableSummaryBlock::$pvtBlockMachineName`). Block
settings: subtotal currency display, minimum fraction digits.

## Customising the summary markup

Implement `hook_commerce_pvt_view_area_table_summary_markup_alter(&$markup, $data)` (area) or
`hook_commerce_pvt_table_summary_block_markup_alter(&$markup, $context)` (block) — both fire at module
and theme level. See `commerce_pvt.api.php`.
