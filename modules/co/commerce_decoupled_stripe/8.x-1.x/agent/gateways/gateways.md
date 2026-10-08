<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateways: configuration & lifecycle

Two `@CommercePaymentGateway` plugins, both extending `StripeGatewayBase`
(`OnsitePaymentGatewayBase` + `SupportsAuthorizationsInterface`). Configure them at
**Commerce → Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`).

## Configuration fields

Shared (from `StripeGatewayBase::buildConfigurationForm`), both required text fields:

- **`publishable_key`** — Stripe publishable key (used client-side).
- **`secret_key`** — Stripe secret key; `init()` runs `Stripe::setApiKey($this->configuration['secret_key'])`.

`decoupled_stripe` (`StripeGateway`) adds:

- **`enable_receipt_email`** (checkbox) — when set, passes `receipt_email = $order->getEmail()` so Stripe
  emails a receipt on success.

`decoupled_stripe_recurring` (`StripeRecurringGateway`) adds:

- **`recurring_start_day`** (select 1–30, default `2`) — day of month billing starts; `getStartDateTimestamp()`
  computes the `trial_end` / first-charge date, guarding month-length overflow.
- **`recurring_plan_id`** (default `commerce_decoupled_stripe_monthly`) — Stripe Plan/Product id; created
  on demand by `getPlan()` (per-unit plan, base amount `100` minor units, `interval: month`).
- **`recurring_plan_name`** (default `Monthly donation`) — human name of the Stripe product/plan.

Config is persisted by Commerce's `commerce_payment_gateway` config entity; the module ships no config
schema file of its own.

## Customer creation (`createPaymentMethod`)

- Anonymous (no owner email) → returns without creating a Stripe customer.
- Otherwise looks up an existing Stripe `Customer` by email (`Customer::all(['limit' => 1, 'email' => …])`),
  updating it, else creates a new one. Billing name/address are copied from the Commerce billing profile.
- Fetch errors are caught and logged (`logger('commerce_decoupled_stripe')`) so payment can still proceed.
- The Commerce payment method is set **non-reusable** (`setReusable(FALSE)`); reusable methods are not
  supported. The resolved Stripe customer id is stashed on `$payment_method->stripe_customer_id` for the
  intent.

## One-off flow (`decoupled_stripe`)

- **`createPayment($payment, $capture = TRUE)`**: asserts state `new`; **returns immediately when
  `$capture` is truthy** (the default). The decoupled client is expected to call it with `$capture = FALSE`,
  which builds `PaymentIntent::create([...])` with:
  - `amount` = `toMinorUnits($payment->getAmount())` — **server-side order amount**, not client-supplied.
  - `currency` from the order total, `payment_method_types: ['card']`, `capture_method: 'automatic'`,
    `metadata.order_id` = `$payment->getOrderId()`, optional `customer` and `receipt_email`.
  - Failures are logged and re-thrown as `DeclineException`.
  - Saves `client_secret` → payment remote id; intent `id` → payment method remote id; sets a placeholder
    `card_type = 'visa'` (overwritten on capture).
- **`capturePayment()`**: `PaymentIntent::retrieve()` by the stored intent id, then decides purely on
  Stripe's status:
  - `canceled` / `requires_payment_method` → `authorization_voided` + `DeclineException`.
  - not `succeeded` → if the payment method is >24h old → `authorization_expired`; else `authorization`
    (both throw `DeclineException` to signal "not yet").
  - `succeeded` → copies card brand/last4/exp from `charges->data[0]`, stores the charge id, sets payment
    `completed`, remote id = intent id.

## Recurring flow (`decoupled_stripe_recurring`)

- **`createPayment`**: requires a Stripe customer (else `DeclineException`); creates a `SetupIntent`
  (`usage: 'off_session'`, `metadata.order_id`), saves its `client_secret`/`id` like the one-off flow.
- **`capturePayment`**: `SetupIntent::retrieve()`; same status branching. On `succeeded` it attaches the
  payment method to the customer, resolves/creates the Stripe `Plan` via `getPlan()`, and creates a
  `Subscription` with `quantity = intval($payment->getAmount()->getNumber())` (e.g. £20 total / £1 base =
  quantity 20), `trial_end` = `getStartDateTimestamp()`, and an explicit `default_payment_method`. Stores
  the subscription id on the payment method and marks the payment `completed`.

## Shared helpers

- **`voidPayment()`**: retrieves the intent (SetupIntent for the recurring gateway, else PaymentIntent);
  only voids statuses `requires_payment_method` / `requires_capture` / `requires_confirmation` /
  `requires_action` (else `PaymentGatewayException`), calls `cancel()`, sets `authorization_voided`.
- **`toMinorUnits()`**: multiplies by 10^2 except for the Stripe zero-decimal currencies
  (`BIF, CLP, DJF, GNF, JPY, KMF, KRW, MGA, PYG, RWF, UGX, VND, VUV, XAF, XOF, XPF`).
- **`__wakeup()`** re-runs `init()` so the SDK key is restored after the plugin is unserialized.
