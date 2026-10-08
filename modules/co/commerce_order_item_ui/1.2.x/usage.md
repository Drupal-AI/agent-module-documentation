<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Order Item UI adds a standalone admin interface for Drupal Commerce **order items**, letting staff list, add, edit, duplicate and delete the line items of an order directly instead of only through the order edit form's inline entity form.

---

The module adds no entities or config of its own; it augments the existing `commerce_order_item` entity type. In `hook_entity_type_alter()` it attaches a custom `route_provider` (`OrderItemRouteProvider`, extending Commerce's admin route provider), a `list_builder`, dedicated add/edit/duplicate/delete form classes, and a set of link templates rooted under each order: `collection` (`/admin/commerce/orders/{commerce_order}/order-items`), `add-page`, `add-form`, `edit-form`, `duplicate-form` and `delete-form`. A local task tab ("Order Items") and an "Add order item" action link surface these routes, and `hook_entity_operation()` adds an *Order Items* operation to each order row on the order listing. Because order items are always reached through an order, two custom access checkers (`_order_item_collection_access` and `_order_item_create_access`) derive the allowed order-item types from the order and grant access to users holding `administer commerce_order`, `access commerce_order overview`, or the per-bundle `manage <type> commerce_order_item` permission (all defined by Commerce, not this module). It also refines the add form: `hook_entity_bundle_field_info_alter()` limits each order-item type's `purchased_entity` reference to the product variation types actually mapped to that order-item type, preventing editors from attaching the wrong variation.

---

- Give customer-service staff a dedicated tab to manage the line items on any order.
- Add a product/line item to an existing order without editing the whole order form.
- Edit the quantity, unit price or title of a single order item in isolation.
- Duplicate an existing order item to quickly add a similar line.
- Delete an erroneous line item from an order with a confirmation step.
- Provide a clean order-items listing per order via a local task tab.
- Reach order-item management from an *Order Items* operation on the order list page.
- Restrict which product variation types can be added for each order-item type on the add form.
- Let support agents amend orders placed over the phone by adding items manually.
- Correct a mispriced line by editing just that order item.
- Add a manual adjustment line item to an order during dispute resolution.
- Grant limited staff the per-type `manage <type> commerce_order_item` permission to edit only certain line items.
- Build back-office workflows that create orders and then populate their items through a stable admin URL.
- Add promotional or comped items to an order after checkout.
- Manage subscription or license order items outside the customer checkout flow.
- Let warehouse staff adjust order contents before fulfillment.
- Add a replacement item to an order without cancelling and recreating it.
- Audit and clean up leftover order items on abandoned draft orders.
- Provide deep-linkable admin URLs to a specific order's item add form for internal tools.
- Skip the order-item-type chooser automatically when only one order-item type exists.
