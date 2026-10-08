<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# basket_paypal — routes, controllers & webhook

Defined in `basket_paypal.routing.yml`. The two admin forms are covered in
[../config/settings.md](../config/settings.md); this doc covers the runtime endpoints.

## `basket_paypal.pages` → `/basket_paypal/{page_type}` (`Pages::pages`)
Permission `access content`. `page_type` selects the branch:

- **`pay`** — loads the payment by `?pay_id` and, only when `status == 'new'`, renders
  `PaymentForm` (the redirect "Pay" button); otherwise 404.
- **`result`** — renders the localized success message (`config.success[langcode]`) via the
  `basket_paypal_pages` theme.
- **`cancel`** — renders a "No payment data." notice.
- **`webhook`** — PayPal event receiver. Reads `$_POST` (or the raw JSON body) and switches on
  `event_type`:
  - `CHECKOUT.ORDER.APPROVED` → `updateOrderInfo()` then, if `resource.id` present, calls
    `ordersCapture()` server-side to capture the approved order.
  - `PAYMENT.CAPTURE.COMPLETED` → takes
    `resource.supplementary_data.related_ids.order_id`, then **re-fetches** the order with
    `ordersGet()` and only when the fetched `status === 'COMPLETED'` maps `referenceId` back to the
    local payment (via `explode('-', referenceId)[0]`), sets it `COMPLETED` + `paytime`, and calls
    `Basket::paymentFinish($payment->nid)`.
  - `CHECKOUT.ORDER.COMPLETED` → `updateOrderInfo()`.
  - `updateOrderInfo($data, $type)` maps `resource.purchase_units[0].reference_id` to a local
    payment, stores the event under the payment's `data`, sets `paytime` and
    `status = resource.status`, and — when the payment has an `nid` and status `COMPLETED` — calls
    `Basket::paymentFinish($payment->nid)` to finish the order.

## `basket_paypal.api` → `/paypal-api/{page_type}` (`ApiPage::page`)
Permission `access content`. Drives the JS SDK Smart Buttons (AJAX/JSON):

- **`create`** — reads the POSTed order-form values; when JS SDK `validate` is on, programmatically
  builds and validates the Basket `basket_order` node form and returns the re-rendered form on
  error, otherwise computes the cart total (converting currency to the PayPal ISO), calls
  `PayPalJs::createOrder()`, persists the returned PayPal order JSON/status onto the payment row,
  and returns `{"payPalOrderId": <id>}`.
- **`capture`** — reads the JSON body's `orderID`, creates/saves the `basket_order` node from the
  request query params, binds the session's payment row to that node (`nid`), then **re-fetches**
  the order server-side with `ordersGet(['id' => orderID])`, stores the returned status (setting
  `paytime` when `APPROVED`), and finalizes the Basket order (`Entity::insertOrder()` +
  `Basket::paymentFinish()`), redirecting to `basket_paypal.pages/result`.

## Supporting pieces
- **Service factory**: `Pages`, `ApiPage`, `PaymentForm` all pull the `PayPal`/`PayPalJs`/`Basket`
  services from the container in their constructors.
- **Order id ↔ payment id**: PayPal `reference_id` is the local payment row `id` (`referenceId(
  $payment->id)`), so webhook/capture handlers recover the payment by splitting on `-` and taking
  the first segment.
- **Data stored**: each payment row's `data` column holds the serialized PayPal order/event JSON
  for audit; `status` mirrors the last PayPal status string seen; `paytime` is the fulfil time.
- **Theme/JS**: `misc/js/js_sdk.js` renders the Smart Buttons and calls `create`/`capture`;
  templates `basket-paypal-buttons.html.twig` and `basket-paypal-pages.html.twig`.
