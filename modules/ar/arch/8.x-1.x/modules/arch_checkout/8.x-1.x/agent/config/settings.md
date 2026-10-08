<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Checkout: settings, routes & the complete flow

## Settings — `CheckoutSettingsForm`

Route `/admin/store/settings/checkout` (perm `administer checkout settings`). Extends
`ConfigFormBase`, writes config **`arch_checkout.settings`**:

| Key | Ships as | Meaning |
|---|---|---|
| `plugin_id` | `onepage` | Default `checkout_type` plugin rendered at `/checkout`. |
| `anonymous_checkout` | `allow` | `allow` or `not_allowed` — may anonymous users check out. |
| `redirect_to_cart_if_empty` | `redirect_to_cart` | `redirect_to_cart` or `_none` when cart empty. |

Each non-broken checkout plugin also injects its own settings sub-form (`buildConfigurationForm`)
and gets `submitConfigurationForm` called. No config schema file is shipped for these values.

`CheckoutTypeManager` reads this config: `getDefaultCheckoutType()` returns the plugin for
`plugin_id` (falling back to the first sorted plugin), `isAnonymousCheckoutAllowed()` is
`anonymous_checkout === 'allow'`, `shouldRedirectIfCartEmpty()` is
`redirect_to_cart_if_empty === 'redirect_to_cart'`.

## Routes & access

- **`/checkout`** (`CheckoutController::checkout`): custom access `checkoutAccess()` — anonymous is
  blocked unless `isAnonymousCheckoutAllowed()`, otherwise requires `access content`. Builds the
  default checkout-type plugin's form (uncached), fires `checkout_plugin` / `checkout_page` alters.
- **`/checkout/complete/{order_id}`** (`CheckoutController::complete`): `_permission: access content`.
  `{order_id}` is upcast by `OrderIdParamConverter` (type `arch_checkout_order_id`) which loads the
  order **by id or by `order_number`** (value passed through `Xss::filter`).

## OrderIdParamConverter

`Routing\OrderIdParamConverter::convert()` — `Xss::filter($value)`, then
`orderStorage->load($id)`, else `loadByProperties(['order_number' => $id])`, else `NULL`.
Registered as a `paramconverter` service.

## The complete flow — `CheckoutController::complete()`

1. Resolve `$order` from the route.
2. Ownership: if `$order->getOwner()->getEmail() !== currentUser()->getEmail()` then throw
   `AccessDeniedHttpException` for authenticated users, or for anonymous users only when
   `!isAnonymousCheckoutAllowed()`.
3. `CheckoutCompletePageAccess::canAccess($order)` — returns FALSE (→ redirect `<front>`) unless the
   order has ≥1 product **and** status `cart` (hook `order_access_checkout_complete` may override).
4. Trigger the page-cache kill switch; instantiate the order's `payment_method`; if it implements
   `CheckoutCompleteInterface`, call `checkoutCompleteInfo($order)` for extra output.
5. Render `#theme => 'arch_checkout_complete'` (message + payment info). Alters:
   `checkout_complete_page`, and `checkout_complete_page_title` for the title.
6. Unless `hook_checkout_complete_page_should_update_order_status` returns FALSE, create a new
   revision and set status **`completed`** (target status overridable via
   `checkout_complete_order_status`), save, invoke `checkout_completed`, reset the cart.

The default `completed` status comes from `arch_order` (`config/install`), which also defines the
default `cart` status a fresh order sits in until this step runs.
