<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce: Admin Checkout (commerce_admin_checkout) — agent index

Lets a store **administrator drive the normal customer-facing Commerce checkout form to build and
complete an order on behalf of a customer** (assisted / phone / in-person sales), reusing your
existing checkout flow instead of a separate admin order-entry screen. It works by adding checkout
panes and a custom access check to the standard `commerce_checkout.form` route. Package `Commerce`.
Core `^10.1 || ^11`. License GPL-2.0-or-later. Installed **3.1.0** (version dir `3.1.x`).

## Dependencies

- Drupal modules (from `.info.yml`): **`commerce_checkout`**, **`commerce_order`** (Drupal Commerce).
- No PHP-library or Composer requirements (no `composer.json` ships in the module).
- The project page states it needs a Commerce **core patch** from issue
  [#3204694](https://www.drupal.org/project/commerce/issues/3204694); this is a drupal.org
  install note, not enforced in code.
- Optional submodule **`commerce_admin_payment`** (documented under
  [modules/commerce_admin_payment/](../modules/commerce_admin_payment/3.1.x/agent/start.md)).

## What it provides (from source)

- **Custom access on the checkout route.** `Routing/RouteSubscriber` replaces the `_custom_access`
  requirement of core `commerce_checkout.form` with `CheckoutAccessHandler::checkAccess`. That
  handler first delegates to core's `CheckoutController::checkAccess`; only if core is *neutral*
  (the current user does not own the cart) does it grant access — and only when the user is
  authenticated and holds `access checkout as a different user` **or** `edit cart items during
  checkout`, plus core `access checkout`. So admin-acting-as-customer is gated behind explicit
  permissions.
- **Two checkout panes** (`src/Plugin/Commerce/CheckoutPane/`):
  - `commerce_admin_checkout_order_assign` (**Assign Order to Customer**) — visible only with
    `access checkout as a different user` **and** `administer users`.
  - `commerce_admin_checkout_order_items` (**Order Items**) — visible only with `edit cart items
    during checkout`; configurable allowed order-item types.
- **Two `FormElement` plugins** (`src/Element/`) that back those panes: `commerce_admin_checkout_order_assign_form`
  (search/select or create-and-assign a customer, dispatches an assign event) and
  `commerce_admin_checkout_order_items_form` (add/update/remove order items via inline entity form
  in the `commerce_admin_checkout` order-item form mode).
- **Settings form** `commerce_admin_checkout.settings` at `/admin/commerce/config/orders/admin-checkout`
  (`Form/ConfigForm`, permission `configure admin checkout settings`). Single setting
  `override_admin_order_create`: when on, `RouteSubscriber` repoints `entity.commerce_order.add_page`
  at `CartController::createNewCartAndRedirectToCheckout` so the standard "Add order" button starts
  an admin checkout instead.
- **CartController** (`src/Controller/CartController.php`) — creates a fresh cart (owned by anonymous
  when the user can `access checkout as a different user`, else by the current user) and redirects to
  the checkout form.
- **Order-assign event** — `AdminCheckoutEvent::CHECKOUT_ASSIGN` dispatched by the assign form;
  `EventSubscriber/AdminCheckoutEventSubscriber` performs the actual `setCustomer()` / `setEmail()` /
  `save()` (priority 100), so other modules can react to (or override) assignment.
- **Permissions** (`.permissions.yml`, all admin-assigned): `access checkout as a different user`,
  `edit cart items during checkout`, `override line item prices during checkout`, `configure admin
  checkout settings`. `commerce_admin_checkout.module` hides the unit-price override/amount widgets
  (`hook_field_widget_complete_form_alter`) from users lacking `override line item prices during
  checkout`.
- **Config**: default `commerce_admin_checkout.settings` (`override_admin_order_create: false`);
  schema for settings + the order-items pane; an optional `commerce_admin_checkout` order-item form
  mode (installed via `hook_update_8001`); an optional entity-reference view
  `commerce_admin_checkout_variations` (Active Product Variations) used for purchased-entity
  autocomplete. Theme hooks + one CSS library (`order-items-pane`) style the item pane.

## Solution docs

- **Checkout panes, form elements, access handler, cart controller, assign event** →
  [checkout-flow.md](checkout-flow.md)
- **Settings form, `override_admin_order_create` route override, permissions, price gating** →
  [config-and-access.md](config-and-access.md)
- **Submodule (admin manual payments)** →
  [modules/commerce_admin_payment/](../modules/commerce_admin_payment/3.1.x/agent/start.md)
