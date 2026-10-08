<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# basket_paypal — payment plugins & order flow

Two `@BasketPayment` plugins in `src/Plugin/Basket/Payment/` implement
`Drupal\basket\Plugins\Payment\BasketPaymentInterface`:

- **`basket_paypal`** — `BasketPaypal` (class `BasketPaypal`). Classic redirect flow: a Drupal
  form (`PaymentForm`) whose `#action` is PayPal's `approve` link.
- **`basket_paypal_js`** — `BasketPaypalJsSDK`, an empty subclass of `BasketPaypal`; the in-page
  JS SDK Smart-Button flow driven by `ApiPage` (see [../api/routes.md](../api/routes.md)).
  `hook_basket_payment_option_access_alter()` hides `basket_paypal_js` from the standard payment
  option list (it renders inline on the order form instead).

## Payment record service — `PayPal` (`src/PayPal.php`)
CRUD over the `payments_basket_paypal` table:
- `load($params)` — selects by `id`/`nid`/`sid`; if none matches and `amount` is given (or
  `create_new`), inserts a new row (`status: 'new'`, `uid` = current user, `currency` from param
  or `basket_paypal.settings:config.currency`) and returns it.
- `update($payment)` — updates the row by `id`.
- `getConfig()` — returns `basket_paypal.settings:config`, swapping in the `s_*` sandbox
  credentials when `sandbox` is set.
- `client($config)` — returns a built `PaypalServerSdkClient`.

## Plugin lifecycle (`BasketPaypal`)
- `createPayment($entity, $order)` — on order placement creates a payment row via
  `PayPal::load(['nid' => $entity->id(), 'create_new' => TRUE, 'amount' => $order->pay_price,
  'currency' => <iso>])`, returns `payID`. The row is bound to the order node (`nid`) with
  status `new` before any money moves.
- `loadPayment($id)` — returns `['payment' => …, 'isPay' => $payment->status != 'new']`.
- `paymentFormAlter()` — delegates to `PaymentForm::basketPaymentFormAlter()`.
- `basketPaymentPages($pageType)` — renders `result` / `cancel` via `Pages`.
- `settingsFormAlter()` / `formSubmit()` / `getSettingsInfoList()` — per-payment-point admin UI to
  pick the `fin_status` term applied after payment; `updateOrderBySettings()` writes it onto the
  order.

## Redirect order creation — `PaymentForm::basketPaymentFormAlter()`
Builds an `OrderRequestBuilder` with `intent = CAPTURE`, one `PurchaseUnitRequest` carrying
`AmountWithBreakdownBuilder(currency, amount)` (both taken from the **stored payment row**, not the
client) and `referenceId($payment->id)`, plus an `application_context` with return/cancel URLs
(`basket_paypal.pages` `result`/`cancel`). After `ordersCreate()`, the buyer is sent to the PayPal
`approve` link (set as the form `#action`). Alter hooks `basket_paypal_payment_params` and
`basket_paypal_order_params` let other modules mutate the request.

## JS SDK order creation — `PayPalJs::createOrder()` (`src/Services/PayPalJs.php`)
Same server-side build with `intent = CAPTURE`, amount/currency from the payment row,
`referenceId($payment->id)`, return/cancel URLs, then `ordersCreate()`. Stores the payment id in
`$_SESSION['basket_paypal_js_last_pay']` / `basket_paypal_last_pay`. `getCurrency()` maps the
Basket current currency ISO to PayPal's supported set (`PayPalJs::CURRENCY`), falling back to `USD`.

Because the amount and currency always come from the persisted `payments_basket_paypal` row (seeded
from the cart total), the client cannot set the charged price via the create call — it only
supplies buyer contact fields (when JS SDK `validate` is on) and, later, the PayPal order id.
Order-completion/fulfilment happens in the controller/webhook layer — see
[../api/routes.md](../api/routes.md).
