<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Order Item SKU stores each purchased entity's SKU directly on the Commerce order item so it survives later product changes.

---

Commerce Order Item SKU **persists the purchased entity's SKU on the order item** at purchase time.
In stock Drupal Commerce an order item references the product variation and reads its SKU on demand,
so editing or deleting that variation rewrites what your order history appears to show. This module
adds an opt-in order-item-type **trait** ("Store purchased entity SKU") that provides a `sku` field on
the order item, plus a settings form that lets you choose **when** the SKU is captured — on cart add,
on order-item presave, on order placement, on purchased-entity deletion, or not at all — and two
optional switches that re-synchronise the stored SKU when the product's SKU or the item's
purchased-entity reference changes (while preserving manual overrides). A companion field formatter
displays the stored SKU, falling back to the live purchased-entity SKU when nothing is stored yet. It
depends on Commerce and Commerce Order (3.x+) and requires the purchasable entity to have a string
`sku` field.

---

- Keep the exact SKU a customer bought on the order, even after the variation's SKU is edited later.
- Preserve SKUs in order history when a product variation is deleted.
- Add a stored `sku` field to an order item type by enabling the "Store purchased entity SKU" trait.
- Capture the SKU automatically when an item is added to the cart (`order_item_add` strategy).
- Capture the SKU when a new order item is first saved (`order_item_presave`, the default strategy).
- Capture SKUs for all items at order placement (`order_placed` strategy).
- Stamp SKUs onto existing order items when a purchasable entity is deleted (`purchased_entity_delete`).
- Disable automatic capture and set the SKU yourself in custom code (`none` strategy).
- Re-sync the stored SKU when a product/variation's SKU is edited (opt-in checkbox).
- Re-sync the stored SKU when an order item's purchased-entity reference is swapped (opt-in checkbox).
- Batch back-fill the SKU on all order items referencing a product that was just edited or deleted.
- Preserve manually overridden order-item SKUs during automatic re-sync.
- Display the stored SKU on order/invoice views with the "SKU or purchased entity SKU" formatter.
- Fall back to the live product SKU in the formatter when no SKU is stored on the item.
- Enforce that the trait is only enabled on order item types whose purchasable entity has a string SKU.
- Report SKUs reliably for accounting and fulfilment against historical orders.
- Configure the capture strategy per site from one settings form under Commerce configuration.
- Hide the stored SKU field on the order-item form so staff cannot edit it by hand.
- Support Drupal 10.3+ / 11 stores running Commerce and Commerce Order 3.x.
