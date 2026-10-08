<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Fee provides a UI for defining fees — surcharges added to a Drupal Commerce order under configurable conditions, the mirror image of Commerce promotions.

---

A fee is a `commerce_fee` content entity (base table `commerce_fee`, admin permission `administer commerce_fee`) that pairs a **fee-offer plugin** with **commerce conditions**, exactly like a promotion pairs an offer with conditions — except a fee produces a *positive* `fee`-type `Adjustment` rather than a negative discount. Each fee stores a `plugin` field (a `commerce_plugin_item:commerce_fee` reference to one offer plugin), a `conditions` field (unlimited `commerce_plugin_item:commerce_condition` targeting `commerce_order`), a `condition_operator` (AND/OR), required `order_types` and `stores` references, a `start_date`/`end_date` window, and a `status` flag. Four offer plugins ship (plugin type `commerce_fee.fee`, manager `plugin.manager.commerce_fee`, namespace `Plugin/Commerce/Fee`, `#[CommerceFee]` attribute / `@CommerceFee` annotation): `order_fixed_amount` and `order_percentage` (subclasses of `OrderFeeBase`, target `commerce_order`, split the fee across order items via `commerce_order.price_splitter`) and `order_item_fixed_amount` and `order_item_percentage` (subclasses of `OrderItemFeeBase`, target `commerce_order_item`, carry their own inner product conditions so they only hit matching items). The `commerce_fee.fee_order_processor` service (`FeeOrderProcessor`, tagged `commerce_order.order_processor` priority **120**, `adjustment_type: fee`) runs during every order refresh: `FeeStorage::loadAvailable()` pre-filters enabled fees by store, order type, and the calculation-date window with an entity query; `Fee::available()` re-checks the same; `Fee::applies()` evaluates the `ConditionGroup`; and `Fee::apply()` calls the offer plugin, which appends an `Adjustment` of type `fee` (label = the fee's `display_name` or "Fee", `source_id` = the fee id) to the order or each matching order item. There is no config schema and no config-entity storage — fees are content, editable at `/admin/commerce/fees` via `FeeForm`, and the module also registers fees as referenceable plugin types and strips redundant `order_store`/`order_type` conditions from the condition UI.

---

- Add a flat credit-card surcharge to every order in a store.
- Apply a percentage service fee on the order subtotal.
- Charge a small-order handling fee below a spending threshold (via an order-total condition).
- Add a per-product environmental levy to matching order items only.
- Charge a percentage eco-fee on a specific product category.
- Add a rush/expedite fee gated by a customer-selected option.
- Apply a booking or reservation fee to a particular order type.
- Restrict a fee to one store in a multi-store setup.
- Add a fee that is valid only during a promotional/seasonal date window.
- Combine several conditions with AND so all must pass before the fee applies.
- Combine conditions with OR so any single match triggers the fee.
- Add a payment-method surcharge (via a commerce payment-gateway condition).
- Let finance change a fee amount through the admin UI without a code deploy.
- Show a customer-facing fee label distinct from the internal admin name.
- Add a description explaining the fee in the order summary.
- Split an order-level fee proportionally across line items for correct VAT/refund handling.
- Apply multiple stacked fees to a single order.
- Disable a fee temporarily without deleting it (status toggle).
- Duplicate an existing fee as a template for a new one.
- Extend with a custom fee-offer plugin for bespoke fee logic.
- Translate fee names and display names for multilingual stores.
- Target only order items matching product conditions with an order-item fee.
- Add a delivery/handling surcharge keyed to a shipping-related condition.
- Report on applied fees through the `fee` adjustment type stored on orders.
