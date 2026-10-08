<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Decoupled Stripe (commerce_decoupled_stripe) — agent index

Provides **two Drupal Commerce on-site payment gateway plugins** that integrate **Stripe** with a
**decoupled (headless) checkout**. The gateways only wrap the Stripe PHP SDK (`stripe/stripe-php ^7.40`)
and the Commerce payment lifecycle — the actual REST/JSON endpoints the JS front end calls are provided
by the separate **Commerce Decoupled Checkout** project, not by this module. Depends on
`commerce:commerce_payment`. Package `Commerce (contrib)`. Core `^10.1 || ^11`. License GPL-2.0-or-later.
Installed **8.x-1.4** (version dir `8.x-1.x`).

## What it provides (from source — 3 PHP files only)

- **`StripeGatewayBase`** (abstract, extends `OnsitePaymentGatewayBase`, implements
  `SupportsAuthorizationsInterface`) — shared config form (`publishable_key`, `secret_key`), SDK init
  (`Stripe::setApiKey`), `createPaymentMethod()` (finds/creates a Stripe `Customer` by billing email;
  marks the Commerce payment method non-reusable), `deletePaymentMethod()`, `voidPayment()` (cancels the
  intent), and `toMinorUnits()` (zero-decimal-currency-aware amount conversion).
- **`StripeGateway`** — plugin id **`decoupled_stripe`**, one-off card payments. `createPayment()` builds
  a Stripe **`PaymentIntent`**; `capturePayment()` **retrieves** the intent and finalizes the Commerce
  payment. Adds config `enable_receipt_email`.
- **`StripeRecurringGateway`** — plugin id **`decoupled_stripe_recurring`**, monthly recurring via a
  Stripe **`SetupIntent`** + **`Subscription`**/`Plan`. Adds config `recurring_start_day`,
  `recurring_plan_id`, `recurring_plan_name`.

No routing, no controllers, no REST resources, no webhook, no `.services.yml`, no `.permissions.yml`,
no `config/`, no `.module`/`.install`, no config schema of its own. The gateway plugin config is stored
by Commerce's `commerce_payment_gateway` config entity.

## Payment lifecycle (decoupled flow)

1. Decoupled Checkout calls **`createPayment($payment, $capture = FALSE)`**. When `$capture` is truthy
   (the default) the method **returns immediately, doing nothing** — the intent is only created when
   called with `$capture = FALSE`. It then creates a Stripe PaymentIntent (`capture_method: automatic`)
   with the **amount taken from the server-side `$payment->getAmount()`** and `metadata.order_id` from
   `$payment->getOrderId()`. The intent's **`client_secret`** is saved as the payment's remote id (so the
   front end can read it), and the intent **id** on the payment method's remote id.
2. The JS front end confirms the card with Stripe.js using that client secret.
3. Decoupled Checkout calls **`capturePayment()`** → **`PaymentIntent::retrieve()`** (recurring:
   `SetupIntent::retrieve()`). State is set from Stripe's **authoritative** intent status: `succeeded` →
   `completed`; `canceled`/`requires_payment_method` → `authorization_voided`; otherwise `authorization`
   (or `authorization_expired` after 24h). Card brand/last4/expiry are copied from Stripe's charge.

## Solution docs

- **The two gateways, config fields, customer/currency handling, recurring subscription logic** →
  [gateways/gateways.md](gateways/gateways.md)
