<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Klarna Payments (commerce_klarna_payments) — agent index

Drupal Commerce **off-site payment gateway** for **Klarna Payments** (the "Klarna as one option at
checkout" integration — distinct from `commerce_klarna` and `commerce_klarna_checkout`). Customer pays
through Klarna's JS widget which yields an **authorization token**; the module creates the Klarna order
server-side and reconciles status by calling back to Klarna's **authenticated** APIs. Version
**3.0.0-beta7**. Core `^9.4 || ^10 || ^11`, PHP `>=8.0`.

Key facts:
- Single gateway plugin id **`klarna_payments`** (`OffsitePaymentGatewayBase`; supports authorizations,
  notifications, refunds). No global settings page (`configure` = null) — configured per gateway entity
  at `/admin/commerce/config/payment-gateways`.
- Depends on `commerce:commerce_payment`, `commerce:commerce_price`, `drupal:system (>=9.4)`. Composer
  also pulls `tuutti/php-klarna-payments ^3.0` + `tuutti/php-klarna-ordermanagement ^2.0`,
  `webmozart/assert`, `drupal/commerce ^2||^3`.
- Two own routes: `commerce_klarna_payments.redirect` (checkout access) and
  `commerce_klarna_payments.push` (POST). Also uses the standard `commerce_payment.checkout.return` and
  `commerce_payment.notify` routes.
- Defines **no permissions**, **no drush commands**, **no plugin types**, **no submodules**. Ships config
  schema. Provides 11 alter events.

Payment authenticity (correct posture): the order is marked paid only after the module **re-fetches the
Klarna order from Klarna's authenticated Order Management API** (`ApiManager::getOrder()`, keyed by the
stored `klarna_order_id`) and confirms status is `AUTHORIZED`/`PART_CAPTURED`/`CAPTURED`. Amounts posted
to Klarna and the Commerce payment amount are computed **server-side from the Commerce order**, never
from the request. The async push, the browser return, and the fraud notify webhook are each bound to
`this` order via the Klarna-generated `klarna_order_id` (strict comparison). So a forged push/return
cannot mark an order paid or under-price it.

What you'd do:
- **Checkout → authorize → return/push/capture flow, routes & callbacks** → [flow.md](flow.md)
- **Gateway config keys, services, alter events, dependencies** → [api.md](api.md)

> Live Klarna calls need real API credentials. Store `username`/`password` as secrets (Key entity /
> env), select the correct **region** (`eu`/`na`/`oc`) and **mode** (test vs live), and ground local
> work in the `commerce_payment_gateway.<id>` config entity with `test`-mode placeholder credentials.
> This release is a beta and marked *not covered* by Drupal's SA policy — test end-to-end before going
> live.
