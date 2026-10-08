<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout panes, form elements, access & assignment

All of this module's runtime behaviour lives inside the standard Commerce checkout flow
(`commerce_checkout.form`). You enable it by adding its panes to a checkout flow at
**Commerce → Configuration → Checkout flows** and granting the permissions below.

## Access to the checkout form

`Routing/RouteSubscriber::alterRoutes()` calls
`$route->setRequirement('_custom_access', '\Drupal\commerce_admin_checkout\CheckoutAccessHandler::checkAccess')`
on `commerce_checkout.form`, **replacing** core's own custom-access check.

`CheckoutAccessHandler::checkAccess($route_match, $account)`:

1. Runs core `CheckoutController::checkAccess()` first.
2. If (and only if) that result is **neutral** — i.e. the user is not the owner of the cart order,
   so core would not grant on its own — it re-computes:
   - `customer_check` = authenticated **and** (`access checkout as a different user` **or**
     `edit cart items during checkout`);
   - `items_check` = order has items **or** `edit cart items during checkout`;
   - result = `allowedIf(customer_check)` AND `allowedIf(items_check)` AND
     `allowedIfHasPermission($account, 'access checkout')`, with the order as a cache dependency.

Net effect: normal customers still reach only their own checkout (core path); an admin reaches any
order's checkout only with the dedicated permissions.

## Pane: Assign Order to Customer

`Plugin/Commerce/CheckoutPane/AdminOrderAssignPane` (`id = commerce_admin_checkout_order_assign`,
default step `order_information`). `isVisible()` requires **both** `access checkout as a different
user` **and** `administer users`. It renders the `commerce_admin_checkout_order_assign_form` element.

`Element/AdminCheckoutOrderAssignForm`:
- Radios "Existing customer" / "New customer".
- **Existing**: `entity_autocomplete` (user, anonymous excluded). The "Assign Order to Customer"
  submit runs `ajaxAssignOrder()`, which loads the chosen user and dispatches
  `AdminCheckoutEvent::CHECKOUT_ASSIGN`.
- **New**: email + optional generated/typed password. "Create Customer Account and Assign Order"
  runs `ajaxCreateCustomerAssignOrder()`, which `User::create([... 'status' => TRUE])`, sends the
  `register_admin_created` mail, then sets the order's customer/email. `validateForm()` rejects an
  email that already belongs to a user.

## Assignment event

`Event/AdminCheckoutEvent` (constant `CHECKOUT_ASSIGN = 'commerce_admin_checkout.order.assign'`)
carries the order, target account, form and form state. `EventSubscriber/AdminCheckoutEventSubscriber::onAdminCheckoutOrderAssign()`
(priority 100) does the assignment: `setCustomer()`, `setEmail()`, `save()`. Subscribe with a
higher priority to alter or veto assignment.

## Pane: Order Items

`Plugin/Commerce/CheckoutPane/AdminOrderItemsPane` (`id = commerce_admin_checkout_order_items`).
`isVisible()` requires `edit cart items during checkout`. Config form exposes `order_item_types`
(checkboxes) — the order-item bundles an admin may add; empty = all types. `submitPaneForm()`
persists each row via `AdminCheckoutOrderItemsForm::updateOrderItem()`.

`Element/AdminCheckoutOrderItemsForm`:
- Lists each order item as an `inline_entity_form` (`commerce_order_item`, form mode
  `commerce_admin_checkout`) with **Update** / **Remove** ajax buttons; a "new" row with an
  order-item-type select + **Add**.
- `ajaxAddOrderItem()` creates an order item at price 0 and attaches it. `ajaxUpdateOrderItem()` /
  `ajaxRemoveOrderItem()` operate by the order-item id embedded in the triggering element's parents.
- `updateOrderItem($id, $values)` rebuilds the `Price` from submitted `unit_price` and calls
  `setUnitPrice($price, <override flag>)`; a quantity of 0 removes+deletes the item.
- `validateForm()` blocks advancing checkout when the order has no items.

## Cart creation & the order-add override

`Controller/CartController::createNewCartAndRedirectToCheckout()` creates a new cart order and
redirects to `commerce_checkout.form`. The cart is owned by **anonymous** when the user has
`access checkout as a different user` (so it can later be assigned), otherwise by the current user.
This controller is only wired up when the `override_admin_order_create` setting is enabled — see
[config-and-access.md](config-and-access.md).

## Theming

`hook_theme()` registers `commerce_admin_checkout_order_items_form`,
`commerce_admin_checkout_order_assign_form`, `commerce_admin_checkout_review`. Templates live in
`templates/`; the item pane attaches the `commerce_admin_checkout/order-items-pane` CSS library.
