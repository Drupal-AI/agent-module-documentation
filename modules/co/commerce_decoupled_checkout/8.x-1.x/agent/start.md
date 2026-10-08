<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Decoupled Checkout (commerce_decoupled_checkout) — agent index

Provides **REST API endpoints for a decoupled / headless Drupal Commerce checkout**: a separate
front end (JS SPA, mobile app) POSTs cart + customer + payment data to create a Commerce order and
process payment, instead of using Commerce's built-in multi-step checkout. Pairs with front-end
gateway integrations such as `commerce_decoupled_stripe`. Package **Commerce (contrib)**. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **8.x-1.7** (version dir `8.x-1.x`).
**Minimally maintained.**

## Dependencies
- Drupal modules (`.info.yml`): **`commerce:commerce_payment`**, **`commerce:commerce_checkout`**
  (both from Drupal Commerce). No PHP-library or Composer requirements beyond Commerce.

## What it provides (from source)
The module is **four `@RestResource` plugins** — nothing else (no routing/services/permissions YAML,
no `.module`/`.install`, no config). Endpoints are core-`rest` resources: each must be **enabled and
permission-granted** through the `rest` module before it is reachable (see below).

| Resource plugin (id) | Method + URI | Purpose |
|---|---|---|
| `OrderCreateResource` (`commerce_decoupled_checkout_order_create`) | `POST /commerce/order/create` | Create user + profile + order + order items, optionally process payment in the same call |
| `PaymentCreateResource` (`commerce_decoupled_checkout_payment_create`) | `POST /commerce/payment/create/{order_id}` | Create/initialize a payment for a draft order, optionally capture it |
| `PaymentCaptureResource` (`commerce_decoupled_checkout_payment_execute`) | `POST /commerce/payment/capture/{order_id}/{payment_id}` | Capture/finalize a previously initialized payment (lock-guarded) |
| `PaymentVoidResource` (`commerce_decoupled_checkout_payment_void`) | `POST /commerce/payment/void/{order_id}/{payment_id}` | Void an un-captured payment |

Only **on-site** (`OnsitePaymentGatewayInterface`) payment gateways are supported; off-site
redirect gateways raise an error. Payment amounts are taken server-side from the order total.

## Alter hooks (`commerce_decoupled_checkout.api.php`)
`hook_order_checkout_prepare_alter(&$data)`, `hook_decoupled_order_data_alter(&$data, &$extra_order_data)`,
`hook_decoupled_draft_order_alter(&$order, &$data)` (add promotions/coupons before payment),
`hook_decoupled_order_alter(&$order, &$data)`, `hook_payment_create_prepare_alter(&$data)`,
`hook_decoupled_checkout_create_order_error_message_alter(&$message_data)`.

## Enabling & access (important — nothing works out of the box)
These are standard Drupal REST resources, so before any endpoint responds you must, per resource:
enable it (e.g. via the REST UI module or a `rest.resource.*` config entity), select the request
format(s) and **authentication provider(s)**, and grant the auto-generated permission
(`restful post commerce_decoupled_checkout_order_create`, etc.) to the roles that may call it. A
public headless store typically grants the order/payment resources to the **anonymous** role. Serve
only over HTTPS. Review the access model for your deployment before going live.

## Solution docs
- **Order creation endpoint — payload shape, entity resolution, embedded payment** →
  [api/order-create.md](api/order-create.md)
- **Payment create / capture / void endpoints** → [api/payment-endpoints.md](api/payment-endpoints.md)
