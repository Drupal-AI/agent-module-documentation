<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Estimate (commerce_cart_estimate) — agent index

A Drupal Commerce module that adds an inline **"estimate shipping & tax" form to the cart page**.
The shopper picks a **country** and enters a **postal code**; the module rates the cart against
that partial address and swaps the order total summary for an **estimated total** — all before
checkout, without ever writing to the real order. Package `Commerce (contrib)`. Core
`^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Installed **2.0.5** (version dir `2.x`).

## Dependencies

- Drupal module: **`commerce_shipping`** (required, from `.info.yml`). Composer requires
  `drupal/commerce_shipping:^2.12 || ^3`. Pulls in Commerce, Address, Profile transitively.
- No PHP library requirements of its own.

## What it provides (from source)

- **Views area handler** `commerce_cart_estimate` (`Plugin/views/area/CartEstimate.php`,
  `@ViewsArea`). Registered on the `commerce_order` Views table via
  `hook_views_data_alter` in the `.module`. You add it to the cart form view
  (`admin/structure/views/view/commerce_cart_form`, typically the Footer). It renders the
  estimate form (country + postal code + Estimate/Clear buttons) as a Views **form**, with
  configurable options: `show_clear_button`, `confirmation_message`, `estimate_button_label`,
  `container_element` (fieldset|details), `container_label`, `container_description`
  (defaults in `defineOptions()`; schema in `config/schema/commerce_cart_estimate.schema.yml`).
- **Estimator service** `commerce_cart_estimate.estimator` (`Estimator` implements
  `EstimatorInterface`). `buildShippingProfile()` builds a shipping profile from the partial
  address; `estimate()` does the rating. Returns a `CartEstimateResult` (rated order + rates).
- **Custom order-refresh service** `commerce_cart_estimate.order_refresh` (`OrderRefresh`,
  implements `OrderRefreshInterface`) — a stripped-down refresh that runs the collected
  Commerce order preprocessors/processors on the fake order so shipping/tax adjustments apply,
  but is explicitly designed **never to save**. Tagged as a `service_collector` for both
  `commerce_order.order_preprocessor` and `commerce_order.order_processor`.
- **Save guards** (defense in depth so an estimate can never persist):
  - `EventSubscriber/OrderSubscriber` — on `OrderEvents::ORDER_PRESAVE`, throws
    `OrderSaveException` if the order is flagged as an estimate.
  - `EventSubscriber/ShipmentSubscriber` — on `ShippingEvents::SHIPMENT_PRESAVE`, throws
    `ShipmentSaveException` for a shipment whose order is an estimate.
  - `CommerceCartEstimateServiceProvider::alter()` swaps `commerce_shipping.late_order_processor`
    for the module's `LateOrderProcessor`, whose `shouldSave()` returns FALSE for estimate orders
    (prevents shipment saves during refresh).
- **Extensibility event** `commerce_cart_estimate.select_shipping_rate`
  (`Event/CartEstimateEvents::SELECT_SHIPPING_RATE`, `Event/SelectShippingRateEvent`) — lets other
  code choose which shipping rate is applied to the estimate (default is the first returned rate).
- **Theme** `commerce_cart_estimate_summary` + template
  `templates/commerce-cart-estimate-summary.html.twig` — renders the estimated totals with an
  "Estimated total" label instead of "Total". Preprocess in `.module` calls
  `commerce_order.order_total_summary`. CSS library `commerce_cart_estimate/form`.
- **Logger channel** `logger.channel.commerce_cart_estimate`.
- No permissions, no routes/controllers, no install/update hooks, no Drush commands, no config
  entity. Configuration is entirely the Views area handler's options.

## How the estimate works (mechanism)

1. `viewsForm()` loads the current cart order from the view's contextual argument
   (`$this->view->argument['order_id']`), bails if the order is not shippable, and builds the
   form. Country options come from the store's **Shipping countries**; postal/country default to
   the order's shipping profile address, else the store address.
2. On submit, `viewsFormValidate()` builds a shipping profile from the entered
   country/postal code, validates the postal code (address constraint violations become form
   errors), then calls `Estimator::estimate()`.
3. `estimate()` operates on a **`$order->createDuplicate()`** ("fake order") flagged
   `commerce_cart_estimate = TRUE`. It packs shipments against the partial profile, calculates
   rates, applies a rate (via the select-rate event), runs the custom `OrderRefresh` (marked
   `commerce_cart_estimate_refresh`), and recalculates the total — **never saving**.
4. The rated fake order is stashed in **form state only** (`$form_state->set('rated_order', …)`).
   `ajaxRefresh()` replaces the order-total-summary region with the estimated-summary theme, then
   nulls the stashed order. The **Clear** button restores the real order's total summary.

The estimate is **display-only**: the real cart order and its total are never modified by the
estimate, so checkout recomputes shipping/tax from the customer's actual address.

## Tests

`tests/src/Kernel/EstimatorTest.php` (kernel test of the estimator) plus a test-only fixture
module `commerce_cart_estimate_test` (under `tests/modules/`, provides a
`SelectShippingRateSubscriber`). The fixture is test-only — not a shippable submodule.
