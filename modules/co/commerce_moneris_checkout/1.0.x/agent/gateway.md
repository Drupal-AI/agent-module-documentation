<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MonerisCheckout gateway plugin — config, ticket preload, receipt confirmation

Class `Drupal\commerce_moneris_checkout\Plugin\Commerce\PaymentGateway\MonerisCheckout`
(`src/Plugin/Commerce/PaymentGateway/MonerisCheckout.php`), extends `OffsitePaymentGatewayBase`,
implements `MonerisCheckoutInterface`. Plugin id **`moneris_checkout`**. Offsite form
`MonerisCheckoutForm`.

## Enable & add the gateway

```bash
composer require drupal/commerce_moneris_checkout -W   # pulls smmccabe/moneris
drush en commerce_moneris_checkout -y
```
Add at **Commerce → Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`),
choose plugin **Moneris Checkout**. No settings route of its own; configured through the standard
payment-gateway entity form.

## Configuration fields (`defaultConfiguration()` / `buildConfigurationForm()`)

Config object: `commerce_payment.commerce_payment_gateway.plugin.moneris_checkout` (schema in
`config/schema/commerce_moneris_checkout.schema.yml`).

| Key | Form element | Default | Notes |
|-----|--------------|---------|-------|
| `mode` | (base) select, relabeled **"Environment"** | — | options `qa` = *Testing*, `prod` = *Production* |
| `store_id` | textfield, required | `''` | Moneris store id |
| `api_token` | textfield, required | `''` | Moneris API token |
| `checkout_id` | textfield, required | `''` | Moneris Checkout profile id (e.g. `chkt…`) |
| `country_code` | select | `CA` | `CA` Canada / `US` |
| `order_number_strategy` | radios | `order_id` | `order_id`, `order_id_timestamp`, `order_number` |
| `api_logging` | checkboxes | both on (`request`, `response`) | debug-logs API request/response bodies |

`create()` also derives a 20-char `dynamicDescriptor` from `system.site` name and injects
`event_dispatcher`, `http_client`, and the `logger.channel.commerce_moneris_checkout` channel
(defined in `commerce_moneris_checkout.services.yml`).

### Order-number strategy (`getOrderNumber()`)
- `order_id` → `$order->id()`.
- `order_id_timestamp` → `id-<requestTime>` (recommended during testing to dodge Moneris
  duplicate-order-number errors).
- `order_number` → generates the Commerce number pattern early (via the order type's
  `NumberPattern`), else falls back to the id. `onReturn()` sets `$order->setOrderNumber()` from the
  stored MCO `order_no` when this strategy is used.

## Ticket preload (`MonerisCheckoutForm::getTicket()`)

On the Payment step, `getTicket()` returns any ticket already stored on the order
(`$order->getData('moneris_checkout')`), else POSTs an `action=preload` body — store_id, api_token,
checkout_id, `txn_total` = `number_format($payment->getAmount()->getNumber(), 2)` (server-side),
`order_no` (from the strategy), `cust_id`, `dynamic_descriptor`, `cart` (subtotal/tax/items, each
item url/description/product_code/unit_cost/quantity), and contact/shipping/billing details built
from the order's **billing** profile — to `<gateway>/chktv2/request/request.php`. On
`success === 'true'` the returned `ticket` and `order_no` are saved to the order's
`moneris_checkout` data and the order is saved; failure throws `PaymentGatewayException`. The cart
array is passed through the `MCO_SHOPPING_CART_READY` event before sending (see [events.md](events.md)).
Tax is currently an empty placeholder (`getTaxInformation()` returns blanks).

`buildConfigurationForm()` attaches library `commerce_moneris_checkout/moneris_checkout` plus the
per-mode remote Moneris library, and passes `ticket`, `mode`, `div`, `return_url`, `cancel_url` to
`drupalSettings.commerceMonerisCheckout`. `js/commerce_moneris_checkout.js` starts Moneris's
`monerisCheckout()` widget and, on its `payment_complete` / `cancel_transaction` / `error_event` /
bad-`page_loaded` callbacks, redirects the browser to the Commerce return/cancel URL with
`?ticket&response_code&response_state`.

## API transport (`apiRequest()` / `getCheckoutGateway()`)

`apiRequest()` POSTs `Json::encode($body)` via the injected Guzzle `http_client` to
`getCheckoutGateway() . '/chktv2/request/request.php'`. Gateway host is a **hardcoded constant** by
mode: `https://gatewayt.moneris.com` (qa) or `https://gateway.moneris.com` (prod) — no
request-derived URL. Default Guzzle TLS verification applies (not disabled). When `api_logging`
is enabled the request and response bodies are written to the module log channel at `debug`.

## Confirmation (`onReturn()`) — the trust boundary

1. Reads `$request->query` (ticket, response_code, response_state); unsets the order's
   `moneris_checkout` data so a fresh ticket is issued on any retry.
2. Requires all three params present, and `response_code === MonerisCheckoutResponseCodes::…SUCCESS`
   (`'001'`, strict `!==`) else `PaymentGatewayException`.
3. **`getReceipt($ticket)`** POSTs `action=receipt` with store_id/api_token/checkout_id/ticket to
   Moneris (authenticated), requires `response.success === 'true'` and
   `response.receipt.result === 'a'` (approved — else `HardDeclineException`), and returns
   `receipt.cc`.
4. **Binds** the receipt to this order: rejects unless the order's stored `order_no` equals the
   receipt `order_no`.
5. Creates a `commerce_payment`: state `completed` when `response_state == 'complete'` else
   `authorization`; **`amount = $order->getBalance()` (server-side)**; `remote_id` =
   receipt `reference_no`; `remote_state` = response_state.

`onCancel()` reads response_state, shows a resumable-cancel message (dispatching
`MCO_TRANSACTION_CANCEL`) or a checkout-error message, and unsets the order's MCO data. It records
no payment.

`getReceipt()` is public on the interface; `MonerisCheckoutResponseCodes` also defines `902`
(3-D Secure failed), `2001` invalid ticket, `2002` ticket re-use, `2003` ticket expired — Moneris
itself rejects ticket reuse/expiry server-side.
