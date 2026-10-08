<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Availability — purchasability enforcement

Purchasability is driven by ONE property of the field: **`orderable`** (boolean).
The other properties (`availability_status`, `availability_date_value`,
`min_delivery_period`, `max_delivery_period`) are **display / informational only** and
by design do NOT affect whether a variation can be bought. The widget help text states
this explicitly ("this setting alone defines whether a product is purchasable";
"Availability Status ... does NOT effect the purchasability").

Enforcement happens **server-side** in two Commerce integration points, both tagged in
`commerce_product_availability.services.yml`.

## 1. Availability checker (blocks add-to-cart)

`src/AvailabilityChecker/ProductAvailabilityAvailabilityChecker.php`
implements `\Drupal\commerce_order\AvailabilityCheckerInterface`, tagged
`commerce_order.availability_checker`. Commerce's availability manager calls it when an
order item is added / its quantity changes.

- `applies()` → true only if the purchased variation has a field of type
  `commerce_product_availability_product_availability`.
- `check()` → loads the first such field; `AvailabilityResult::unavailable()` when
  `orderable` is empty, otherwise `AvailabilityResult::neutral()` (never forces
  *available*, so it composes with other checkers such as Commerce Stock).
- `getAvailabilityFieldsByOrderItem()` → returns the variation field definitions whose
  type is the availability field (used by `applies()`, the add-to-cart form alter, and
  the webform submodule). Only the **first** availability field is honored — multiple
  availability fields on one variation are not supported.

## 2. Order processor (removes unavailable items from an existing order)

`src/OrderProcessor/AvailabilityOrderProcessor.php` implements
`\Drupal\commerce_order\OrderProcessorInterface`, tagged
`commerce_order.order_processor`. It runs on every order refresh (cart view, checkout).
For each order item it rebuilds a `Context` from the order customer + store, re-runs the
checker, and if the result `isUnavailable()` calls
`CartManagerInterface::removeOrderItem($order, $orderItem, FALSE)`. This catches items
that became non-orderable *after* they were added, so an unavailable variation cannot
persist into checkout even if it was added while still orderable.

Net effect: availability is enforced at both add-to-cart and every subsequent order
recalculation, not merely hinted in the UI.

## Add-to-cart button altering (UI hint, opt-in per field)

`commerce_product_availability_form_commerce_order_item_add_to_cart_form_alter()` in the
`.module` file adjusts the add-to-cart form based on the field setting
`alter_add_to_cart_button` (default `no_altering`):

- `remove` — when not orderable, sets `#access = FALSE` on submit + quantity.
- `disable_only` — when not orderable, sets `#disabled = TRUE` on submit + quantity.
- `disable_and_alter_text` — as `disable_only`, and also rewrites the button `#value`
  from the availability-status option labels (e.g. "Preorder", "Backorder",
  "Unavailable").

This alter reads the *selected* variation (comparing `selected_variation` in form state
to the purchased entity id) so AJAX variation switching shows the right state
(issue 3469910). The button altering is cosmetic — the checker/order processor above are
what actually prevent purchase.

## Availability status options + alter hook

`commerce_product_availability_get_availability_status_options()` (in `.module`) returns
the base statuses `in_stock`, `out_of_stock`, `preorder`, `backorder` and invokes
`hook_commerce_product_availability_availability_status_alter(&$options)`
(see `commerce_product_availability.api.php`) so other modules can add/remove statuses.
