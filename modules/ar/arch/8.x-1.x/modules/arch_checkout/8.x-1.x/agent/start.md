<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout (arch_checkout) — agent index

Checkout framework for the Arch suite. Depends on `arch_order` (runtime: `arch_cart`,
`arch_payment`). Part of project `arch` (`8.x-1.0-alpha26`). Submodule: `arch_onepage`.

- **Settings, routes, the complete flow** → [config/settings.md](config/settings.md)
- **The `checkout_type` plugin type** → [plugins/checkout-type.md](plugins/checkout-type.md)

## Provides

- Plugin type **`checkout_type`** — manager `plugin.manager.checkout_type`
  (`CheckoutType\CheckoutTypeManager`), annotation `@CheckoutType`, base `CheckoutType`, interface
  `CheckoutTypePluginInterface`, fallback `broken`. `arch_onepage` supplies the `onepage` plugin.
- Routes (`arch_checkout.routing.yml`):
  - `arch_checkout.checkout` `/checkout` — `CheckoutController::checkout` (custom access
    `CheckoutController::checkoutAccess`).
  - `arch_checkout.complete` `/checkout/complete/{order_id}` — `CheckoutController::complete`
    (`_permission: access content`; `{order_id}` upcast by `OrderIdParamConverter`, type
    `arch_checkout_order_id`).
  - `arch_checkout.admin_settings` `/admin/store/settings/checkout` — `CheckoutSettingsForm`
    (perm `administer checkout settings`).
- Services: `plugin.manager.checkout_type`, `arch_checkout.order_id_param_converter`
  (`Routing\OrderIdParamConverter`), `arch_checkout.checkout_complete_page.access`
  (`Services\CheckoutCompletePageAccess`).
- Permission **`administer checkout settings`**.
- Config **`arch_checkout.settings`**: `plugin_id` (default checkout type, ships `onepage`),
  `anonymous_checkout` (`allow` | `not_allowed`; **ships `allow`**), `redirect_to_cart_if_empty`
  (`redirect_to_cart` | `_none`; ships `redirect_to_cart`). No config schema shipped.
- Element `Element\CheckoutAddress`; interface `Controller\CheckoutCompleteInterface`
  (a payment method implements it to add complete-page info).
- Alter hooks (`arch_checkout.api.php`): `checkout_plugin`, `checkout_page`,
  `checkout_complete_page`, `checkout_complete_page_title`, `checkout_complete_order_status`,
  `checkout_completed`, `checkout_complete_page_should_update_order_status`.

## Complete flow (important)

`complete()` loads the order, checks ownership (`owner email === current-user email`),
then `CheckoutCompletePageAccess::canAccess()` (requires order status `cart` and ≥1 product),
kills the page cache, renders `arch_checkout_complete`, and — unless a hook vetoes it — sets the
order status to **`completed`** in a new revision. Payment gateways (`arch_payment_*`) redirect
here after their own success step.
