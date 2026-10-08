<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Klarna (commerce_klarna) — agent index

Integrates **Klarna** with **Drupal Commerce** as an **on-site** payment gateway (customer stays on the
Drupal checkout; a Klarna JS SDK widget authorizes the payment, then the site finalizes it through
Klarna's authenticated REST API). Covers **Klarna Payments**, **Merchant Card Service (MCS)**, cart
**Express Checkout**, and **On-site Messaging** (the "pay from X/month" promos). Package *Commerce
(contrib)*. Core `^10 || ^11`. License GPL-2.0-or-later. This is the **1.x dev branch** (no tagged
release; no `version:` in `.info.yml`). Composer: `drupal/commerce` `^2.4 || ^3`.

Do NOT confuse with the separate `commerce_klarna_checkout` and `commerce_klarna_payments` projects —
this doc is `commerce_klarna` only.

- Depends on **`commerce_payment`** (`commerce:commerce_payment`). Ships the optional submodule
  **`commerce_klarna_shipping`** (required for express checkout that collects the shipping address).
- Ships **no** `config/`, no `*.permissions.yml`, no `*.install`, no Drush commands. Gateways are
  configured through Commerce's own payment-gateway UI.

## Solution docs

- **Payment gateways, config form, payment lifecycle, method types** → [gateways.md](gateways.md)
- **`KlarnaManager` service — API client, order payload, MCS calls** → [api.md](api.md)
- **Express checkout routes/controller, JS SDK flow, on-site messaging, shipping submodule** →
  [express-checkout.md](express-checkout.md)
- **Events & event subscribers (extension points)** → [events.md](events.md)

## What it provides (from source)

- **Two payment gateway plugins** (`src/Plugin/Commerce/PaymentGateway/`), both extending
  `KlarnaPaymentsBase` (which extends core `OnsitePaymentGatewayBase`):
  - `klarna_payments` — `KlarnaPayments` (standard Klarna Payments; authorize → capture → refund →
    void via Klarna Order Management).
  - `klarna_merchant_card` — `KlarnaMerchantCard` (MCS: issues virtual cards, optional external card
    acquirer gateway, RSA/AES card decryption helper).
- **Two payment method types** (`src/Plugin/Commerce/PaymentMethodType/`): `klarna`, `klarna_merchant_card`.
- **One service** `commerce_klarna.manager` (`KlarnaManager` / `KlarnaManagerInterface`) — all Klarna
  REST calls (sessions, orders, captures, refunds, MCS promises/settlements) + order-payload builder.
- **One controller** `KlarnaExpressCheckout` with 2 POST/JSON routes (`commerce_klarna.express_checkout.create`,
  `.finalize`), both `_entity_access: commerce_order.update`.
- **Two event subscribers**: `CheckoutCompletionSubscriber` (backfills billing profile from Klarna),
  `OrderCancelSubscriber` (voids Klarna payments on order cancel). Submodule adds
  `KlarnaExpressShipments`.
- **8 events** in `KlarnaEvents` for altering request payloads / express-checkout shipments.
- **Front end**: libraries `commerce_klarna/sdk` (Klarna hosted `api.js`) and `commerce_klarna/payments`
  (`js/commerce_klarna.payments.js`); theme hook `klarna_onsite_messaging`
  (`templates/klarna-onsite-messaging.html.twig`).
- **`hook_theme` + 3 `hook_form_*_alter`** in `commerce_klarna.module` inject the Klarna widget into the
  checkout flow, the cart-view form (express button), and the add-to-cart form (messaging).

## Payment model (positive posture)

Order completion runs through **authenticated (HTTP Basic) server-side calls** to Klarna's Payments and
Order Management APIs; the amount and currency sent to Klarna are recomputed server-side from the
Commerce order. `onNotify()` is intentionally a **no-op** — the site never trusts a request-body status.
The module's own routes are per-order access controlled (`commerce_order.update`). Store Klarna API
credentials securely (a Key entity / environment-backed value; see human-docs).
