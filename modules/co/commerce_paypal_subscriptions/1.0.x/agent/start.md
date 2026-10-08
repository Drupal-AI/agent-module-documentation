<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paypal Subscriptions (commerce_paypal_subscriptions) — agent index

**Off-site Drupal Commerce payment gateway that turns a Commerce order into a recurring PayPal
subscription using PayPal's modern REST Subscriptions API.** PayPal manages the subscription
lifecycle; the customer approves the subscription in PayPal's Smart Payment Buttons at checkout.

- **Version:** 1.0.0  ·  **Core:** `^10 || ^11`  ·  **Package:** Commerce (contrib)
- **Dependency:** `commerce_paypal` (which pulls in Drupal Commerce / `commerce_payment`). This
  module extends commerce_paypal's `Checkout` gateway, `CheckoutController`, `CheckoutSdk`,
  `CheckoutSdkFactory` and `PaymentOffsiteForm` rather than reimplementing them.
- **No dedicated settings route** and **no permissions/config-schema of its own beyond the
  gateway plugin.** It is configured as a Commerce `commerce_payment_gateway` config entity at
  `/admin/commerce/config/payment-gateways` (permission `administer commerce payment gateway`).

## Payment gateway plugin

`CheckoutSubscriptions` — id **`paypal_checkout_subscriptions`**, label "PayPal Checkout
Subscriptions" (src/Plugin/Commerce/PaymentGateway/CheckoutSubscriptions.php). Extends
commerce_paypal's `Checkout`. Off-site (`offsite-payment` form = `PaymentOffsiteForm`),
`payment_method_types = {paypal_checkout}`, `requires_billing_information = FALSE`, modes
`test` (Sandbox) / `live`. Config form removes the parent `intent` field and adds:

- `dynamic_plans` (checkbox) — generate a PayPal plan per price at checkout.
- `default_subscription_plan` (textfield) — id of a pre-existing PayPal plan (used when
  `dynamic_plans` is off).
- `product_id` (textfield) — PayPal product the dynamic plans belong to.
- `frequency` (select) — `DAY` / `WEEK` / `MONTH` / `YEAR`, interval count fixed at 1.
- `autogenerate_product` (checkbox) — on save, calls PayPal to create a `SERVICE`/`SOFTWARE`
  product and stores the returned `product_id` (`validateConfigurationForm()`).

Credentials (PayPal **client id** + **secret**) come from the parent `Checkout` form.

## Runtime flow (checkout)

1. `commerce_paypal_subscriptions_form_commerce_checkout_flow_alter()` (.module) swaps in this
   module's `SmartPaymentsButtonsBuilder` when the order's gateway is
   `paypal_checkout_subscriptions`. The builder loads the PayPal JS SDK with
   `intent=subscription&vault=true` and wires `createSubscription` / `onApprove` / `onCancel`
   to the module routes (js/paypal-subscriptions.js).
2. **`commerce_paypal_subscriptions.checkout.create`** → `CheckoutController::onCreate()`.
   Resolves the plan id: a static `default_subscription_plan`, or a value set by subscribers of
   the `PaypalSubscriptionCreateEvent` (`commerce_paypal_subscriptions.create`), or a dynamic
   plan from `PlanGenerator`. Stores `paypal_subscription_plan_id` + `paypal_subscription_frequency`
   on the order and returns `{plan_id}` as JSON. Route requires `_entity_access:
   commerce_order.update`.
3. **`commerce_paypal_subscriptions.checkout.approve`** → parent `CheckoutController::onApprove()`
   → this module's `CheckoutSubscriptions::onReturn()`. Requires `_entity_access:
   commerce_order.update` plus the `_paypal_subscription_approve` access check
   (`PaypalSubscriptionApproveAccessChecker`: `orderID` present, `subscriptionID` present and a
   string). `onReturn()` **re-fetches the subscription server-to-server** from PayPal
   (`getSubscription()` → `GET /v1/billing/subscriptions/{id}`), **verifies the returned
   `plan_id` matches the order's stored plan id**, then creates a `completed`
   `commerce_payment` with amount `$order->getTotalPrice()` (server-derived), `remote_id` = the
   subscription id, `remote_state` = the PayPal status.

## Key classes / services

| Purpose | Class / service |
|---|---|
| Gateway plugin | `Plugin/Commerce/PaymentGateway/CheckoutSubscriptions` (`paypal_checkout_subscriptions`) |
| Create/approve routes | `Controller/CheckoutController` (extends commerce_paypal's) |
| Approve access guard | `Access/PaypalSubscriptionApproveAccessChecker` (`_paypal_subscription_approve`) |
| Smart Payment Buttons render | `SmartPaymentsButtonsBuilder` (service `…smart_payment_buttons_builder`) |
| PayPal REST calls | `CheckoutSdk` (adds `getSubscription`, `createProduct`, `createSubscriptionPlan`, `getProducts`) via `CheckoutSdkFactory` |
| Dynamic plan create/cache | `PlanGenerator` (service `…plan_generator`; caches by gateway+price+frequency in keyvalue `commerce_paypal_subscriptions.plans`) |
| Frequency value object | `Model/Frequency` |
| Extension point | `Event/PaypalSubscriptionCreateEvent` + `Event/PaypalSubscriptionEvents::SUBSCRIPTION_CREATE` |
| Offsite form | `PluginForm/Checkout/PaymentOffsiteForm` |

## Extending

Subscribe to `PaypalSubscriptionEvents::SUBSCRIPTION_CREATE`
(`commerce_paypal_subscriptions.create`) and call `$event->setPlanId(...)` to supply a custom
plan id per order (has access to the order and `Frequency`).

## Security / integration notes

- Both module routes require `commerce_order.update` entity access (order owner); the approve
  route additionally runs `PaypalSubscriptionApproveAccessChecker`. There is **no unauthenticated
  webhook route** — entitlement is granted only through the authenticated approve flow.
- `onReturn()` **re-fetches the subscription from PayPal's merchant-authenticated API**, binds
  the subscription's `plan_id` to the order before completing payment, and uses the server-side
  order total as the amount. TLS is handled by commerce_paypal's shared Guzzle client. Store the
  PayPal **client id / secret as secrets**, restrict `administer commerce payment gateway`, and
  confirm **sandbox vs live** before go-live.
- **Recurring renewals:** this module records the initial approval as a Commerce payment; it does
  not itself ingest PayPal's ongoing renewal notifications, so downstream recurring bookkeeping is
  handled outside the checkout flow.

## Limitation (evaluation)

Live PayPal calls need real credentials and outbound network access. In sandbox/dev you can
create and introspect the **gateway config entity** (plugin id + mode + credentials + plan
settings) but cannot complete a real subscription.
