<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `viabill_payments` payment gateway plugin

File: `src/Plugin/Commerce/PaymentGateway/ViaBillPayments.php`. Class `ViaBillPayments` extends
`OffsitePaymentGatewayBase` and implements `SupportsRefundsInterface`, `SupportsVoidsInterface`.

```
@CommercePaymentGateway(
  id = "viabill_payments",
  label / display_label = "ViaBill Payments",
  forms = {
    "offsite-payment" = ViaBillPaymentsForm,
    "capture-payment" = CapturePaymentForm,
  },
  payment_type = "payment_default",
)
```

## Enable & add the gateway

1. `drush en viabill_payments -y` (pulls `commerce`, `commerce_payment`, `commerce_log`).
2. Add a gateway at **`/admin/commerce/config/payment-gateways/add`**, choose plugin
   *ViaBill Payments*, pick **Mode** (test/live) and enter credentials (see
   [../configure/settings.md](../configure/settings.md)).

Note: `ViaBillHelper::__construct()` loads the gateway entity by the **hardcoded id
`viabill_payments`** to read mode/credentials for API calls and callback verification. Keeping the
gateway's machine name `viabill_payments` is what the callback path and helper rely on.

## Dependency injection quirk

- `__construct()` deliberately assigns **no** services (comment: "Do NOT assign any custom services
  here!"). `create()` calls the parent then assigns only `$this->configFactory`.
- Most helper logic is done by `new ViaBillHelper()` / `new ViaBillGateway()` created ad hoc inside
  methods rather than injected.

## defaultConfiguration()

`api_key ''`, `api_secret ''`, `viabill_pricetag ''`,
`transaction_type = ViaBillConstants::TRANSACTION_TYPE_AUTHORIZE_ONLY` (`'authorize_only'`),
plus parent defaults (`mode`, `display_label`, etc.). PriceTag keys (country, language,
alignment, width, auto…) are read with `?? default` and only persisted on submit.

## Configuration form

`buildConfigurationForm()` renders four groups: **ViaBill Account Credentials** (`api_key`
textfield, `api_secret` password — masked/optional when one is already stored, `viabill_pricetag`
textarea), **ViaBill Payments Preferences** (`transaction_type` select: Authorize Only /
Authorize and Capture), and **PriceTags** (country, language, and per-context product/cart/checkout
alignment, width, dynamic-price selector/trigger, "apply automatically"; the checkout auto select
is `#disabled`). When credentials exist it calls `ViaBillGateway::myViabill()` and
`::notifications()` to show a myViaBill link and any account messages; `checkPriceTagPresenceAndActions()`
inspects the core/theme Twig templates to tell the merchant where to paste the PriceTag snippet.

`validateConfigurationForm()` requires `api_key`, requires `api_secret` unless one is already
stored, requires `viabill_pricetag` and checks it contains `<script`.

`submitConfigurationForm()` saves the values into the plugin configuration **and** mirrors the
credentials + PriceTag options into the `viabill_payments.settings` config object (via
`\Drupal::service('config.factory')->getEditable(...)`) so the module's presentation hooks can read
the PriceTag script. An empty secret means "keep the stored one".

## Payment lifecycle methods

- **`createPayment()`** — sets state `new` and saves (the real payment entity is created by the
  callback controller, not here).
- **`buildPaymentOperations()`** — adds a `Capture` operation (form `capture-payment`) when the
  payment state is `authorization` or `partially_captured`.
- **`capturePayment($payment, $amount = NULL)`** — asserts state in `authorization`/
  `partially_captured`; caps the amount at the remaining authorized amount; calls
  `ViaBillGateway::captureTransaction(['id'=>remote_id,'apikey'=>…,'amount'=>negative,'currency'=>…])`.
  On success updates the running captured total (stored in **order data key
  `viabill_captured_amounts`** keyed by payment id via `getCapturedAmount()`/`setCapturedAmount()`),
  then sets state `completed` (full) or `partially_captured` (partial, plus a `viabill_partial_capture`
  commerce_log entry). Uses `$this->time->getRequestTime()` for completed time (the 2.1.0 fix).
- **`voidPayment($payment)`** — asserts `authorization`; calls
  `ViaBillGateway::cancelTransaction(['id','apikey','currency'])`; sets state `voided`.
- **`refundPayment($payment, $amount = NULL)`** — asserts `completed`/`partially_refunded`/
  `partially_captured`; calls `ViaBillGateway::refundTransaction(['id','apikey','amount','currency'])`;
  sets `partially_refunded` or `refunded` and records the refunded amount.
- **`onReturn($order, $request)`** — effectively a no-op: it only computes a canonical redirect URL
  and does not complete the payment (completion happens in the callback). **`onCancel()`** adds a
  message and redirects to `commerce_cart.page`.

`CapturePaymentForm` (`src/PluginForm/CapturePaymentForm.php`) renders a `commerce_price` amount
field defaulting to the remaining capturable amount and, on submit, calls
`capturePayment($payment, $amount)`. It reaches the plugin's protected `getCapturedAmount()` via
`ReflectionClass` (`setAccessible(TRUE)`).

## The checkout redirect

The `offsite-payment` form `ViaBillPaymentsForm` builds and signs the checkout request and redirects
the browser to ViaBill — documented in [../api/callback-flow.md](../api/callback-flow.md).

## Screenshot

Add-gateway form with the ViaBill plugin selected (credentials, transaction type, PriceTags):

![ViaBill add payment gateway form](../../../../../../../screenshots/viabill_payments/2.1.x/add-gateway-viabill.png)
