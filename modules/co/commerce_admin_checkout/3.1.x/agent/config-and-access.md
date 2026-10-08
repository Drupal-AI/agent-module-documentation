<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, route override & permissions

## Settings form

Route `commerce_admin_checkout.settings` → `/admin/commerce/config/orders/admin-checkout`
(`Form/ConfigForm`, `ConfigFormBase`), permission `configure admin checkout settings`. Menu link
under **Commerce → Configuration → Orders**.

Config object `commerce_admin_checkout.settings` (default in `config/install`,
schema in `config/schema`):

| key | type | default | effect |
|-----|------|---------|--------|
| `override_admin_order_create` | boolean | `false` | Replace the admin "Add order" page with the customer-facing checkout process. |

On submit, `ConfigForm` saves the value and calls `router.builder->rebuild()` so the route change
takes effect immediately.

## The `override_admin_order_create` route override

`Routing/RouteSubscriber::alterRoutes()` reads the setting and, when true and the route exists,
repoints `entity.commerce_order.add_page`'s `_controller` to
`\Drupal\commerce_admin_checkout\Controller\CartController::createNewCartAndRedirectToCheckout`. The
route's existing access requirements are left intact (still core order-add access); only the
controller changes, so clicking "Add order" starts an admin checkout cart instead of the default
order-add form.

## Permissions (`commerce_admin_checkout.permissions.yml`)

| permission | `restrict access` | gates |
|------------|-------------------|-------|
| `access checkout as a different user` | true | The admin path in `CheckoutAccessHandler`; anonymous cart ownership in `CartController`; visibility of the Assign-Order pane (with `administer users`). |
| `edit cart items during checkout` | (not set) | The admin path in `CheckoutAccessHandler`; visibility of the Order-Items pane. |
| `override line item prices during checkout` | true | Whether the unit-price override/amount widgets are shown (see below). |
| `configure admin checkout settings` | true | The settings form route. |

Creating a new customer account from the Assign-Order pane additionally requires core
`administer users` (part of that pane's `isVisible()`).

## Price-override gating

`commerce_admin_checkout.module` implements `hook_field_widget_complete_form_alter()`: for inline
entity forms in the `commerce_admin_checkout` order-item form mode, if the current user lacks
`override line item prices during checkout`, it sets `#access = FALSE` on each `commerce_unit_price`
widget's `override` and `amount` sub-elements (so Form API neither renders nor accepts a submitted
value for them). It also re-enables the `purchased_entity` `target_id` field. `hook_module_implements_alter()`
moves this module's `field_widget_form_alter` to run last.

## Form mode & views config

- `hook_update_8001` (`.install`) writes the optional `core.entity_form_mode.commerce_order_item.commerce_admin_checkout`
  form mode used by the Order-Items pane's inline entity forms.
- `config/optional/views.view.commerce_admin_checkout_variations` is an entity-reference-only view
  (displays: default + `entity_reference`; no page/URL) listing active product variations, used for
  purchased-entity autocomplete.
