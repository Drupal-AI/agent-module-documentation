<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller & access

Source: `commerce_donation_flow.routing.yml`, `src/Controller/DonationController.php`,
`src/Routing/DonationSecuredRedirectResponse.php`, `src/EventSubscriber/CartCheckoutRouteSubscriber.php`.

## Routes

| Route | Path | Handler | Access |
|-------|------|---------|--------|
| `commerce_donation_flow.donation.default` | `/donate` | `DonationController::frontController` | `_custom_access: DonationController::checkAccess` |
| `commerce_donation_flow.donation_controller_formPage` | `/donate/{commerce_order}/{step}` | `DonationController::nextStep` | `_custom_access: DonationController::checkAccess` |
| `commerce_donation_flow.donation.quick` | `/donate/{amount}/now` | `DonationController::quickDonation` | `_permission: 'make donation'`, `amount: \d+` |
| `commerce_donation_flow.donation_settings` | `admin/commerce/config/donation-settings` | `DonationSettingsForm` | `_permission: 'administer commerce_order_type'` |

## Controller flow

- **`frontController`** — landing at `/donate`. If the session has no cart, it calls
  `NewOrder::get('single', <configured donate_item_type>)`, saves the draft order, and registers it
  in the cart session; otherwise it reuses the first session cart order. It resolves the order's
  checkout flow, and for a `DonationCheckoutFlow` sets the order into the plugin
  (`conditionalOrderValue`) and computes the current step, then redirects to
  `donation_controller_formPage`.
- **`nextStep`** — renders the flow form for `{step}`, first redirecting to the order's real current
  step if the requested one is not yet reachable (via `CheckoutOrderManager::getCheckoutStepId`).
- **`quickDonation`** — creates a draft order (`NewOrder::get('single')`), sets `checkout_step`
  directly to `payment`, then sets `field_donation_amount` from the `{amount}` route value and
  saves. Registers the cart and redirects straight to the payment step. Because the route requires
  `amount: \d+`, only non-negative integers reach it (zero is possible but harmless — a $0 draft;
  no charge occurs until the gateway's payment step).
- **`constructStepRedirect`** — builds a `DonationSecuredRedirectResponse` to
  `donation_controller_formPage`, propagating a `donate_return` query arg if present.

## `checkAccess` (custom access for the two /donate render routes)

Grants access only when **all** hold:
1. The site's `donation_route` config is `donate` or `both` (`$route_check`).
2. For `donation_controller_formPage`: the order is **not** `canceled`; the requester **owns** the
   order — authenticated users by `account->id() == order->getCustomerId()`, anonymous by the cart
   session holding the order id (`CartSession::ACTIVE` or `COMPLETED`); and the order **has items**.
   Cacheable dependency on the order is added.
3. The account has the **`make donation`** permission.

So the checkout render pages enforce order ownership (own non-empty, non-canceled orders only) plus
the donation permission — anonymous donors are tied to their cart session.

## `DonationSecuredRedirectResponse`

Extends core `SecuredRedirectResponse` + `LocalAwareRedirectResponseTrait`. `isSafe()` returns true
**only** if the URI is local **and** matches `^route:commerce_donation_flow` — i.e. the flow can only
redirect to its own routes; anything else throws `InvalidArgumentException`. This is a deliberate
open-redirect guard on the flow's internal redirects.

## `CartCheckoutRouteSubscriber`

When `donation_route` is not `cart`/`both` (i.e. donate-only mode), it sets `_access: 'FALSE'` on
core `commerce_cart.page`, `commerce_checkout.checkout`, and `commerce_checkout.form` (removing their
`_permission`), disabling the standard cart/checkout UI so the site funnels through `/donate`.
