<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_pvt — internals

All request context comes from `$this->routeMatch->getParameter('commerce_product')`; a handler renders
nothing unless it is on a `commerce_product` canonical page. Order type is resolved from the product's
**default variation** via `CommercePVTCommonTrait::getOrderType()` (chain order-item-type resolver →
create a throwaway `commerce_order_item` → chain order-type resolver). The cart is fetched with
`cartProvider->getCart($order_type, $currentStore)`.

## EditVariationQuantity (`commerce_pvt_variation_edit_quantity`)

`src/Plugin/views/field/EditVariationQuantity.php`. `getValue()` returns a Views form placeholder
comment; `query()` is a no-op (pure form field).

**`viewsForm()`** — for each result row builds a `#type => 'number'` input named
`variation:<variation_id>` (`#min 0`, `#max 9999`, `#step` from the *allow decimal* + *step* options),
pre-filled from the current cart quantity. When **Enhance widget** is on, the number is wrapped with
`minus`/`plus` markup + a hidden per-row `Update` submit (`#alter_variation => TRUE`, AJAX callback
`updatePageElements`) themed by `commerce_pvt_enhanced_widget`; the main submit is hidden
(`#access = FALSE`) and the `commerce_pvt/enhanced-widget` library + `drupalSettings.commerce_pvt.delay`
are attached. Main submit label flips to *Update variations quantitites* vs *Add variations to cart*
depending on whether the product already has items in the cart; when **Use AJAX** is on the form is
wrapped in `.commerce-pvt-ajax-form-wrapper` and the submit gets the `updatePageElements` AJAX callback.

**`viewsFormSubmit()`** — two branches keyed off the triggering element:

- `#manage_cart` (bulk submit): scans `$form_state->getUserInput()` for keys containing `variation:`,
  parses `variation:<id>` → `floatval(quantity)`. If the total is > 0 it creates the cart if needed and,
  per variation, either updates/removes an existing order item (when `#update_cart`) or creates+adds a
  new order item (`cartManager->createOrderItem($variation, $quantity)` — price computed server-side).
  Non-numeric values are skipped. Saves the cart, clears caches, and either rebuilds (AJAX) or shows a
  status message.
- `#alter_variation` (per-row Update from the enhanced widget): reads the single `variation:<id>` input,
  then adds / updates (`setQuantity`) / removes (qty 0) that one order item.

The `combine` option is passed to `cartManager` add/remove so identical variations merge. `Cart::save()`
runs the normal Commerce order refresh/pricing.

## VariationSubtotal (`commerce_pvt_variation_subtotal`)

`src/Plugin/views/field/VariationSubtotal.php`. Read-only. `viewsForm()` looks up the matching order
item in the cart and renders `getTotalPrice()` via `commerce_price.currency_formatter` (options:
currency display, strip trailing zeroes, empty markup for qty 0). `viewsFormSubmit()` is a no-op.

## Area handlers

- **TableSummary** (`src/Plugin/views/area/TableSummary.php`) — footer summary; sums this product's
  order-item quantities/totals from the cart into a `FormattableMarkup` line, then invokes
  `hook_commerce_pvt_view_area_table_summary_markup_alter()` (module + theme). Attaches
  `commerce_order/total_summary`. `render()` returns `[]`; the output is built in `viewsForm()` footer.
- **EmptyCartButton** (`src/Plugin/views/area/EmptyCartButton.php`) — shown only when this product has
  cart items; submit removes every order item whose product == current product, then deletes the cart if
  it becomes empty (else saves) and clears caches. AJAX callback `updatePageElements` when AJAX is on.
- **GoToCartButton** (`src/Plugin/views/area/GoToCartButton.php`) — submit sets a redirect to
  `commerce_cart.page`; the AJAX variant `viewsFormSubmitAjax()` returns a `RedirectCommand` (or the
  refresh response if the form has errors).

## PvtTableSummaryBlock (`pvt_table_summary_block`)

`src/Plugin/Block/PvtTableSummaryBlock.php`. Same summary as TableSummary but as a block; `build()`
sets `max-age 0` + `user`/`session`/`cart` contexts and cart cache tags, and fires
`hook_commerce_pvt_table_summary_block_markup_alter()`. Block form: currency display + minimum fraction
digits. Static `$pvtBlockMachineName = 'commercepvtsummary'` is the id the refresher reloads.

## RefreshPageElementsHelper + AJAX callback

`src/RefreshPageElementsHelper.php` (service `commerce_pvt.refresh_page_elements_helper`). Fluent
`updatePageElements($form)` chains: `updateForm()` (`ReplaceCommand .commerce-pvt-ajax-form-wrapper`) →
`updateStatusMessages()` (re-render `system_messages_block` for the active theme) →
`updateCart()` (`ReplaceCommand .cart--cart-block` with a fresh `commerce_cart` block) →
`updateSummaryBlock()` (`ReplaceCommand .block-pvt-table-summary`). The static
`CommercePVTCommonTrait::updatePageElements()` is the `#ajax` callback that fetches the service and
returns `getResponse()`.

## Enhanced-widget JS

`js/enhanced-widget.js` (`Drupal.behaviors.enhancedEditQuantityWidget`). On each
`.commerce-pvt-enhanced-widget`: `-`/`+` clamp the number between `min`/`max` (step-aware) and trigger
a **debounced** click on the hidden Update submit (delay from `drupalSettings.commerce_pvt.delay`, def
200ms), so rapid clicks fire one AJAX update. Read-only inputs get no `change` handler. Uses
`core/once`.
